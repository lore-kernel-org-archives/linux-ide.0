From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Promise SATA300 TX4: errors, oops in ext3 code
Date: Tue, 02 Oct 2007 11:25:01 +0200
Message-ID: <47020E6D.6070902@anagramm.de>
References: <47009BF6.5000208@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54544 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbXJBJZD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 05:25:03 -0400
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
 >
 > History:
 > Problems were first encountered on kernel 2.6.19, both i686 ("old"
 > system) and amd64 (gentoo installation CD).
 > Can't say anything about older kernels. Most probably they have same
 > issues (or worse).
 >
 > Problems were blamed:
 >   - SATA300 being too 'hot'  (jumpered the drives)

Did you turn it back to SATA300 and does it basically still work?
Then cool it actively and see if the error rate depends on it.

In one of my Promise HDD (PDC20275) controller designs I forgot to conn=
ect
the thermal pad (they call it E-PAD) properly to a GND plane so it just
worked with lots of errors which were also temperature sensitive (so, a
typical hardware design flaw :-).
On a PCI add-on card with the same chip, the E-PAD also didn't look
soldered over it's whole E-PAD area but it was working.

As you might have noticed, I am more into hardware debugging.
Propably some kernel gurus might have other ideas (related to software)=
=2E

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


