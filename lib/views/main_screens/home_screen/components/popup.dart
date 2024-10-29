import 'package:flutter/material.dart';

import '../../../../widgets/alert_dialog.dart';

class OngoingPopup extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OngoingPopup({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (value) {
        if (value == 0) onEdit();
        if (value == 1) onDelete();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 0, child: Text('Edit')),
        const PopupMenuItem(value: 1, child: Text('Delete')),
      ],
    );
  }
}

class OrderReadyPopup extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onOngoing;
  final VoidCallback onCompleted;
  final VoidCallback onDelete;

  const OrderReadyPopup({
    super.key,
    required this.onEdit,
    required this.onOngoing,
    required this.onCompleted,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (value) {
        if (value == 0) onEdit();
        if (value == 1) onDelete();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 0, child: Text('Edit')),
        PopupMenuItem(
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: const Text('Revert'),
              children: [
                ListTile(
                  dense: true,
                  title: const Text(
                    'Ongoing',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onOngoing();
                  },
                ),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Completed',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onCompleted();
                  },
                ),
              ],
            ),
          ),
        ),
        const PopupMenuItem(value: 1, child: Text('Delete')),
      ],
    );
  }
}

class CompletedPopup extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onOngoing;
  final VoidCallback onOrderReady;
  final VoidCallback onDelete;

  const CompletedPopup({
    super.key,
    required this.onEdit,
    required this.onOngoing,
    required this.onOrderReady,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (value) {
        if (value == 0) onEdit();
        if (value == 1) onDelete();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 0, child: Text('Edit')),
        PopupMenuItem(
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: const Text('Revert'),
              children: [
                ListTile(
                  dense: true,
                  title: const Text(
                    'Ongoing',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onOngoing();
                  },
                ),
                ListTile(
                  dense: true,
                  title: const Text(
                    'Order Ready',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onOrderReady();
                  },
                ),
              ],
            ),
          ),
        ),
        const PopupMenuItem(value: 1, child: Text('Delete')),
      ],
    );
  }
}

class PopupController {
  static void showEditDialog(BuildContext context, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) => ReusableAlertDialog(
        title: 'Edit',
        icon: Icons.warning,
        subtitle: 'Are you sure you want to edit?',
        onYesPressed: onYes,
        onNoPressed: () => Navigator.pop(context),
        yesButtonText: 'Yes',
        noButtonText: 'No',
      ),
    );
  }

  static void showRevertToOngoingDialog(
      BuildContext context, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) => ReusableAlertDialog(
        title: 'Revert',
        icon: Icons.warning,
        subtitle: 'Are you sure you want to mark the order as Ongoing?',
        onYesPressed: onYes,
        onNoPressed: () => Navigator.pop(context),
        yesButtonText: 'Yes',
        noButtonText: 'No',
      ),
    );
  }

  static void showRevertToOrderReadyDialog(
      BuildContext context, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) => ReusableAlertDialog(
        title: 'Revert',
        icon: Icons.warning,
        subtitle: 'Are you sure you want to mark the order as Ready?',
        onYesPressed: onYes,
        onNoPressed: () => Navigator.pop(context),
        yesButtonText: 'Yes',
        noButtonText: 'No',
      ),
    );
  }

  static void showRevertToCompletedDialog(
      BuildContext context, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) => ReusableAlertDialog(
        title: 'Revert',
        icon: Icons.warning,
        subtitle: 'Are you sure you want to mark the order as Completed?',
        onYesPressed: onYes,
        onNoPressed: () => Navigator.pop(context),
        yesButtonText: 'Yes',
        noButtonText: 'No',
      ),
    );
  }

  static void showDeleteDialog(BuildContext context, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) => ReusableAlertDialog(
        title: 'Delete',
        icon: Icons.warning,
        subtitle: 'Are you sure you want to delete?',
        onYesPressed: onYes,
        onNoPressed: () => Navigator.pop(context),
        yesButtonText: 'Yes',
        noButtonText: 'No',
      ),
    );
  }
}
