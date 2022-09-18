import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/modules/customer/repository/customer_repository.dart';

class CustomerFormSmall extends StatefulWidget {
  const CustomerFormSmall({super.key, this.customer});

  final Customer? customer;

  @override
  State<CustomerFormSmall> createState() => _CustomerFormSmallState();
}

class _CustomerFormSmallState extends State<CustomerFormSmall> {
  final key = GlobalKey<FormState>();

  final builder = CustomerBuilder();
  final repository = CustomerRepository();

  @override
  void initState() {
    super.initState();

    if (widget.customer != null) {
      builder.fill(widget.customer!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('New Customer')),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _CustomerForm(builder),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: handleSubmit,
            style: TextButton.styleFrom(
              foregroundColor: theme.canvasColor,
              backgroundColor: theme.primaryColor,
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(
                letterSpacing: 1,
                fontFamily: 'google-sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('Submit'),
          ),
        )
      ],
    );
  }

  void handleSubmit() async {
    if (!(key.currentState?.validate() ?? false)) return;

    key.currentState?.save();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: const [CircularProgressIndicator(), Text('Loading')],
        ),
      ),
    );

    var customer = builder.build();
    if (customer.id.isEmpty) {
      customer = await repository.create(builder.build());
    } else {
      customer = await repository.update(builder.build());
    }

    if (mounted) {
      Navigator.of(context).pop();
      Navigator.of(context).pop(customer);
    }
  }
}

class _CustomerForm extends StatefulWidget {
  const _CustomerForm(this.builder);

  final CustomerBuilder builder;

  @override
  State<_CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<_CustomerForm> {
  final key = GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: TextFormField(
          initialValue: widget.builder.name,
          onSaved: (value) => widget.builder.name = value,
          decoration: const InputDecoration(label: Text('Name')),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        sliver: SliverToBoxAdapter(
          child: Row(children: [
            const Icon(Icons.phone),
            const SizedBox(width: 5),
            const Text('Phone'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add_rounded, color: Colors.green),
              onPressed: handleAddButton,
            ),
          ]),
        ),
      ),
      SliverAnimatedList(
        key: key,
        initialItemCount: widget.builder.contactNumbersLength,
        itemBuilder: (context, index, animation) {
          return _PhoneField(
            index: index,
            animation: animation,
            builder: widget.builder,
          );
        },
      ),
    ]);
  }

  void handleAddButton() {
    widget.builder.addContactNumber('');
    key.currentState?.insertItem(widget.builder.contactNumbersLength - 1);
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    required this.index,
    required this.builder,
    required this.animation,
  });

  final int index;
  final CustomerBuilder builder;
  final Animation<double> animation;

  static final _anim =
      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn,
    );

    return SlideTransition(
      position: anim.drive(_anim),
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                initialValue: builder.getContactNumber(index),
                onSaved: (value) => builder.setContactNumber(index, value),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 13),
                ),
              ),
            ),
            const SizedBox(width: 10),
            buildRemoveButton(context),
          ]),
        ),
      ),
    );
  }

  Widget buildRemoveButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.remove, color: Colors.red),
      onPressed: () {
        if (builder.contactNumbersLength == 1) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('At least one phone number is required'),
            ));

          return;
        }

        final value = builder.getContactNumber(index);

        builder.removeContactNumberAt(index);
        SliverAnimatedList.of(context).removeItem(
          index,
          (context, animation) => _PhoneFieldDisappear(
            value: value,
            animation: animation,
          ),
          // duration: Duration(seconds: 1)
        );
      },
    );
  }
}

class _PhoneFieldDisappear extends StatelessWidget {
  const _PhoneFieldDisappear({
    required this.value,
    required this.animation,
  });

  final String? value;
  final Animation<double> animation;

  static final _anim =
      Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero);

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(
      parent: animation,
      curve: Curves.ease,
    );

    return SlideTransition(
      position: animation.drive(_anim),
      child: ScaleTransition(
        scale: animation,
        child: SizeTransition(
          sizeFactor: anim,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(children: [
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 13),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.remove, color: Colors.red),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
