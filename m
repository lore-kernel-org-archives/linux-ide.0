From: tabris <tabris@tabris.net>
Subject: Re: undecoded slave?
Date: Fri, 24 Sep 2004 04:26:08 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409240426.09861.tabris@tabris.net>
References: <200409222357.39492.tabris@tabris.net> <200409240209.13884.bzolnier@elka.pw.edu.pl> <311601c90409231841774f5168@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:7848 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268589AbUIXI2Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2004 04:28:16 -0400
In-Reply-To: <311601c90409231841774f5168@mail.gmail.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Eric Mudama <edmudama@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 September 2004 9:41 pm, Eric Mudama wrote:
> On Fri, 24 Sep 2004 02:09:13 +0200, Bartlomiej Zolnierkiewicz
>
> <bzolnier@elka.pw.edu.pl> wrote:
> > On Thursday 23 September 2004 22:30, tabris wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > On Thursday 23 September 2004 7:14 am, Bartlomiej Zolnierkiewicz 
wrote:
> > > > [ use linux-ide@vger.kernel.org for ATA stuff ]
> > > >
> > > > On Thursday 23 September 2004 05:57, tabris wrote:
> > > > > Probing IDE interface ide3...
> > > > > hdg: Maxtor 4D060H3, ATA DISK drive
> > > > > hdh: Maxtor 4D060H3, ATA DISK drive
> > > > > ide-probe: ignoring undecoded slave
> > > > >
> > > > > Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error
> > > > > above seems to be the only [stated] reason why.
> > > >
> > > > Please send hdparm -I output for both drives.
> > >
> > > As you can see, both drives are the same brand/size/model.
> > > Both are connected to the PDC20265 on my ASUS A7V266-E
> > > motherboard.
> > >
> > > /dev/hdg:
> > >
> > > ATA device, with non-removable media
> > >         Model Number:       Maxtor 4D060H3
> > >         Serial Number:      D3000000
> > >         Firmware Revision:  DAK019K0
> >
> > Thanks.
> > It seems we will need to add this Serial Number to "undecoded
> > slave" fixup.
> >
> > Please also send /proc/ide/hd?/identify to exclude kernel/hdparm
> > parsing bug.
>
> I'm confused, and I think something else must be going on... to have
> 2 different drives, with two completely different ASICs in them (and
> therefore significantly different object code), have identical
> corruption of the same 6 bytes of their configuration block is just
> not likely.  I'm pretty sure they don't even have the same utility
> zone layout.
>
> Is that how the drive IDs when connected via other controllers, in
> another system, etc?
	I'd have to get back to you on that, as I had no intention of taking my 
machine down for such a purpose. But if you truly would need this info, 
it could be provided within a day or two.
>
> hrm...
>
> eric
- --
tabris
- -
Reinhart was never his mother's favorite -- and he was an only child.
		-- Thomas Berger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU9og1U5ZaPMbKQcRApBDAJ9zDlviuLYzN9HEEn8LimDmfnECpQCeNXOE
n9Qpr+Et1G73rInipBEiDG8=
=N5Oc
-----END PGP SIGNATURE-----
