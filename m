From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Tue, 9 Sep 2008 11:52:48 +0100
Message-ID: <20080909115248.580eba78@lxorguk.ukuu.org.uk>
References: <48C45BEF.5090502@gmail.com>
	<20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
	<48C5BD49.6090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52377 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbYIIKxF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 06:53:05 -0400
In-Reply-To: <48C5BD49.6090204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antonio Cardoso Martins <digiplan.pt@gmail.com>
Cc: linux-ide@vger.kernel.org

> The ATA adapter is embedded into the motherboard. Looking at the board,
> the chipset reads Cyrix Cx5530. There is some contradictory information
> about whether this chip supports DMA or not. Regarding the CF, i am

The CS5530 supports UDMA, the CF card may well support UDMA but there is
a third ingredient in the CF cases - whatever connects the two must
support UDMA. A lot of (especially older) CF convertors, CF cards slots
on boards and the like do not even have the required wiring present,
others don't have to to the standard needed for UDMA.

> ata1.00: ATA-5: SILICON POWER, 2.0, mas UDMA/66

Your CF card reports that it supports UDMA so I am quite sure it does.

> sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA

So PIO works and DMA doesn't.

> Does this give any interesting info to the problem?

It matches the other driver behaviour which is very helpful.

> PS: Since i cannot provide parameters to the kernel, i don't know how
> the kernel i have completely working (2.6.22.15) figure out that he
> should continue boot from root=/dev/hda1. This kernel does not seem to
> get to that conclusion.

It would be /dev/sda1. I've no idea how the firmware bootloader passes
information to the kernel on your netvista. You could see if the old
rdev stuff is used (rdev /vmlinuz /dev/sda1)

For the PIO find

static int libata_dma_mask = ....

In drivers/ata/libata-core.c and change it to = 0;
