deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

module.exports =
        version: 1
        slug: 'heltec-m2808'
        name: 'Heltec-M2808'
        arch: 'aarch64'
        state: 'new'

        instructions: commonImg.instructions

        gettingStartedLink:
                windows: 'https://www.balena.io/docs/learn/getting-started/rockpro64/nodejs/'
                osx: 'https://www.balena.io/docs/learn/getting-started/rockpro64/nodejs/'
                linux: 'https://www.balena.io/docs/learn/getting-started/rockpro64/nodejs/'

        options: [ networkOptions.group ]

        yocto:
                machine: 'heltec-m2808'
                image: 'balena-image'
                fstype: 'balenaos-img'
                version: 'yocto-kirkstone'
                deployArtifact: 'balena-image-heltec-m2808.balenaos-img'
                compressed: true

        configuration:
                config:
                        partition: 1
                        path: '/config.json'

        initialization: commonImg.initialization
