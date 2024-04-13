import QtQuick
import QtQuick.Controls as QC2
import QtQuick.Layouts as QtLayouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

QtLayouts.ColumnLayout {
    id: generalPage

    signal configurationChanged

    property alias cfg_middleButtonCommand: middleButtonCommand.text
    property alias cfg_desktopWrapOn      : desktopWrapOn.checked
    property alias cfg_spacingFactor      : spacingSlider.value
    property alias cfg_dotSizeCustom      : dotSizeCustom.value

    Kirigami.FormLayout {

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Middle click command:")
            QC2.TextField {
                id: middleButtonCommand
            }
        }
    
        Item {
            Kirigami.FormData.isSection: true
        }
        QtLayouts.ColumnLayout {
            Kirigami.FormData.label: i18n("Navigation behaviour:")
            Kirigami.FormData.buddyFor: desktopWrapOn
            QC2.CheckBox {
                id: desktopWrapOn
                text: i18n("Wraparound")
            }
        }
        QtLayouts.ColumnLayout{
            Kirigami.FormData.label: i18n("Spacing radius:")
            Kirigami.FormData.buddyFor: radiusSlider
            QC2.Slider {
                id: spacingSlider
                enabled: highlightOnActive.checked
                height: 30
                from: 0
                to: 1
                stepSize: 0.1
            }
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Indicator Size:")
            QC2.SpinBox {
                id: dotSizeCustom
                textFromValue: function(value) {
                    return i18n("%1 px", value)
                }
                valueFromText: function(text) {
                    return parseInt(text)
                }
                from: 6
                to: 72
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Horizontal Spacing:")

            QC2.SpinBox {
                id: spacingHorizontal
                textFromValue: function(value) {
                    return i18n("%1 px", value)
                }
                from: 0
                to: 30
            }
        }
    }
}
