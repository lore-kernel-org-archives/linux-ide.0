From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem
Date: Sun, 12 Aug 2012 06:38:15 -0700 (PDT)
Message-ID: <1344778695.71789.YahooMailNeo@web124705.mail.ne1.yahoo.com>
References: <1344365095.44831.YahooMailNeo@web124702.mail.ne1.yahoo.com> <20120807202745.GA27366@liondog.tnic> <1344736050.24220.YahooMailNeo@web124705.mail.ne1.yahoo.com>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm32-vm6.bullet.mail.ne1.yahoo.com ([98.138.229.54]:41157 "EHLO
	nm32-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751896Ab2HLNiQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Aug 2012 09:38:16 -0400
In-Reply-To: <1344736050.24220.YahooMailNeo@web124705.mail.ne1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



This is a link to the picture of the screen when happened "kernel panni=
c"=A0 http://picpaste.com/img00005-73m0unO0.jpg. The soft of the server=
 is very old - about 7 years, and there were no problems till now, the =
kernel should be above 2.6.10, if it is important i could get the exact=
 number, but i think the problem should be broken hardware. I remembere=
d that my DVD is not sane, but never caused such problems before, could=
 it be the reason for this panic ?

Thanks.

Best Regards.
Adko.

----- Original Message -----
=46rom: Borislav Petkov <bp@alien8.de>
To: Adko Branil <adkobranil@yahoo.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Sent: Tuesday, August 7, 2012 11:27 PM
Subject: Re: HDD problem

On Tue, Aug 07, 2012 at 11:44:55AM -0700, Adko Branil wrote:
> Hello, I have a disk problem, i suppose, as during boot, the system s=
ome times freezes with "kernel pannic" and some times boots normally.
>=20
> In this is peace from the log:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> Jun 16 14:41:00 b kernel: libata version 1.20 loaded.=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=20
> Jun 16
>=A0 14:41:00 b kernel: sata_promise 0000:00:08.0: version 1.03=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> Jun 16 14:41:00 b kernel: sata_via 0000:00:0f.0: version 1.1=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=20
> Jun 16 14:41:00 b kernel: ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:=
4003 85:3469 86:3c01 87:4003 88:407f=A0=A0=A0=A0=A0=A0=A0=A0=20
> Jun 16 14:41:00 b kernel: sda: Mode Sense: 00 3a 00
>=A0 00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
> Jun 16 14:41:00 b kernel: sda: Mode Sense: 00 3a 00 00=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0
>=20
> can You just tell me the meaning of this "sda: Mode Sense: 00 3a 00 0=
0" ?
> Nothing else interesting i havent seen in logs, but when googled for =
this "mode sense", all the docs i have fount was related to disk proble=
ms.
>=20

Well,

the "kernel panic" is most probably the reason why your machine freezes=
=2E
But we need to have the exact screen dump of when the kernel panic
happens in order to know what is causing it and whether it comes from
the sata_via thing or whether it is something else.

So, do you have the whole panic message in the kernel log somewhere?
Here's an example of a complete panic message:

http://www.linuxquestions.org/questions/ubuntu-63/frequent-kernel-panic=
-in-ubuntu7-04-a-562897/

If you don't have it in the logs, try reproducing the issue and when
the kernel panics, make a photo of the screen with a digital camera and
upload the screenshot somewhere. Make sure it is readable.

Also, what kernel are you running, have you tried the latest (3.5) to
see whether you still can trigger the panic?

Can you send full dmesg of your kernel?

Thanks.

--=20
Regards/Gruss,
=A0 =A0 Boris.
