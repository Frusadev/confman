# ConfMan
**ConfMan: A Simple Configuration File Manager**

### Problems to be Solved
- **App Configuration Changes**: Easily update application configurations.
- **App Configuration Naming**: Assign names to configurations, similar to version control systems.
- **Retrieve Configurations by Name**: Fetch configurations using their assigned names.
- **Default Configuration Retrieval**: Quickly retrieve the default configuration.
- **Configuration File (`.cfc`)**: Configure paths and behavior for managing configs.
- **Custom Scripting Language**: Integrate a custom scripting language in future versions.

### Overall Functionality
ConfMan operates in two modes:
- **Command Mode**: Interact with ConfMan through commands.
- **TUI Mode**: Use a terminal graphical interface.

#### Command List
- `set-config "application config path"`: Sets up ConfMan for an application, returning a `config_id` (the name you give to the app).
- `add-confv $config_id "new config path"`: Adds a new version of the configuration for the application.
- `backup $config_id "backup folder"`: Backs up the application's configurations to the specified folder.
- `restore-from "backup folder" $config_id`: Restores the application's configuration from the backup folder.

> **Note:** The TUI mode will feature similar controls.

---

_This project is still under development; bugs might occur frequently._
