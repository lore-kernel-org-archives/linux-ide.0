From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA causing hard freeze on 2.6.6
Date: Sun, 16 May 2004 08:18:24 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A75C10.1030402@pobox.com>
References: <40A75BF3.7040403@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263589AbUEPMSi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 08:18:38 -0400
In-Reply-To: <40A75BF3.7040403@gentoo.org>
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-ide@vger.kernel.org

Daniel Drake wrote:
> Hi,
> 
> Since an IDE-->SATA converter was included with my motherboard, I 
> decided to start playing with SATA.
> 
> The converter unit plugs into the IDE port of a hard disk, and you can 
> then connect a SATA lead from that to a SATA port on the motherboard.
> 
> The hard disk I am using is a Seagate ST380011A.
> The motherboard is an Abit NF7-S 2.0 (nforce2), which has the following 
> SATA controller:
> 0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
> Technology Inc) Silicon Image Serial ATARaid Controller [ CMD/Sil 
> 3112/3112A ] (rev 02)
> 
> Under 2.6.6, the entire system freezes under disk activity. It starts 
> booting ok, but then freezes, usually when loading modules. Booting with 
> "init=/bin/bash" allows me to get to a console, but soon after I start 
> using the disk, the entire system freezes. I also tried 2.6.6-mm2 with 
> the same problems.
> Plugging back into IDE, and booting the same kernel works with no problems.
> 
> FWIW, my SATA experiences aren't much better with other kernels. When 
> booting 2.4.25 from a CD, I can mount my SATA disk but I get lots of 
> messages, such as:
> hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
> ide2(33,7):Removing [4428992 4467719 0x0 SD]..<4>hde: sata_error = 
> 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
> done
> ide2(33,7):There were 1 uncompleted unlinks/truncates. Completed
> hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
> hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
> 
> Booting 2.6.5 from a cd and mounting the drive gives the same errors. 
> However, in both cases, reading and writing appears to be working (but I 
> unmounted quickly both times incase the errors might be damaging the 
> disk..)
> 
> Anything I could try?

What is the behavior of libata?

CONFIG_SCSI_SATA, CONFIG_SCSI_SATA_SIL

	Jeff




