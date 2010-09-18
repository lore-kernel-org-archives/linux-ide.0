From: "Joshua Hintze" <joshh@imsar.com>
Subject: RE: PATA IDE is slower in newer versions of kernel
Date: Sat, 18 Sep 2010 11:12:31 -0600
Message-ID: <010901cb5754$ae6735a0$0b35a0e0$@com>
References: <00d401cb55f7$33a78210$9af68630$@com> <20100917154732.330c4b1b@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da-3.dns-solutions.net ([69.12.112.3]:65463 "HELO
	mail-da-3.dns-solutions.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753569Ab0IRRMk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Sep 2010 13:12:40 -0400
In-Reply-To: <20100917154732.330c4b1b@varda>
Content-Language: en-us
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Some updated information. I created a screen capture of what I am seein=
g. First is the logic analyzer when the newer linux kernel is writing s=
low to the PATA port.

http://i56.tinypic.com/oqhrug.png

Notice in the above link how there is a lot of activating and then larg=
e gaps of no activity. After about 9 mS the STOP line is strobed a few =
times and then DMARQ finally returns to normal operating. The link belo=
w shows the picture of an old 2.6.10 kernel where write speeds are much=
 faster.

http://i51.tinypic.com/a9wiur.png

In the above image notice how the wait time is considerable less 100's =
of microseconds before the stop lines get strobed.

I'm dedicated to continue working on the problem, I just need to advice=
 from the linux community. I've tried different I/O schedulers such as =
noop and anticipatory and I'm studying the ide-dma code but still lost =
to where this is happening.

Thanks!



-----Original Message-----
=46rom: linux-ide-owner@vger.kernel.org [mailto:linux-ide-owner@vger.ke=
rnel.org] On Behalf Of Alejandro Riveira Fern=C3=A1ndez
Sent: Friday, September 17, 2010 7:48 AM
To: Joshua Hintze
Cc: linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org
Subject: Re: PATA IDE is slower in newer versions of kernel

El Thu, 16 Sep 2010 17:30:51 -0600
"Joshua Hintze" <joshh@imsar.com> escribi=C3=B3:

 [ Just CC linux-ide ]

> Hello,=20
>=20
> I've been digging into this for a couple weeks now. I have an embedde=
d board
> that runs Linux Kernel 2.6.10 that is connected to a SSD over a PATA
> connection. Data is transferred using UDMA4 speeds and I get a nice
> sustained write speed of about 20 MBps which is adequate for us.=20
>=20
> I have recently taken the plunge to update to a newer version of the =
kernel
> starting at 2.6.32 (also tried 2.6.33) and what I am seeing writes sp=
eeds
> drop to about 18 MBps peak with large jumps going from 8 MBps->16 MBs=
 for
> sustained throughput.
>=20
> I decided to read up on the ATA specification and I connected a logic
> analyzer to the PATA bus and here is what is happening...after a larg=
e chunk
> of data is written to the device, instead of the device pausing the t=
ransfer
> by asserting DDMARDY it actual initiates a device data-out terminatio=
n by
> pulling DMARQ low.
>=20
> The old kernel 2.6.10 responds to this by strobing the STOP line 8 ti=
mes
> within 800uS and the device releases DMARQ shortly afterwards. On the=
 newer
> kernels the strobing of the STOP line takes near 8mS of time. Since t=
he hard
> drive only release DMARQ after this 8 pulse strobe I believe this is =
the
> cause of the slower write speeds on the newer kernels. This whole pro=
cess
> happens thousands of times when writing megs of data. So those extra =
7mS
> begin to add up fast.
>=20
> My problem is I've been digging through the ide.c/ide-dma.c and other=
 code
> but I'm not exactly sure where the code would jump to upon a device
> initiated termination on a data-out dma transfer.
>=20
> My guess is ide_dma_intr(...). Is this correct?
>=20
> Any other areas I could look at?
>=20
> Thanks in advance.
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

No virus found in this incoming message.
Checked by AVG - www.avg.com=20
Version: 9.0.851 / Virus Database: 271.1.1/3132 - Release Date: 09/16/1=
0 12:34:00

