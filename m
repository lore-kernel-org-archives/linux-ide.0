From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?=
	<ariveira@gmail.com>
Subject: Re: PATA IDE is slower in newer versions of kernel
Date: Fri, 17 Sep 2010 15:47:32 +0200
Message-ID: <20100917154732.330c4b1b@varda>
References: <00d401cb55f7$33a78210$9af68630$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59965 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0IQNrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 09:47:39 -0400
In-Reply-To: <00d401cb55f7$33a78210$9af68630$@com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joshua Hintze <joshh@imsar.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

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
