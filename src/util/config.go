package util

import (
	"time"

	"github.com/spf13/viper"
)

// Config stores all configuration of the application.
// The values are read by viper from a config file or environment variable.
type Config struct {
	Environment   string `mapstructure:"ENVIRONMENT"`
	DBSource      string `mapstructure:"DB_SOURCE"`
	MigrationURL  string `mapstructure:"MIGRATION_URL"`
	ServerAddress string `mapstructure:"SERVER_ADDRESS"`
	// TokenSymmetricKey   string        `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	AccessTokenDuration time.Duration `mapstructure:"ACCESS_TOKEN_DURATION"`
	Domain              string        `mapstructure:"DOMAIN"`

	FirebaseProjectID string `mapstructure:"FIREBASE_PROJECT_ID"`

	GRPCPort           uint `mapstructure:"GRPC_PORT"`
	HTTPJSONServerPort uint `mapstructure:"HTTP_JSON_SERVER_PORT"`

	DisableJWTAuth bool `mapstructure:"DISABLE_JWT_AUTH"`
}

// LoadConfig reads configuration from file or environment variables.
func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName(".env")
	viper.SetConfigType("env")

	viper.AutomaticEnv()

	err = viper.ReadInConfig()
	if err != nil {
		return
	}

	err = viper.Unmarshal(&config)
	return
}