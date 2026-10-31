part of '../contact_us_screen.dart';

class _ContactUsForm extends StatelessWidget {
  const _ContactUsForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContactUsCubit>();
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomFieldLabel(label: 'Full Name'),
          CustomTextField(
            validator: (fullName) {
              if (fullName?.trim().isEmpty ?? true) {
                return 'Full Name is required';
              }
              return null;
            },
            controller: cubit.fullNameController,
            hinText: 'Enter your name',
          ),
          CustomFieldLabel(label: 'Email'),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email?.trim().isEmpty ?? true) {
                return 'Email is required';
              } else if (!AppRegex.emailRegex.hasMatch(email!.trim())) {
                return 'Email is not valid';
              }
              return null;
            },
            controller: cubit.emailController,
            hinText: 'Enter your email',
          ),
          CustomFieldLabel(label: 'Subject'),
          BlocBuilder<ContactUsCubit, ContactUsState>(
            buildWhen: (previous, current) {
              return current is ContactUsChangeSubjectState;
            },
            builder: (context, state) {
              return DropdownButtonFormField<String>(
                initialValue: cubit.subject,
                icon: Icon(Icons.keyboard_arrow_down),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                validator: (subject) {
                  if (subject == null) return 'Please choose a subject';
                  return null;
                },
                hint: Text(
                  'Choose a subject',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  helperText: '',
                  filled: true,
                  fillColor: AppColors.fieldColor,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 14,
                  ),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: border.copyWith(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                items: [
                  for (final subject in cubit.subjects)
                    DropdownMenuItem(value: subject, child: Text(subject)),
                ],
                onChanged: (subject) {
                  cubit.changeSubject(subject: subject);
                },
              );
            },
          ),
          CustomFieldLabel(label: 'Message'),
          CustomTextField(
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            validator: (message) {
              if (message?.trim().isEmpty ?? true) {
                return 'Message is required';
              }
              return null;
            },
            controller: cubit.messageController,
            hinText: 'Write your message...',
          ),
          SizedBox(height: 5),
          CustomButton(
            buttonText: 'Send Message',
            onPressed: () {
              cubit.sendMessage();
            },
          ),
        ],
      ),
    );
  }
}
