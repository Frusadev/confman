# confman
Confman, a simple configuration file manager
### Problems to be solved
- App config change
- App config naming (the ability to name configurations, like a version control system)
- App config retrieve by name (the ability to retrieve configurations from the name of the version given to it)
- Or just the ability to retrieve the default config
- A cfc file for configuring the paths and behavior of the configs
- Eventually a custom scripting language.

### The overall workings.
Confman has two modes, `command mode` which simply implies that you communication with it through commands and `tui mode`  which features a terminal graphical interface.
#### Command list:
- `set-config "application config path"` this will ask a few other questions for setting up confman. This command will return a string which will be the config_id for that app, that config_id will simply be the name that you'll give to the app.
- `add-confv $config_id "new config path"` this will just add another version of configuration for that application.
- `backup $config_id "backup folder"` This will just bakcup the configs for the app in the given folder.
- `restore-from "bakcup folder" $config_id` This command will restore config_id app from the backup folder .

_Note: The TUI mode will have similar controls._

_**--------**_

_This project is still under development, bugs might often occur_
