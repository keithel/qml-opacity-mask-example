# Opacity Mask Example for Qt 6.5+ and Qt 5.15

This provides the classic Qt GraphicalEffects OpacityMask example shown in docs
as a full CMake project.

It provides some best practices for writing CMake projects that are compatible
with both Qt 5 and Qt 6.

## Qt 6

For Qt 6, this builds a QML module, with the images and QML being encapsulated
as a QML module, which is loaded into the QML engine using
`engine.loadFromModule`.

## Qt 5

For Qt 5, this packages the QML and images in a Qt Resource file, packaged with
the application. It loads the QML and images using the Qt resource system.
