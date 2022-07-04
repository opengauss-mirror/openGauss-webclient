package command

const (
	// Version is the current openGauss-webclient application version
	Version = "1.0.1"
)

var (
	// GitCommit contains the Git commit SHA for the binary
	GitCommit string

	// BuildTime contains the binary build time
	BuildTime string

	// GoVersion contains the build time Go version
	GoVersion string
)
