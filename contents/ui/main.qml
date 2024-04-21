import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.pager
import org.kde.kcmutils as KCM
import org.kde.config as KConfig

PlasmoidItem {

    id: root
    preferredRepresentation: fullRepresentation
    property alias current: pagerModel.currentPage
    property int wheelDelta: 0
    property int size: plasmoid.configuration.dotSizeCustom
    property real spacing: plasmoid.configuration.spacingFactor
    property bool isHorizontal: plasmoid.formFactor != PlasmaCore.Types.Vertical
    property bool wrapOn: plasmoid.configuration.desktopWrapOn

    Item {
        id: grid
        anchors.fill: parent
        anchors.centerIn: parent
        Repeater {
            id: repeater1
            model: pagerModel.count
            DesktopRepresentation {
                pos: index
                height: size
                width: size

            }
        }
    }
    anchors.fill: parent
    Layout.minimumWidth  :  isHorizontal ? (pagerModel.count-1) * (size + spacing) + plasmoid.configuration.activeSizeW + spacing : grid.implicitWidth
    Layout.minimumHeight : !isHorizontal ? (pagerModel.count-1) * (size + spacing) + plasmoid.configuration.activeSizeH + spacing : grid.implicitHeight


    PagerModel {
        id: pagerModel
        enabled: true
        showDesktop: plasmoid.configuration.currentDesktopSelected == 1
        screenGeometry: plasmoid.containment.screenGeometry
        pagerType: PagerModel.VirtualDesktops
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton
        onClicked: perform( plasmoid.configuration.middleButtonCommand )
        onWheel : wheel => {
            wheelDelta += wheel.angleDelta.y || wheel.angleDelta.x;
            let increment = 0;
            while (wheelDelta >= 120) {
                wheelDelta -= 120;
                increment++;
            }
            while (wheelDelta <= -120) {
                wheelDelta += 120;
                increment--;
            }
            while (increment !== 0) {
                if (increment < 0) {
                    const nextPage = wrapOn? (current + 1) % pagerModel.count :
                        Math.min(current + 1, pagerModel.count - 1);
                    pagerModel.changePage(nextPage);
                } else {
                    const previousPage = wrapOn ? (pagerModel.count + current - 1) % pagerModel.count :
                        Math.max(current - 1, 0);
                    pagerModel.changePage(previousPage);
                }

                increment += (increment < 0) ? 1 : -1;
                wheelDelta = 0;
            }
        }
    }
    function perform(input) {
        executable.exec('qdbus org.kde.kglobalaccel /component/kwin invokeShortcut \"'+input+'\"')
    }
    Plasma5Support.DataSource {
        id: "executable"
        engine: "executable"
        connectedSources: []
        onNewData:function(sourceName, data){
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            // console.log(data+" received after running "+ sourceName)
            disconnectSource(sourceName)
        }
        function exec(cmd) {
            connectSource(cmd)
        }
    }
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Add Virtual Desktop")
            icon.name: "list-add"
            visible: !root.isActivityPager && KConfig.KAuthorized.authorize("kcm_kwin_virtualdesktops")
            onTriggered: pagerModel.addDesktop()
        },
        PlasmaCore.Action {
            text: i18n("Remove Virtual Desktop")
            icon.name: "list-remove"
            visible: !root.isActivityPager && KConfig.KAuthorized.authorize("kcm_kwin_virtualdesktops")
            enabled: repeater1.count > 1
            onTriggered: pagerModel.removeDesktop()
        },
        PlasmaCore.Action {
            text: i18n("Configure Virtual Desktops…")
            visible: !root.isActivityPager && KConfig.KAuthorized.authorize("kcm_kwin_virtualdesktops")
            onTriggered: KCM.KCMLauncher.openSystemSettings("kcm_kwin_virtualdesktops")
        }
    ]
}
