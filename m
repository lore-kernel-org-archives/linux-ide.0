From: Mike Hokenson <logan@gozer.org>
Subject: Fwd: Long delay when booting with SATA DVD on Marvell 88SE6121
Date: Mon, 31 Aug 2009 21:00:26 -0500
Message-ID: <5ffd7e260908311900u3a4a02b9kd36156cfdce902c0@mail.gmail.com>
References: <20090817002918.GA2805@gozer.dminteractive.com>
	 <4A9BD7DF.8030606@kernel.org>
	 <5ffd7e260908311856j1fd42765rbdc5245bf4e7bd71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63200 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZIACAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Aug 2009 22:00:25 -0400
Received: by bwz19 with SMTP id 19so3201266bwz.37
        for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2009 19:00:26 -0700 (PDT)
In-Reply-To: <5ffd7e260908311856j1fd42765rbdc5245bf4e7bd71@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

(sorry, resent to linux-ide without the html)

On Mon, Aug 31, 2009 at 9:02 AM, Tejun Heo <tj@kernel.org> wrote:
>
> > [ =A0 =A06.312129] ata2.00: qc timeout (cmd 0xa1)
> > [ =A0 =A06.312135] ata2.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
> > [ =A0 11.352006] ata2: link is slow to respond, please be patient (=
ready=3D0)
> > [ =A0 16.336009] ata2: device not ready (errno=3D-16), forcing hard=
reset
> > [ =A0 21.532007] ata2: link is slow to respond, please be patient (=
ready=3D0)
> > [ =A0 26.348009] ata2: SRST failed (errno=3D-16)
> > [ =A0 31.544008] ata2: link is slow to respond, please be patient (=
ready=3D0)
> > [ =A0 36.360014] ata2: SRST failed (errno=3D-16)
> > [ =A0 36.544307] ata2.00: ATAPI: ASUS =A0 =A0DRW-2014L1T, 1.02, max=
 UDMA/66
> > [ =A0 36.560317] ata2.00: configured for UDMA/66
> > [ =A0 36.576547] scsi 1:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0ASUS =A0=
 =A0 DRW-2014L1T
> > 1.02 PQ: 0 ANSI: 5
>
> "libata.force=3D2:udma33" would force it to udma/33 but I don't think
> that would be the problem here. =A0IDENTIFY doesn't use udma anyway.
> Does the problem go away if you do "libata.force=3D2:pio0"?

Thanks for the suggestion, but it didn't help. libata is setup as a
module in Debian's kernel, so I created a /etc/modprobe.d/libata.conf
with "options libata force=3D2:pio0" and rebuilt initrd. This appears t=
o
have properly registered the force flag, but it seems to have only
been applied once the kernel worked through the issue with the
controller/port:

[=A0=A0=A0 3.985969] usbhid: v2.6:USB HID core driver
[=A0=A0=A0 6.316130] ata2.00: qc timeout (cmd 0xa1)
[=A0=A0=A0 6.316135] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
[=A0=A0 11.356004] ata2: link is slow to respond, please be patient (re=
ady=3D0)
[=A0=A0 16.340004] ata2: device not ready (errno=3D-16), forcing hardre=
set
[=A0=A0 21.536004] ata2: link is slow to respond, please be patient (re=
ady=3D0)
[=A0=A0 26.352504] ata2: SRST failed (errno=3D-16)
[=A0=A0 31.548004] ata2: link is slow to respond, please be patient (re=
ady=3D0)
[=A0=A0 36.364514] ata2: SRST failed (errno=3D-16)
[=A0=A0 36.548307] ata2.00: ATAPI: ASUS=A0=A0=A0 DRW-2014L1T, 1.02, max=
 UDMA/66
[=A0=A0 36.548323] ata2.00: FORCE: xfer_mask set to pio0
[=A0=A0 36.564827] ata2.00: configured for PIO0
[=A0=A0 36.565669] scsi 1:0:0:0: CD-ROM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ASUS=A0=A0=A0=A0 DRW-2014L1T
=A0 1.02 PQ: 0 ANSI: 5

I'm not sure if this is due to a modular libata or if that's just the
way it is with this particular problem..

> Thanks.
>
> --
> tejun
>

Thanks,

Mike
