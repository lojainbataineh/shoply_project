import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/icon_header/custom_icon_header.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_field_label.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_app/features/contact_us/view_model/cubit.dart';
import 'package:shoply_app/features/contact_us/view_model/state.dart';
part 'widgets/contact_us_email_card.dart';
part 'widgets/contact_us_form.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit(),
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'Contact Us'),
        body: BlocListener<ContactUsCubit, ContactUsState>(
          listenWhen: (previous, current) {
            return current is! ContactUsChangeSubjectState;
          },
          listener: (context, state) {
            if (state is ContactUsLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is ContactUsErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Contact Us',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is ContactUsSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Message Sent',
                description: 'Thanks for reaching out! We\'ll reply soon.',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CustomIconHeader(
                    iconData: Icons.headset_mic_outlined,
                    title: 'How can we help?',
                    subtitle: 'Send us a message. We\'re here for you.',
                  ),
                  SizedBox(height: 20),
                  _ContactUsEmailCard(),
                  SizedBox(height: 20),
                  _ContactUsForm(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
