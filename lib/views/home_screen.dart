import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop_app/services/country_currency_Manager.dart';
import 'package:provider/provider.dart';
import '../blocs/screens/home/bloc.dart';
import '../constant.dart';
import '../models/productCategory.dart';
import '../res/app_colors.dart';
import '../services/pinpadThemeColor.dart';
import '../widgets/bottomsheet_content.dart';
import '../widgets/footer.dart';
import '../widgets/payment_modal.dart';
import 'components/home_screen/food_item_list.dart';
import 'components/home_screen/header_one.dart';
import 'components/home_screen/header_two.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List country = countryList;


  @override
  void initState() {
    super.initState();
    PinpadThemeView().colourTheme(context);
    // Wait for the first frame to safely access the bloc and context
    WidgetsBinding.instance.addPostFrameCallback((_) {


       setupSDKS(context);

    });
  }

  @override
  void dispose() {
    // Optional: dispose bloc streams if needed
    super.dispose();
  }

  Future<dynamic> setupSDKS(BuildContext context) async {
   await CountryManager().loadActiveCountry();
    if (context.mounted) {
      var screenSize = MediaQuery.of(context).size;
      var screenWidth = screenSize.width;
      var screenHeight = screenSize.height;
      if (screenHeight <= screenWidth) {
        setState(() {
          Displaylandscape = true;
        });
      } else {
        setState(() {
          Displaylandscape = false;
        });
      }

    }

    // ignore: use_build_context_synchronously
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return BlocProvider(
        create: (_) => HomeBloc(sectionContext: context),
        child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: 
           
            BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final homeBloc = context.read<HomeBloc>();
                  // Default fallback (empty container)
                  if (state is HomeUpdatedCartState || state is HomeInitState) {
                    return Column(
                      children: [
                        whiteHeader(homeBloc: homeBloc,),
                        HeaderTwo(),
                        FoodItemList(
                          onAddToCart:
                              (Item selectedProduct) {
                            homeBloc.add(HomeAddToCartEvent(
                                selectedProduct: selectedProduct));
                          }, homeBloc: homeBloc,)
                      ],
                    );
                  }
                  return SizedBox();
                })
        ),

      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final homeBloc = context.read<HomeBloc>();
          // Default fallback (empty container)
          return

            Footer(cartList: homeBloc.metaData.cart, onPay: (){
              paymentModal( context: context, transactionData:  homeBloc.metaData);


              }, amount: homeBloc.metaData.cartTotalAmount, onViewCart: () {
              showModalBottomSheet(
                  context: context,
                  constraints: const BoxConstraints(
                    maxWidth: double.infinity,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                  ),
                  builder: (context) {
                    return  SheetContent(homeBloc: homeBloc,);
                  });
            },);
        },
      ),


        ));

  }
}
