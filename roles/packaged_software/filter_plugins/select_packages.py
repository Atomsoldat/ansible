OS_FAMILIES = {
    'Ubuntu': 'Debian',
    'Debian': 'Debian',
    'Archlinux': 'Archlinux',
}


class FilterModule(object):
    ''' Custom filter to select OS-specific or generic package names '''
    def filters(self):
        return {
            'select_package_names': self.select_package_names
        }

    def select_package_names(self, packages_dict, distro):
        """Select package names with distro-specific overrides.

        Lookup order for each package:
        1. Exact distro match (e.g. 'Ubuntu')
        2. OS family fallback (e.g. 'Debian' when distro is 'Ubuntu')
        3. The generic name (the dict key)
        """
        os_family = OS_FAMILIES.get(distro, distro)
        result = []
        for key, value in packages_dict.items():
            if isinstance(value, dict):
                if distro in value:
                    result.append(value[distro])
                elif os_family in value:
                    result.append(value[os_family])
                else:
                    result.append(key)
            else:
                result.append(key)
        return result
