From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.6.28.7 boot problems
Date: Fri, 27 Feb 2009 21:11:49 -0600
Message-ID: <49A8AB75.9020006@gmail.com>
References: <40f01080902251346v5f73ed43nacc07bf65c98a727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:45176 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbZB1DL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2009 22:11:57 -0500
Received: by ewy25 with SMTP id 25so1564283ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2009 19:11:53 -0800 (PST)
In-Reply-To: <40f01080902251346v5f73ed43nacc07bf65c98a727@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Schepler <aschepler@gmail.com>
Cc: linux-ide@vger.kernel.org

Andrew Schepler wrote:
> Hi, and apologies if this list is an impolite place to ask for help.
> (If not, where is better?)
> 
> I tried building myself a 2.6.28.7 Linux kernel, but the IDE drivers
> seem not to be working.  My hard drive is IDE ATA.  CONFIG_IDE is
> built into the kernel.  I've tried both with and without
> CONFIG_IDE_GENERIC, but there's not much difference.  The root
> partition is ext2 and ext2 is built into the kernel (but it looks like
> the kernel's not even seeing any drives or partitions.)
> 
> On failed 2.6.28.7 boot, I see the following relevant-looking lines.
> I copied these by hand, so there might be a minor typo.  Yes, the
> kernel lists no partitions after "available partitions:".
> ide-gd driver 1.18
> ide-cd driver 5.00
> ide_generic: please use "probe_mask=0x3f" module parameter
> ...
> VFS: Cannot open root device "hda3" or unknown-block(0,0)
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> Below is a grep excerpt from my .config, and then a successful dmesg
> from kernel 2.6.17.  Can anyone guess what's going wrong?
> 
> Many thanks,
> -- Andrew
> 
> $ grep -Ei 'ide|ata' /usr/src/linux-2.6.28.7/.config
> # CONFIG_ATALK is not set
> # CONFIG_PARIDE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_HAVE_IDE=y
> CONFIG_IDE=y
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> CONFIG_IDE_ATAPI=y
> # CONFIG_BLK_DEV_IDE_SATA is not set
> CONFIG_IDE_GD=y
> CONFIG_IDE_GD_ATA=y
> CONFIG_IDE_GD_ATAPI=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_PROC_FS=y
> # IDE chipset support/bugfixes
> CONFIG_IDE_GENERIC=y
> CONFIG_BLK_DEV_IDEDMA_SFF=y
> # PCI IDE chipsets support
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_IDEPCI_PCIBUS_ORDER is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_ATA=y
> # CONFIG_ATA_NONSTANDARD is not set
> CONFIG_SATA_PMP=y
> # CONFIG_SATA_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> ...
> (the rest of the matching lines are not set)

Sounds like you don't have the chipset-specific IDE driver enabled for 
your hardware (I don't see any of them enabled in this list). I think 
that IDE_GENERIC used to drive the controller in this case, but not 
anymore, as it can only do so in a crappy, non-DMA way.
