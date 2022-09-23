import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/storyModel.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import 'veiw_story.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: cubit.stories.map((e) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewStory(e)));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 230,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e.storyImage!),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(50),
                                      bottomLeft: Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .shadowColor
                                            .withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 9,
                                        offset: const Offset(3, 3)),
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .shadowColor
                                            .withOpacity(0.4),
                                        spreadRadius: 3,
                                        blurRadius: 9,
                                        offset: const Offset(-1, -1))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        e.name!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        timeago.format(e.dateTime!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    radius: 31,
                                    child: CircleAvatar(
                                      radius: 29,
                                      backgroundImage: NetworkImage(e.image!),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )).toList(),
                  options: CarouselOptions(
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    viewportFraction: 1,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    initialPage: 0,
                    height: 240,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Stories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: SocialCubit.get(context).isLight
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.getStoryImage(context);
                      },
                      child: Container(
                        width: 110,
                        height: 190,
                        margin: const EdgeInsetsDirectional.only(start: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(17)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 153,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Container(
                                      width: 110,
                                      height: 135,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(17),
                                            topLeft: Radius.circular(17),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  cubit.userModel!.image!),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.3),
                                    child: const CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Create Story",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => personalStoryItem(
                              context, cubit.personalStories[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 10,
                              ),
                          itemCount: cubit.personalStories.length),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All Stories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: SocialCubit.get(context).isLight
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1 / 1.5,
                  children: List.generate(cubit.stories.length,
                      (index) => storyItem(context, cubit.stories[index])),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget personalStoryItem(context, StoryModel model) {
    var bloc = SocialCubit.get(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewStory(model)));
      },
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(17)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(model.storyImage!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(bloc.userModel!.image!),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    child: Text(
                      bloc.userModel!.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget storyItem(context, StoryModel model) {
    var bloc = SocialCubit.get(context).userModel;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewStory(model)));
      },
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(17)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(model.storyImage!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: model.uId == bloc!.uId
                          ? NetworkImage(bloc.image!)
                          : NetworkImage(model.image!),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    height: 25,
                    child: Text(
                      model.uId == bloc.uId ? bloc.name! : model.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
