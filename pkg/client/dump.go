package client

import (
	"bytes"
	"errors"
	"fmt"
	"io"
	"net/url"
	"os/exec"
	"regexp"
	"strings"
)

var (
	unsupportedDumpOptions = []string{
		"search_path",
	}
)

// Dump represents a database dump
type Dump struct {
	Table string
}

// CanExport returns true if database dump tool could be used without an error
func (d *Dump) CanExport() bool {
	return exec.Command("gs_dump", "--version").Run() == nil
}

// Export streams the database dump to the specified writer
func (d *Dump) Export(connstr string, writer io.Writer) error {
	if str, err := removeUnsupportedOptions(connstr); err != nil {
		return err
	} else {
		connstr = str
	}

	username, password, err := parse_user_info(connstr)
	if err != nil {
		return err
	}

	errOutput := bytes.NewBuffer(nil)

	opts := []string{
		"openGauss",    // the database of which the table belongs
		"-U", username, // the username gs_dump used to connect
		"-W", password, // the password. CAUSION: password is set in initdb.sql
		"--no-owner",
		"--clean", // clean (drop) database objects before recreating
	}

	if d.Table != "" {
		opts = append(opts, []string{"--table", d.Table}...)
	}

	cmd := exec.Command("gs_dump", opts...)
	cmd.Stdout = writer
	cmd.Stderr = errOutput

	if err := cmd.Run(); err != nil {
		return fmt.Errorf("error: %s. output: %s", err.Error(), errOutput.Bytes())
	}
	return nil
}

func parse_user_info(input string) (string, string, error) {
	reg := regexp.MustCompile(`(\w+)://(\w+):(\w+)`)
	match := reg.FindStringSubmatch(input)
	if len(match) < 4 {
		return "", "", errors.New("can not parse user name and password")
	}

	return match[2], match[3], nil
}

// removeUnsupportedOptions removes any options unsupported for making a db dump
func removeUnsupportedOptions(input string) (string, error) {
	uri, err := url.Parse(input)
	if err != nil {
		return "", err
	}

	q := uri.Query()
	for _, opt := range unsupportedDumpOptions {
		q.Del(opt)
		q.Del(strings.ToUpper(opt))
	}
	uri.RawQuery = q.Encode()

	return uri.String(), nil
}
