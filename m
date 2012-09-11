From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Tue, 11 Sep 2012 06:38:04 -0700 (PDT)
Message-ID: <1347370684.63365.YahooMailNeo@web124706.mail.ne1.yahoo.com>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120826130152.GA20021@liondog.tnic> <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com> <20120827215952.GA18719@liondog.tnic> <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120830095808.GB24680@liondog.tnic> <1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20547.48101.900727.735398@pilspetsen.it.uu.se> <1347017576.44763.YahooMailNeo@web124703.mail.ne1.yahoo.com> <20555.29361.138287.766030@pilspetsen.it.uu.se>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm3-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.55]:48667 "HELO
	nm3-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754278Ab2IKNiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Sep 2012 09:38:05 -0400
In-Reply-To: <20555.29361.138287.766030@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Borislav Petkov <bp@alien8.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Dan Merillat <dan.merillat@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

Mikael writes:


>Please try the patch below, which implements the fix I described a
>week ago. It's for 3.6-rc4 but should work in any recent kernel.
>Without this patch one of my test machines always throws a lockdep
>warning involving pdc_sata_hardreset and pdc_interrupt during bootup,
>but with the patch the warning is gone, as expected.

>If it works for you I'll add your Tested-by: and submit it properly.



Your patch seems to work, as the warning message is gone after applying=
 it, i tried it with linux-3.5.2,
=A0and post here links to dmesg before and after applying the patch:

before: http://pastebin.com/Y80AYYVK

after:=A0=A0=A0 http://pastebin.com/Am0Zuabz



Borislav writes:

>Hmm, Cool'n'Quiet enabled actually means that you have _PSS objects an=
d
>powernow-k8 should be detecting the P-states properly.

>Can you catch dmesg from that machine twice?

>* one with Cool'n'Quiet disabled
>* one with the kernel panic


I hope i will be able to do it some time in the future, because i have =
no any physical contact with this machine,
moreover it will require photo of the monitor after panic message, as i=
t happens at boot process - fs not mounted yet,
network not set, so i can not catch a message with netconsole.


Borislav writes:

>Right, so AFAICU, you can run a CONFIG_PREEMPT kernel perfectly fine n=
ow
>after the BIOS update, right?

Right.


Borislav writes:

>If so and when you say that the oopses started happening after an
>electrical instability, I'd venture a guess that something got damaged
>in the BIOS EPROM and since you've flashed it anew, the corrupted data
>got overwritten and so no more crashes. Correct?


The thought crossed my mind, but i still can not imagine how could it h=
appens.
Even if bios keeps some of the settings into EPROM, instead of CMOS,=20
it should flash itself just after changing the settings, which is not t=
he case, if i was right informed.
There may be some other way that electricity break could damage EPROM c=
ontent, somehow more directly,
beyond the mechanisms by design, i don't know.
Anyway, for the known facts we have, this explanation sounds pretty sat=
isfactory, as long as no more crashes appears :).


Thanks !

Regards
Adko.
