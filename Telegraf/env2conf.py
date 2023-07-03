import os
import sys

def replace_vars_in_conf(input_config, output_config,prefix):
    # Get all environment variables
    env_vars = os.environ

    with open(input_config, 'r') as file:
        conf_content = file.read()
        # Loop through environment variables
        for var_name, var_value in env_vars.items():
            # Check if variable starts with "TELEGRAF_"
            if var_name.startswith(prefix):
                # Remove "TELEGRAF_" portion from the variable name
                conf_var_name = var_name.replace(prefix, '')

                # Replace the variable in telegraf.conf if found
                if conf_var_name in conf_content:
                    conf_content = conf_content.replace(conf_var_name, var_value)

                # Write the modified contents back to telegraf.conf
    with open(output_config, 'w') as file:
        file.write(conf_content)

# replace_vars_in_conf('/etc/telegraf/telegraf.conf', '/tmp/telegraf.conf', "TELEGRAF_")
if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python env2conf.py source_config_file target_config_file prefix")
    else:
        source_config_file = sys.argv[1]
        target_config_file = sys.argv[2]
        prefix = sys.argv[3]

        replace_vars_in_conf(source_config_file, target_config_file, prefix)