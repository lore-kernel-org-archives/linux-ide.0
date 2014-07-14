From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA disks disabled on boot
Date: Mon, 14 Jul 2014 12:36:41 -0400
Message-ID: <20140714163641.GF31610@htj.dyndns.org>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:60113 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbaGNQgo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jul 2014 12:36:44 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so2223062qgd.27
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2014 09:36:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nuno =?iso-8859-1?Q?Magalh=E3es?= <nunomagalhaes@eu.ipp.pt>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Jul 11, 2014 at 10:06:14PM +0100, Nuno Magalh=E3es wrote:
>     # dmesg |grep ata4
>     [    0.914589] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma
> 0xf308 irq 20
>     [    2.356417] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
>     [    2.364553] ata4.00: ATA-9: WDC WD10EFRX-68PJCN0, 01.01A01, ma=
x UDMA/133
>     [    2.364556] ata4.00: 268435455 sectors, multi 1: LBA NCQ (dept=
h 31/32)
>     [    2.372541] ata4.00: n_sectors mismatch 268435455 !=3D 1953525=
168
>     [    2.372543] ata4.00: revalidation failed (errno=3D-19)
>     [    2.372590] ata4: limiting SATA link speed to 1.5 Gbps
>     [    2.372592] ata4.00: limiting speed to UDMA/133:PIO3
>     [    7.824219] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
>     [    7.833088] ata4.00: n_sectors mismatch 268435455 !=3D 1953525=
168
>     [    7.833091] ata4.00: revalidation failed (errno=3D-19)
>     [    7.833135] ata4.00: disabled

So, the device initially reports that it doesn't support LBA48 and
then later changes its mind later on for some reason.  That's weird.
I wonder whether the controller is meddling with the IDENTIFY data.
AFAICS, there isn't anything in ATA spec which would make a device
change whether it reports 48 bit support or not.

Can you please try the followings?

1. After boot is complete, re-trigger device attach by doing

   echo - - - > /sys/class/scsi_host/hostN/scan

2. Boot with libata.force=3Ddump_id and report full dmesg after boot.

3. Boot with libata.force=3Dnohrst and see whether anything changes.

Thanks.

--=20
tejun
