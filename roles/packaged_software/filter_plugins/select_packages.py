class FilterModule(object):
    ''' Custom filter to select OS-specific or generic package names '''
    def filters(self):
        return {
            'select_package_names': self.select_package_names
        }

    def select_package_names(self, packages_dict, os_family):
        # start with an empty list
        result = []
        for key, value in packages_dict.items():
            # If value is a dict and an OS-specific name exists, use it
            if isinstance(value, dict) and os_family in value:
                result.append(value[os_family])
            else:
                # Use the generic package name (the key)
                result.append(key)
        return result
