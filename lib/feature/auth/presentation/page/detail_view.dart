import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/animation/slade_effect.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/deep_linck/deep_linck.dart';

class DetailView extends StatefulWidget {
   DetailView({super.key,  this.item,  this.search, required this.isSearchToggle });

   final bool isSearchToggle;
   final DocumentSnapshot? item;
   final Map<String, dynamic>?  search;


  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  @override
  Widget build(BuildContext context) {

      return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title:Text(
          widget.isSearchToggle?
                    widget.item!['managerNames'] 
                    : widget.search!['managerNames'],style: GoogleFonts.poppins(color: Colors.white, fontSize: 19.sp),),
      ),
      
      
      body: Stack(
      children: [
        SizedBox.expand(
            child:
             Image.network(
               widget.isSearchToggle?
                 widget.item!['images'] 
                 : widget.search!['images'], fit: BoxFit.cover
             )),
          //  =========================== grage section place ===================================================

        DraggableScrollableSheet(
            minChildSize: 0.2,
            maxChildSize: 0.4,
            initialChildSize: 0.2,
            builder: (context, controlerScrolle) {
              return Container(
                decoration: BoxDecoration(
                  color: MyColors.black,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        ),

                child: SingleChildScrollView(
                  controller: controlerScrolle,
                  child: SladeAnimation(
                      delay: 1200,
                      child: Container(
                        padding: const EdgeInsets.all(9).w,
                    
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: Column(
                          children: [
                              
                              Container(
                                height: 4.h,
                                width: .4.sw,
                                margin: EdgeInsets.only(bottom: 12.h),
                                decoration: BoxDecoration(
                                  color: MyColors.greens,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                            SladeAnimation(
                                delay: 1900,
                                child: Row(
                                  children: [
                                    Container(
                                        height: MediaQuery.sizeOf(context).height /7,
                                        width: MediaQuery.sizeOf(context).width /3,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20)),
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.circular(10),
                                          child: Image.network(
                                         widget.isSearchToggle?
                                          widget.item!['images'] 
                                          : widget.search!['images'], fit: BoxFit.cover),
                                        )),

                                    SingleChildScrollView(
                                        child: Container(
                                      
                                      width: MediaQuery.sizeOf(context).width / 2,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                       
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                             
                                          // ==================== secton description ============================================================

                                          RichText(
                                            text: TextSpan(
                                              children: [
                                         
                                               TextSpan(
                                                text: 'Manager name :${widget.isSearchToggle? 
                                                    widget.item!['managerNames']
                                                  : widget.search!['managerNames'] } \n',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    // fontFamily: subfonttitle,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.sp),
                                              ),
                                          
                                              TextSpan(
                                                text: 'Email : ${widget.isSearchToggle?
                                                  widget.item!['email'] 
                                                  : widget.search!['email']}',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    // fontFamily: bigfonttitle,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10.sp),
                                              ),
                                                     
                                            ]),
                                          ),

                                           // ====================== Icons toggle section ============================================================

                                          Container(
                                            margin: EdgeInsets.only(top: 4.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    margin:  EdgeInsets.symmetric( horizontal: 1.w),
                                                    decoration: const BoxDecoration( color: Color( 0xFFf2f7fc), shape: BoxShape .circle),
                                                    child: IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            modifieIconsCommune =! modifieIconsCommune;
                                                          });
                                                        },
                                                        icon: Icon( modifieIconsCommune? Icons.arrow_drop_down : Icons.location_on_rounded  , color:MyColors.greens,)
                                                        )
                                                         ),
                                               
                                                Container(
                                                    margin: EdgeInsets.symmetric( horizontal: 5.w),
                                                    decoration: const BoxDecoration(  color: Color(  0xFFf2f7fc), shape: BoxShape .circle),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          modifieIconsTell =! modifieIconsTell;
                                                        });
                                                      },
                                                      icon: Icon( modifieIconsTell? Icons.arrow_drop_down: Icons.phone,color: MyColors.greens),
                                                    )),

                                                Container(
                                                    margin: EdgeInsets.symmetric(  horizontal: 5.w),
                                                    decoration:
                                                        const BoxDecoration(    color: Color(  0xFFf2f7fc), shape: BoxShape .circle),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        DeepLink.linkLuncker(widget.isSearchToggle?
                                                        widget.item!['email']
                                                        : widget.search!['email']);
                                                        
                                                      },
                                                      icon:   Icon(
                                                      Icons.email,
                                                        color: MyColors.greens
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                )),
                              const Divider(color: Colors.white, ),
                              //  ==================== show commune place =================================

                               Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     modifieIconsCommune
                                          ? Container(
                                              margin: EdgeInsets.symmetric(  vertical: 5.h,horizontal: 5.r),
                                              child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: "Communue: ",
                                                    style: GoogleFonts.poppins( color: Colors.white,  fontWeight:  FontWeight.w500, fontSize: 12.sp),
                                                  ),
                                                  TextSpan(
                                                    text:  widget.isSearchToggle?
                                                    widget.item!['communes']
                                                    : widget.search!['communes'],
                                                    style: GoogleFonts.poppins(  color: Colors.white,   fontWeight: FontWeight.w500, fontSize: 10.sp),
                                                  ),
                                                ]),
                                              ),
                                            )
                                          : Container(),
                                          modifieIconsTell
                                          ? Container(
                                              margin: EdgeInsets.symmetric( vertical: 5.h,  horizontal: 5.r),
                                                child: TextButton(
                                                  onPressed: () => DeepLink.contactLuncher(
                                                    widget.isSearchToggle?
                                                        widget.item!['phone']
                                                        : widget.search!['phone']
                                                  ),
                                                 
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Tell: ",
                                                      style: GoogleFonts.poppins( color: Colors.white,fontWeight: FontWeight.w500, fontSize: 12.sp),
                                                    ),
                                                    TextSpan(
                                                      text:   widget.isSearchToggle?
                                                        widget.item!['phone']
                                                        : widget.search!['phone'],
                                                      style: GoogleFonts.poppins(  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10.sp),
                                                    ),
                                                  ]),
                                                ),
                                            ))
                                          : Container(),
                                    ],
                                  ),
                                ),
                           

                                // ======================= ful description about studio ===========================================

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Description" ,style: GoogleFonts.poppins( color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.sp),),
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(vertical: 12.h,horizontal: 12),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 
                                       widget.isSearchToggle?
                                        widget.item!['description']
                                        : widget.search!['description'] ,style: GoogleFonts.poppins( color: const Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w800, fontSize: 12.sp),
                                        )
                                ]
                              )
                            ) ,
                            ),

                      
                         ],
                        ),
                      )),
                ),
              );
            })
      ],
    )
   );
 }
} 









  