# OpenShift Cartridge Lint

The OpenShift Cartridge Lint is an utility which helps developers to test
the validity and syntax of the cartridge metadata.

In future this command will be expanded to provide more functionality, but for
now you can use it to validate the cartridge 'manifest.yml' file to make sure
you haven't missed some required attribute or you not made the syntax error.

## Using oo-cartridge-lint

### Dependencies:

* [kwalify](http://www.kuwata-lab.com/kwalify)
* [commander](http://visionmedia.github.io/commander)

(Don't worry, these dependencies are installed automatically for you)

### Installation:

```
$ gem install oo-cartridge-lint
```

(the Fedora/RHEL packages are TBD)

### Usage:

To check your current cartridge, you can run the following command:

```
$ cd cartridge-dir/
$ oo-cartridge-lint manifest
```

The output should tell you if your manifest.yml has correct syntax or not. The
sample output might look like this:

```
 ~/code/openshift-origin-cartridge-ruby → oo-cartridge-lint manifest --file metadata/manifest.yml.rhel
[openshift-origin-cartridge-ruby/metadata/manifest.yml.rhel] INVALID
  [/] - key 'Description:' is required.
  [/Architecture] - 'arm': invalid Architecture value.
```

(Note: The --file option is optional, by default the command will check the `metadata/manifest.yml` path.
