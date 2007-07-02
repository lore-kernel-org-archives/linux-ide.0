From: Tejun Heo <htejun@gmail.com>
Subject: Re: State of Port Multiplier Support in libata?
Date: Tue, 03 Jul 2007 00:07:10 +0900
Message-ID: <4689149E.5030704@gmail.com>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk> <4688C700.6070901@gmail.com> <4688FC96.7040604@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:51991 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXGBPHP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 11:07:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so916840nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 08:07:15 -0700 (PDT)
In-Reply-To: <4688FC96.7040604@enhance-it.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Skotte <sfs@enhance-it.dk>
Cc: linux-ide@vger.kernel.org

Hello,

Stefan Skotte wrote:
> ============================
> Here's the full log after a reboot, and me powering up the array
> manually afterwards:
> ============================
> [ 9995.743400] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
> frozen
> [ 9995.743409] ata1: irq_stat 0x00b40090 <PHY RDY changed>
> [ 9995.743419] ata1: hard resetting link
> [ 9997.936879] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [ 9998.080620] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
> feat 0x9/0x9
> [ 9998.208414] ata1.00: hard resetting link
> [ 9998.691615] ata1.00: softreset failed (SRST command error)
> [ 9998.691623] ata1.00: reset failed (errno=-5), retrying in 10 secs

Hmmm... it seems we can do a bit better here with shorter retry
interval.  The driver probably spins up in 5~7 secs.  The rest is wasted
here.  10secs isn't too bad tho.

> =============================
> Booting with array turned on:
> (disks are spun up one at a time)
> This also includes my slim dvdrw + seagate 500gb drive.
> =============================

Everything looks good.

> =============================
> Array turned of without rmmod'ing sata_sil24:
> =============================
[--snip--]
> [  351.479090] ata1.15: failed to read PMP product ID
> [  351.479096] ata1.15: retrying hardreset
> [  351.479106] ata1.15: hard resetting link
> [  356.566580] ata1.15: SATA link down (SStatus 1 SControl 0)
> [  356.822165] ata1.15: failed to read PMP GSCR[0] (errno=-5)
> [  356.822172] ata1.15: PMP revalidation failed (errno=-5)
> [  356.822179] ata1.15: limiting SATA link speed to 1.5 Gbps
> [  356.822184] ata1.15: retrying hardreset in 5 secs
> [  361.817800] ata1.15: hard resetting link
> [  366.905308] ata1.15: SATA link down (SStatus 1 SControl 10)
> [  367.160893] ata1.15: failed to read PMP GSCR[0] (errno=-5)
> [  367.160900] ata1.15: PMP revalidation failed (errno=-5)
> [  367.160906] ata1.15: retrying hardreset in 5 secs
> .. and continues to retry

The retry limit is 5 times.  Because losing PMP makes all downstream
devices detached, I thought it's worth to try hard.  If you put another
device including another PMP there, libata will give up the current one
quickly (after only two tries).

> =============================
> Array turned on again:
> =============================
> (continued from above)
> [  372.156532] ata1.15: hard resetting link
> [  377.244059] ata1.15: SATA link down (SStatus 1 SControl 10)
> [  377.499621] ata1.15: failed to read PMP GSCR[0] (errno=-5)
> [  377.499628] ata1.15: PMP revalidation failed (errno=-5)
> [  377.499635] ata1.15: retrying hardreset in 5 secs
> [  382.495257] ata1.15: hard resetting link
> [  387.582767] ata1.15: SATA link down (SStatus 1 SControl 10)
> [  387.838349] ata1.15: failed to read PMP GSCR[0] (errno=-5)
> [  387.838356] ata1.15: PMP revalidation failed (errno=-5)

Ah... This is unfortunate.  Even though the array was turned back on, it
failed to respond to the last two tries resulting in detachment.  I
wonder why it failed to respond to two tries.  Is this behavior
reproducible?  If so, does updating firmware of PMP help?

> [  387.838360] ata1.15: failed to recover PMP after 3 tries, giving up

Ummm.... This should have been five.

> [  387.838365] ata1.15: Port Multiplier detaching
> [  387.838391] ata1.00: disabled
> [  387.838398] ata1.04: disabled
> [  387.838403] ata1.00: disabled

The rest looks fine.

> ==============================
> Disk in bay 2 reinserted:
> ==============================
> [  600.263465] ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000
> action 0xb
> [  600.295411] ata1.00: hard resetting link
> [  601.193925] ata1.00: softreset failed (SRST command error)
> [  601.193933] ata1.00: reset failed (errno=-5), retrying in 10 secs
> [  610.278721] ata1.00: hard resetting link
> [  611.305018] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  611.350966] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
> [  611.350974] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [  611.409167] ata1.00: configured for UDMA/100
> [  611.424823] ata1: EH complete

Pretty, isn't it?  :-)

Thanks.

-- 
tejun
