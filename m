From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Promise SATA300 TX4: errors, oops in ext3 code
Date: Mon, 01 Oct 2007 11:09:58 +0200
Message-ID: <4700B966.1030508@anagramm.de>
References: <47009BF6.5000208@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63712 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXJAJK4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 05:10:56 -0400
In-Reply-To: <47009BF6.5000208@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alexander Sabourenkov schrieb:
 > Hardware:  Athlon64, Asus A8V, Promise SATA300 TX4, 2xSeagate 7200.1=
0
 > 320G, jumper-limited to SATA150.
 > Kernel : 2.6.22.9 amd64
 >
 > Problem:
 > Heavy load causes errors and triggers oops.

Have you checked your memory already (memtest86)?

We have several applications with Promise controllers on strange
hardware and we never had integrity problems with i.e. not so standard
SATA connections over custom vaccum-tight connectors.

 > Problems were blamed:
 >   - SATA300 being too 'hot'  (jumpered the drives)

Is this a common known problem with your harddrives or controller?
(ask google) Otherwise, it sounds like a problem with broken hardware.

 >   - cables (work perfectly on onboard controller)
 >   - interrupt sharing (found the only slot which does not share
 > interrupt line)
 >   - cooling (3 fans installed, smartctl-reported temperature at max =
load
 > dropped to 35C)

Try to heat up your memory a little (your wife's hair blower).
If it fails more often, your memory is most likely broken.

 >   - weak PSU (installed 600W FSP)
 >   - kernel bugs (upgraded to 2.6.22.9)
 >
 > All those measures significantly dropped error rate (from about 20 t=
o
 > 2-4 per mirror rebuild) but did not eliminate the problem.

Again... sounds like bad memory to me.

Juat my $0.05.
Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Stra=C3=9Fe 45/1
Linhof Werksgel=C3=A4nde
D-81379 M=C3=BCnchen
Tel.089-741518-50
=46ax 089-741518-19
http://www.anagramm-technology.com


