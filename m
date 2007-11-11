From: Thorsten Leemhuis <thl@ct.heise.de>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Sun, 11 Nov 2007 15:05:30 +0100
Message-ID: <47370C2A.108@ct.heise.de>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca> <20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu> <20071109233215.GA22498@citd.de> <4735F1E8.1070009@rtr.ca> <20071110183805.GA28230@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from basicbox7.server-home.net ([195.137.212.29]:52170 "EHLO
	basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbXKKOZB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 09:25:01 -0500
In-Reply-To: <20071110183805.GA28230@citd.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On 10.11.2007 00:32, Matthias Schniedermeyer wrote:
>  [...]
> My computer/mainboard @work has such a "broken" BIOS. Of the 5=20
> SATA-Ports this MB has only 1 (and 1 "missing" that is reported by
> linux but i can't find on the MB) is configured as AHCI [...]

There is nothing "broken" here. You have a ICH8 (without R) that drives
four SATA ports, which are handled by ata_piix.

Then you have a Jmicron JMB363 -- it handles the PATA-Channel and two
SATA-Ports -- one internal (near the battery)/next to the PCI-Slot and =
a
external eSATA port. Seems you configured it in AHCI-Mode in the
BIOS-Setup. Linux will work just fine if you connect the hard disc to
that port. But if you want to install Windows XP you need a driver from
Jmicron.

There were BIOSes for the P5B where you could enabled AHCI for the ICH8
as well. It seems Asus removed it in the later BIOS-versions again as
Intel doesn't provide a Windows-AHCI driver for the basic ICH8.

HTH and clarifies some of your problems.

Cu
knurd

--=20
Thorsten Leemhuis
 c't- Magazin f=C3=BCr Computertechnik       web    http://www.heise.de=
/ct/
 Heise Zeitschriften Verlag GmbH&Co.KG  phone  +49 (0)511 5352 666
 Helstorfer Str. 7                      icq    140593172
 D-30625 Hannover, Germany              jabber thl_at_work@jabber.ccc.d=
e

/* Heise Zeitschriften Verlag GmbH & Co. KG, Registergericht:
   Amtsgericht Hannover HRA 26709; Pers=C3=B6nlich haftende Gesellschaf=
terin:
   Heise Zeitschriften Verlag Gesch=C3=A4ftsf=C3=BChrung GmbH, Register=
gericht:
   Amtsgericht Hannover, HRB 60405 Gesch=C3=A4ftsf=C3=BChrer: Ansgar He=
ise,
   Steven P. Steinkraus, Dr. Alfons Schr=C3=A4der                      =
    */
