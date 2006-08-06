From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil] kernel 2.6.17(-mm2) test - timeout issue
Date: Mon, 07 Aug 2006 00:51:32 +0900
Message-ID: <44D61004.3070109@gmail.com>
References: <1151182247.5566.18.camel@localhost>	 <449DFDC4.5050207@gmail.com> <1153729271.3860.14.camel@localhost>	 <44CD1512.1060802@gmail.com> <1154785005.9220.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:49694 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932094AbWHFPvo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 11:51:44 -0400
Received: by py-out-1112.google.com with SMTP id z74so1086349pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 08:51:43 -0700 (PDT)
In-Reply-To: <1154785005.9220.1.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWFydGluIEFtbWVybcO8bGxlcg==?= <tenco@gmx.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello,

Martin Ammerm=C3=BCller wrote:
> I tried the patch, but i couldn't see any changes in kerneloutput. I
> also noticed, that there are actually two slightly different
> error-messages.
>=20
> #1 (shorter one, without HSM violation):
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x21)
> ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)

DRDY (device ready), DMA engine active but no DRQ (data request), while=
=20
READ DMA - seems like a packet loss/corruption during data transfer to=20
me, but set DRDY is a bit weird.

> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)

Again, weird.  libata times out waiting for DRDY, which is weird becaus=
e=20
DRDY was set when the timeout occurred (as reported above) but when EH=20
reset code is executed (which should have followed immediately), the=20
code sees !DRDY and times out waiting for it.

> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete

SRST successfully recovers the device in this case.

> #2 (longer, with HSM violation):
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2 frozen

SErr is reporting handshake error (R_ERR seen) diagnostic bit but not=20
reporting any error bit.

> ata1.00: (BMDMA stat 0x20)
> ata1.00: tag 0 cmd 0xc8 Emask 0x2 stat 0x58 err 0x0 (HSM violation)

DMA engine off and DRDY && DRQ.  Again, looks like data transmission=20
error but considering data transmission direction is from device to hos=
t=20
(READ_DMA), the error status is confusing.

> ata1: soft resetting port
> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)

prereset saw set DRDY this time but after SRST, BSY is stuck at 1.

> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ATA: abnormal status 0xD8 on port 0xDCA44087
> ATA: abnormal status 0xD8 on port 0xDCA44087
> ATA: abnormal status 0xD8 on port 0xDCA44087
> ATA: abnormal status 0xD8 on port 0xDCA44087
> ATA: abnormal status 0xD8 on port 0xDCA44087
> ata1.00: qc timeout (cmd 0xec)

We should really fail softreset if ata_busy_sleep() fails in=20
ata_bus_post_reset().  In this case, softreset reports success after=20
timeout causing the following revalidation to timeout too.

> ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> ata1.00: revalidation failed (errno=3D-5)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete

hardreset successfully recovers the device.

Hmmm.. with the patch, sata_sil should have tried hardreset at the firs=
t=20
time in the second case.  There's our third weirdity.  I think the=20
problem can be worked around by...

1. having shorter timeout value on READ/WRITE commands.  30s is *way*=20
too long.

2. making reset procedure more intelligent.  There's no reason to wait=20
full 30s before and after softreset if it's not for hotplug.  It should=
=20
switch to hardreset if the device doesn't respond in several secs.=20
Being responsive && giving device enough time eventually shouldn't be=20
too difficult.

#1 shouldn't be difficult but we need to be careful.  #2 might take som=
e=20
time to implement.

I'm not sure why the previous patch didn't kick in.  The condition=20
should have been caught and EH_HARDRESET requested.  Can you please=20
double check the patched kernel is running?  You can put a little=20
printk() after the freeze: label in sil_interrupt() to be sure.  That's=
=20
the only place where sata_sil freezes the port except for timing out.

Thanks.

--=20
tejun
