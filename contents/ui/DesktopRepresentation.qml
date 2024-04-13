import QtQuick
import org.kde.plasma.components
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
// import QtQml.Models
// import org.kde.taskmanager as TaskManager

Rectangle {
    id: container
    z: 5
    height: plasmoid.configuration.dotSizeCustom
    property int pos
    property int size: plasmoid.configuration.dotSizeCustom
    property bool boldOnActive: plasmoid.configuration.boldOnActive
    property bool italicOnActive: plasmoid.configuration.italicOnActive
    property bool highlightOnActive: plasmoid.configuration.highlightOnActive
    property bool isAddButton: false
    property bool isActive: false
    color: Kirigami.Theme.highlightColor
    radius: height * 0.5
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: isAddButton ? pagerModel.addDesktop() : pagerModel.changePage(pos)
        onContainsMouseChanged: {
            if( containsMouse ) container.opacity = 0.3
            else container.opacity = isActive ? 1 : 0.5
        }
    }

    Behavior on width {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on x {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 300
        }
    }

    function activate(yes, to) {
        isActive = yes
        container.states = yes ? "bigger" : "default"
        opacity = yes ? 1 : 0.5
        width  = yes && isHorizontal  ? size * 2 : size
        height = yes && !isHorizontal ? size * 2 : size
        x = pos * height * 1
        if( to < pos ) x = (pos+1) * height * 1
        // console.log(to+" "+(to<=pos ? pos: pos+1)+" "+x)
    }
}
