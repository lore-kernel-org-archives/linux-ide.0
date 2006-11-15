From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-rc5: Geode GX IDE and compact flash issues
Date: Wed, 15 Nov 2006 23:42:41 +0000
Message-ID: <20061115234241.011205b9@localhost.localdomain>
References: <808c8e9d0611151421k64c22a73p1c51e39cc4b5480@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11997 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162069AbWKOXhV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 18:37:21 -0500
In-Reply-To: <808c8e9d0611151421k64c22a73p1c51e39cc4b5480@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-ide@vger.kernel.org, Jordan Crouse <jordan.crouse@amd.com>

> If I enable the cs5535-specifc IDE driver, Linux can't find the root
> file system.  I haven't been able to get dmesg output for this
> problem, as the kernel panics.

drivers/ide/ problems with CS5535 should go to Jordan. drivers/ata
problems to me.

> [   18.518435] hda: SanDisk SDCFBI-128, CFA DISK drive
> [   19.129769] Probing IDE interface ide1...
> [   19.642558] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   19.643392] hda: max request size: 128KiB

IDE finds the device on 0x1F0

> [   19.643515] hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32
> [   19.643895]  hda: hda1
> [   19.649610] libata version 2.00 loaded.
> [   19.650013] ata: 0x1F0 IDE port busy

libata skips it

> [   19.650027] ata: conflict with ide0
> [   19.650227] PCI: Setting latency timer of device 0000:00:0f.2 to 64
> [   19.650563] ata1: DUMMY

Tejun ought to fix it not to print the above

> [   19.650791] ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
> [   19.650907] scsi0 : cs5535
> [   19.651421] scsi1 : cs5535

We probe the slave in libata

> [   26.689644] ata2: port is slow to respond, please be patient (Status 0xff)

And get stuck because the 2.6.18 code doesn't consider 0xFF as no device
and just skip it.

If you aren't using the CS5535 driver in drivers/ata then don't compile
it in and all will be well. As to the crash - is that the IDE or the new
libata driver which crashes on you ?
