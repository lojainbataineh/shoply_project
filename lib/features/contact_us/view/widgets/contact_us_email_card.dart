part of '../contact_us_screen.dart';

class _ContactUsEmailCard extends StatelessWidget {
  const _ContactUsEmailCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        await Clipboard.setData(
          ClipboardData(text: ContactUsCubit.supportEmail),
        );
        messenger.showSnackBar(
          SnackBar(
            content: Text('Support email copied.'),
            backgroundColor: AppColors.primaryColor,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.fieldColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(Icons.mail_outline, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                ContactUsCubit.supportEmail,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.copy, size: 18, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
