From: =?ISO-8859-1?Q?Johny_=C5gotnes?= <johny@agotnes.com>
Subject: Re: Which SATA Combos To Consider?
Date: Tue, 22 Feb 2005 09:50:20 +1000
Message-ID: <421A73BC.9070604@agotnes.com>
References: <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com> <421426DB.2000308@pobox.com> <20050217085934.M10699@florence.linkmargin.com> <4214ECE9.7070502@pobox.com> <1108669364.3604.80.camel@vom> <421535F6.80609@latech.edu> <42153A89.2090909@agotnes.com> <20050218005228.GA1228@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from munin.agotnes.com ([202.173.149.60]:54657 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S262176AbVBUXue
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Feb 2005 18:50:34 -0500
In-Reply-To: <20050218005228.GA1228@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ryan Bourgeois <rgb005@latech.edu>, Danny Cox <Danny.Cox@ECWeb.com>, Linux IDE List <linux-ide@vger.kernel.org>

Jeff,

I swapped cables and tried 3 different RAM chips, so yep, did that :)=20
Question on that - does the RAM 'matter' as the driver doesn't use it?=20
I.e. is it used by the onboard control logic as cache?

Also tried moving the card to different PCI slots, still no luck :(

Now that server is my home server running off PATA drives, the SX4 card=
=20
is sitting gathering dust (as I said) until I get my old PC operational=
=20
again and can put the card in to re-test.

A few people seem to have this problem, so it is definitely worthwhile=20
having a look at, I'd love to have a go just out of my own curiousity.=20
Closest I've been to this kinda programming is interfacing with=20
telephone switches for softphone and ACD functionality, I'm hoping=20
that'll help me get a grasp in the interrupt driven space of hardware! =
:)

All I need is a bit of time ;)

:)J

Jeff Garzik wrote:
> On Fri, Feb 18, 2005 at 10:44:57AM +1000, Johny =C5gotnes wrote:
>=20
>>Just a quick note on the SX4 Card - I have seen data corruption on=20
>>hard-drives too in the simplest possible setup, so I'd stay clear of=20
>>that card until further notice.
>>
>>Mine is sitting in a cupboard right now, awaiting 'someone' (me, if I=
=20
>>get some time to learn low-level kernel drivers) debugging the issue.
>>
>>Basically, accessing two drives via this card causes corruption, I ha=
d=20
>>it working ok when I only accessed 1 drive, which is kinda pointless.=
=2E.
>=20
>=20
> I've not need about to reproduce this in the lab.
>=20
> Have you tried switching out RAM and cables?
>=20
> 	Jeff
>=20
>=20
>=20
