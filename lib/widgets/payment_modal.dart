import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop_app/blocs/screens/progress/bloc.dart';
import 'package:myshop_app/models/flowData.dart';
import 'package:myshop_app/models/paymentTypeData.dart';
import 'package:myshop_app/res/app_drawables.dart';
import 'package:myshop_app/res/app_strings.dart';
import 'package:myshop_app/widgets/payment_card.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../constant.dart';
import '../res/app_colors.dart';
import '../utils/currency_format.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import 'button.dart';

paymentModal({
  required BuildContext context,
  required FlowData transactionData,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider(
        create: (_) =>
            ProgressBloc()
              ..init(context: dialogContext, input: transactionData),

        // FIX: Use new context inside Builder
        child: Builder(
          builder: (innerContext) {
            return BlocBuilder<ProgressBloc, ProgressState>(
              bloc: innerContext.read<ProgressBloc>(),
              builder: (ctx, state) {
                final bloc = ctx.read<ProgressBloc>();
                final info = bloc.progressInfo;

                return AlertDialog(
                  alignment: Displaylandscape
                      ? Alignment.center
                      : Alignment.topCenter,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  insetPadding: EdgeInsets.only(
                    top: Displaylandscape
                        ? 0
                        : ScreenSize().getScreenHeight(28),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  content: SizedBox(
                    height: Displaylandscape
                        ? ScreenSize().getScreenHeight(50)
                        : ScreenSize().getScreenHeight(30),
                    width: Displaylandscape
                        ? ScreenSize().getScreenWidth(42)
                        : ScreenSize().getScreenWidth(60),

                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          /// LOGO
                          SizedBox(
                            height: ScreenSize().getScreenHeight(
                              Displaylandscape ? 8 : 5,
                            ),
                            child: Center(
                              child: Image.asset(
                                AppDrawables.logo,
                                height: ScreenSize().getScreenHeight(
                                  Displaylandscape ? 6 : 2.8,
                                ),
                              ),
                            ),
                          ),
                          Divider(thickness: 1),

                          /// TITLE
                          state is ProgressErrorState
                              ? Text(
                                  AppStrings.transactionFailed,
                                  style: FontsStyle().modalTitle(),
                                )
                              : Text(
                                  info.paymentData?.name == null
                                      ? AppStrings.paymentAmount
                                      : '${AppStrings.amount} '
                                            '${info.countryData!.symbol}'
                                            '${Currency().format(decimal: info.countryData!.dp!, rate: double.parse(info.countryData?.rate ?? '1'), amount: info.cartTotalAmount)}',
                                  style: FontsStyle().modalTitle(),
                                ),

                          SizedBox(height: ScreenSize().getScreenHeight(0.5)),

                          /// AMOUNT / LOADER / ERROR ICON
                          Expanded(
                            child: state is ProgressErrorState
                                ? Center(
                                    child: Image.asset(
                                      AppDrawables.failed,
                                      height: ScreenSize().getScreenHeight(
                                        Displaylandscape ? 6.6 : 3.7,
                                      ),
                                    ),
                                  )
                                : info.paymentData?.name == null
                                ? Center(
                                    child: Text(
                                      '${info.countryData!.symbol}'
                                      '${Currency().format(decimal: info.countryData!.dp!, rate: double.parse(info.countryData?.rate ?? '1'), amount: info.cartTotalAmount)}',
                                      style: TextStyle(
                                        fontSize: ScreenSize().getScreenHeight(
                                          Displaylandscape ? 5.5 : 2.8,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : (state is ProgressSuccessful
                                      ? Center(
                                          child: Image.asset(
                                            AppDrawables.success,
                                            height: ScreenSize()
                                                .getScreenHeight(
                                                  Displaylandscape ? 6.6 : 3.7,
                                                ),
                                          ),
                                        )
                                      : Center(
                                          child: SizedBox(
                                            height: ScreenSize()
                                                .getScreenHeight(
                                                  Displaylandscape ? 5.5 : 2.5,
                                                ),
                                            width: ScreenSize().getScreenHeight(
                                              Displaylandscape ? 5.5 : 2.5,
                                            ),
                                            child:
                                                const CircularProgressIndicator(
                                                  color: AppColors.secondary,
                                                ),
                                          ),
                                        )),
                          ),

                          /// MESSAGE
                          state is ProgressErrorState
                              ? TextAnimator(
                                  state.error,
                                  style: FontsStyle().failedModalTitle(),
                                  atRestEffect: WidgetRestingEffects.pulse(),
                                  incomingEffect:
                                      WidgetTransitionEffects.incomingSlideInFromTop(
                                        blur: Offset(0, 20),
                                      ),
                                )
                              : (state is ProgressSuccessful
                                    ? Text(
                                        AppStrings.paymentSuccessful,
                                        style: FontsStyle().modalTitle(),
                                      )
                                    : Text(
                                        info.paymentData?.name == null
                                            ? AppStrings.selectPaymentMethod
                                            : AppStrings.processingPleaseWait,
                                        style: FontsStyle().modalTitle(),
                                      )),

                          SizedBox(height: ScreenSize().getScreenHeight(1)),

                          /// PAYMENT METHODS
                          _paymentOptions(bloc),

                          /// CANCEL BUTTON
                          _cancelButton(bloc, state),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}

Widget _paymentOptions(ProgressBloc bloc) {
  return Container(
    height: Displaylandscape
        ? ScreenSize().getScreenHeight(16)
        : ScreenSize().getScreenHeight(10),
    color: AppColors.secondary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _methodButton(
          title: AppStrings.card,
          image: AppDrawables.card,
          tender: "01",
          isActive: bloc.progressInfo.paymentData?.name == AppStrings.card,
          onTap: () {
            bloc.add(
              ProgressSetPaymentDataEvent(
                data: PaymentData(
                  name: AppStrings.card,
                  image: AppDrawables.card,
                  tenderType: '01',
                ),
              ),
            );
          },
        ),
        VerticalDivider(color: Colors.white),
        _methodButton(
          title: AppStrings.mobile,
          image: AppDrawables.mobile,
          tender: "02",
          isActive: bloc.progressInfo.paymentData?.name == AppStrings.mobile,
          onTap: () {
            bloc.add(
              ProgressSetPaymentDataEvent(
                data: PaymentData(
                  name: AppStrings.mobile,
                  image: AppDrawables.mobile,
                  tenderType: '02',
                ),
              ),
            );
          },
        ),
        VerticalDivider(color: Colors.white),
        _methodButton(
          title: AppStrings.qr,
          image: AppDrawables.qr,
          tender: "03",
          isActive: bloc.progressInfo.paymentData?.name == AppStrings.qr,
          onTap: () {
            bloc.add(
              ProgressSetPaymentDataEvent(
                data: PaymentData(
                  name: AppStrings.qr,
                  image: AppDrawables.qr,
                  tenderType: '03',
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _methodButton({
  required String title,
  required String image,
  required String tender,
  required bool isActive,
  required Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: PaymentCard(
      cardColor: Colors.white,
      cardtext: title,
      imageID: image,
      outlineColor: isActive ? Colors.white : Colors.transparent,
    ),
  );
}

Widget _cancelButton(ProgressBloc bloc, ProgressState state) {
  return Padding(
    padding: EdgeInsets.all(ScreenSize().getScreenHeight(1)),
    child: InkWell(
      onTap: bloc.busyState ? () {} : () => Navigator.pop(bloc.sectionContext),
      child: Btn(
        btn: bloc.busyState
            ? AppColors.primary.withOpacity(0.5)
            : AppColors.primary,
        btnText: AppStrings.cancel,
      ),
    ),
  );
}
