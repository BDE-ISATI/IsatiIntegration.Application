import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isati_integration/models/solo_challenge.dart';
import 'package:isati_integration/src/providers/solo_challenge_store.dart';
import 'package:isati_integration/src/shared/widgets/general/is_app_bar.dart';
import 'package:isati_integration/src/shared/widgets/general/is_button.dart';
import 'package:isati_integration/utils/screen_utils.dart';
import 'package:provider/provider.dart';

class SoloChallengeDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SoloChallengeStore>(
      builder: (context, soloChallengeStore, child) {
        final SoloChallenge challenge = soloChallengeStore.challenge;

        return Scaffold(
          appBar: IsAppBar(
            title: Text(challenge.title),
          ),
          body: Padding(
            padding: ScreenUtils.instance.defaultPadding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: (constraints.maxWidth < ScreenUtils.instance.breakpointPC) ?
                          _buildSmallHeader(context, challenge) :
                          _buildBigHeader(context, challenge)
                      ),
                      const SizedBox(height: 20,),
                      Text(challenge.description)
                    ],
                  ),
                );
              },
            ),
          )
        );
      }
    );
  }

  Widget _buildSmallHeader(BuildContext context, SoloChallenge challenge) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildChallengeImage(challenge, maxHeight: 200),
        const SizedBox(height: 20),
        Flexible(
          child: _buildChallengeInfoWrap(challenge),
        ),
        const SizedBox(height: 20,),
        IsButton(text: "Envoyer des preuves", onPressed: () {},),
      ],
    );
  }

  Widget _buildBigHeader(BuildContext context, SoloChallenge challenge) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The challenge image
        SizedBox(
          width: 300,
          child: _buildChallengeImage(challenge), 
        ),
        const SizedBox(width: 20,),
        // The challenge title and informations
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(challenge.title, style: Theme.of(context).textTheme.headline2,),
              const SizedBox(height: 8),
              // The informations
              Flexible(
                child: _buildChallengeInfoWrap(challenge), 
              ),
              const SizedBox(height: 20,),
              IsButton(text: "Envoyer des preuves", onPressed: () {},),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChallengeImage(SoloChallenge challenge, { double maxHeight = 500 }) {
    return  Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 10.0),
            blurRadius: 12.0,
            spreadRadius: -5.0
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset("assets/images/background.jpg", fit: BoxFit.cover,)
      )
    );
  }

  Widget _buildChallengeInfoWrap(SoloChallenge challenge) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _buildChallengeInfoWidget(icon: Icons.calendar_today, text: "Fini le ${DateFormat('dd/MM/yyyy').format(challenge.endingDate)}"),
        _buildChallengeInfoWidget(icon: Icons.military_tech, text: "Rapporte ${challenge.value} point(s)"),
        _buildChallengeInfoWidget(icon: Icons.loop, text: "Doit être fait ${challenge.numberOfRepetitions} fois"),
      ],
    );
  }

  Widget _buildChallengeInfoWidget({required IconData icon, required String text}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8,),
          Flexible(child: Text(text, style: const TextStyle(fontStyle: FontStyle.italic),))
        ],
      ),
    );
  }
}