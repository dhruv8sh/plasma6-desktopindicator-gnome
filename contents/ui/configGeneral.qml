import QtQuick
import QtQuick.Controls as QC2
import QtQuick.Layouts as QtLayouts
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls
import org.kde.plasma.plasmoid
import QtQuick.Layouts

QtLayouts.ColumnLayout {
    id: generalPage

    signal configurationChanged

    property alias cfg_middleButtonCommand: middleButtonCommand.text
    property alias cfg_desktopWrapOn      : desktopWrapOn.checked
    property alias cfg_spacingFactor      : spacingSlider.value
    property alias cfg_dotSizeCustom      : dotSizeCustom.value
    property alias cfg_customColorsEnabled: customColorsEnabled.checked
    property alias cfg_activeColor        : activeColor.color
    property alias cfg_activeSizeH  : activeSizeOffsetH.value
    property alias cfg_activeSizeW  : activeSizeOffsetW.value

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
            Kirigami.FormData.buddyFor: spacingSlider
            QC2.Slider {
                id: spacingSlider
                height: 30
                from: 0
                to: 20
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
                from: 6
                to: 72
            }
            QC2.Label {
                text: "px."
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Active Indicator:")
            QC2.SpinBox {
                id: activeSizeOffsetW
                from: 1
                to: 100
            }
            QC2.Label {
                text: "x"
            }
            QC2.SpinBox {
                id: activeSizeOffsetH
                from: 1
                to: 100
            }
            QC2.Label {
                text: "px."
            }
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        QC2.CheckBox {
            id: customColorsEnabled
            Kirigami.FormData.label: i18n("Custom colors:")
        }
        RowLayout{
            KQuickControls.ColorButton {
                id: activeColor
                enabled: customColorsEnabled.checked
            }
            QC2.Label {
                text: "Active Color"
            }
        }
    }
}
