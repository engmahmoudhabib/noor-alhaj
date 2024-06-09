import 'package:elnoor_emp/employee/comon_widgets/secondary_button.dart';
import 'package:elnoor_emp/guide/chat/views/chat_user.dart';
import 'package:elnoor_emp/guide/choose_client/controller/client_controller.dart';
import 'package:elnoor_emp/guide/choose_client/model/pilgrims_model.dart';
import 'package:elnoor_emp/guide/comon_widgets/chat_button.dart';
import 'package:elnoor_emp/guide/comon_widgets/note_button.dart';
import 'package:elnoor_emp/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../user_profile/view/user_profile_view.dart';

import 'package:flutter/material.dart';

class ClientContact extends StatefulWidget {
  final PilgrimsModel pilgrim;

  ClientContact({super.key, required this.pilgrim});

  @override
  State<ClientContact> createState() => _ClientContactState();
}

class _ClientContactState extends State<ClientContact> {
  ClientController controller = Get.put(ClientController());
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    bool hasNotes =
        widget.pilgrim.notes != null && widget.pilgrim.notes!.isNotEmpty;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 650) {
        return Container(
          height: media.height * 0.23,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.pilgrim.active == true
                            ? widget.pilgrim.lastStep == null
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Container(
                                      width: media.width * 0.18,
                                      height: media.height * 0.03,
                                      decoration: BoxDecoration(
                                          color: TColor.black.withOpacity(0.05),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(28))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Linkify(
                                            onOpen: _onOpen,
                                            text: widget.pilgrim.lastStep ?? '',
                                            style: TextStyle(
                                                color: Colors.green.shade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                            : widget.pilgrim.lastStep == null
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Container(
                                      width: media.width * 0.18,
                                      height: media.height * 0.03,
                                      decoration: BoxDecoration(
                                          color: TColor.black.withOpacity(0.05),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(28))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Linkify(
                                            onOpen: _onOpen,
                                            text: widget.pilgrim.lastStep ?? '',
                                            style: TextStyle(
                                                color: Colors.red.shade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 25,
                          child: Linkify(
                            onOpen: _onOpen,
                            text:
                                "${widget.pilgrim.firstName} ${widget.pilgrim.fatherName} ${widget.pilgrim.lastName}",
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: TColor.black.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Linkify(
                      onOpen: _onOpen,
                      text: widget.pilgrim.phonenumber ?? '',
                      style: const TextStyle(
                        color: TColor.primary,
                        fontSize: 11,
                      ),
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: widget.pilgrim.hotel ?? '',
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                GetStorage()
                                    .write("chatid", widget.pilgrim.guideChat);
                                Get.to(UserChat(
                                  image: widget.pilgrim.image ?? "",
                                  name:
                                      "${widget.pilgrim.firstName} ${widget.pilgrim.fatherName} ${widget.pilgrim.lastName}",
                                ));
                              },
                              child: RejectButton()),
                          const SizedBox(width: 20),
                          NoteButton(
                            id: widget.pilgrim.id ?? 0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (widget.pilgrim.notes != null &&
                        widget.pilgrim.notes!.isNotEmpty)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.47,
                        child: SecondaryButton(
                          text: 'عرض الملاحظات',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Obx(
                                  () => AlertDialog(
                                    title: Text('ملاحظات الحاج'),
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: controller.isLoading.value ? Center(child: CircularProgressIndicator(),): ListView.builder(
                                        itemCount: widget.pilgrim.notes!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(widget.pilgrim
                                                    .notes![index].content ??
                                                ''),
                                            trailing: InkWell(
                                                onTap: () {
                                                  controller.deleteNoteById(
                                                      widget.pilgrim
                                                          .notes![index].id
                                                          .toString());
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('إغلاق'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Get.to(() => UserProfileView(
                        pilgrim: widget.pilgrim,
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(2), // Border width
                  decoration: BoxDecoration(
                    color: hasNotes
                        ? Colors.blue
                        : Colors.transparent, // Border color
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.pilgrim.image ?? ""),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          height: media.height * 0.33,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.pilgrim.active == true
                            ? Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Container(
                                  width: media.width * 0.18,
                                  height: media.height * 0.05,
                                  decoration: BoxDecoration(
                                      color: TColor.black.withOpacity(0.05),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(28))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Linkify(
                                        onOpen: _onOpen,
                                        text: widget.pilgrim.hajSteps?.last
                                                .hajStep ??
                                            '',
                                        style: TextStyle(
                                            color: Colors.green.shade400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Linkify(
                          onOpen: _onOpen,
                          text:
                              "${widget.pilgrim.firstName} ${widget.pilgrim.fatherName} ${widget.pilgrim.lastName}",
                          style: TextStyle(
                              color: TColor.black.withOpacity(0.5),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Linkify(
                      onOpen: _onOpen,
                      text: widget.pilgrim.phonenumber ?? "",
                      style: const TextStyle(
                        color: TColor.primary,
                        fontSize: 11,
                      ),
                    ),
                    Linkify(
                      onOpen: _onOpen,
                      text: widget.pilgrim.hotel ?? "",
                      style: TextStyle(
                          color: TColor.black.withOpacity(0.4), fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                GetStorage()
                                    .write("chatid", widget.pilgrim.guideChat);
                                Get.to(UserChat(
                                  image: widget.pilgrim.image ?? "",
                                  name:
                                      "${widget.pilgrim.firstName} ${widget.pilgrim.fatherName} ${widget.pilgrim.lastName}",
                                ));
                              },
                              child: RejectButton()),
                          const SizedBox(width: 20),
                          NoteButton(
                            id: widget.pilgrim.id ?? 0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Get.to(() => UserProfileView(
                        pilgrim: widget.pilgrim,
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(2), // Border width
                  decoration: BoxDecoration(
                    color: hasNotes
                        ? TColor.primary
                        : Colors.transparent, // Border color
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.pilgrim.image ?? ""),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}

void _onOpen(LinkableElement link) async {
  if (await canLaunchUrl(Uri.parse(link.url))) {
    await launchUrl(Uri.parse(link.url));
  } else {
    throw 'Could not launch $link';
  }
}
