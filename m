From: =?ISO-8859-1?Q?Johny_=C5gotnes?= <johny@agotnes.com>
Subject: Re: Which SATA Combos To Consider?
Date: Tue, 22 Feb 2005 11:55:27 +1000
Message-ID: <421A910F.9040607@agotnes.com>
References: <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com> <421426DB.2000308@pobox.com> <20050217085934.M10699@florence.linkmargin.com> <4214ECE9.7070502@pobox.com> <1108669364.3604.80.camel@vom> <421535F6.80609@latech.edu> <42153A89.2090909@agotnes.com> <20050218005228.GA1228@havoc.gtf.org> <421A73DE.6040005@agotnes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from munin.agotnes.com ([202.173.149.60]:4738 "EHLO mail.agotnes.com")
	by vger.kernel.org with ESMTP id S262192AbVBVBzo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2005 20:55:44 -0500
In-Reply-To: <421A73DE.6040005@agotnes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE List <linux-ide@vger.kernel.org>

Had a look at the libata docco and the driver, and don't worry about=20
answering my question on the onboard RAM, I see that information gets=20
copied;

DMA -> DIMM -> Drive
Drive -> DIMM -> DMA

So the memory is rather crucial in this matter.

I'll need to investigate all 1468 lines of code in sata_sx4.c in more=20
detail to figure out what is going on further. If nothing else I'll=20
submit some docco gumpf on the structure of the driver as I figure it=20
out myself, will be done as a patch to the libata docco.

:)J

Johny =C5gotnes wrote:
> Jeff,
>=20
> I swapped cables and tried 3 different RAM chips, so yep, did that :)=
=20
> Question on that - does the RAM 'matter' as the driver doesn't use it=
?=20
> I.e. is it used by the onboard control logic as cache?
>=20
> Also tried moving the card to different PCI slots, still no luck :(
>=20
> Now that server is my home server running off PATA drives, the SX4 ca=
rd=20
> is sitting gathering dust (as I said) until I get my old PC operation=
al=20
> again and can put the card in to re-test.
>=20
> A few people seem to have this problem, so it is definitely worthwhil=
e=20
> having a look at, I'd love to have a go just out of my own curiousity=
=2E=20
> Closest I've been to this kinda programming is interfacing with=20
> telephone switches for softphone and ACD functionality, I'm hoping=20
> that'll help me get a grasp in the interrupt driven space of hardware=
! :)
>=20
> All I need is a bit of time ;)
>=20
> :)J
>=20
> Jeff Garzik wrote:
>=20
>> On Fri, Feb 18, 2005 at 10:44:57AM +1000, Johny =C5gotnes wrote:
>>
>>> Just a quick note on the SX4 Card - I have seen data corruption on=20
>>> hard-drives too in the simplest possible setup, so I'd stay clear o=
f=20
>>> that card until further notice.
>>>
>>> Mine is sitting in a cupboard right now, awaiting 'someone' (me, if=
 I=20
>>> get some time to learn low-level kernel drivers) debugging the issu=
e.
>>>
>>> Basically, accessing two drives via this card causes corruption, I=20
>>> had it working ok when I only accessed 1 drive, which is kinda=20
>>> pointless...
>>
>>
>>
>> I've not need about to reproduce this in the lab.
>>
>> Have you tried switching out RAM and cables?
>>
>>     Jeff
>>
>>
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
