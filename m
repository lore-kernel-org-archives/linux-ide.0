From: "Davidlohr Bueso A." <dbueso@linuxchile.cl>
Subject: Re: Problems with DMA enabling
Date: Wed, 17 Aug 2005 13:31:25 -0400
Message-ID: <1124299885.3851.7.camel@localhost>
References: <1124293208.3885.10.camel@localhost>
	 <1124294354.5948.18.camel@localhost.localdomain>
Reply-To: dbueso@linuxchile.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pc-79-164-104-200.cm.vtr.net ([200.104.164.79]:29917 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1751184AbVHQRcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 13:32:55 -0400
In-Reply-To: <1124294354.5948.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

On Wed, 2005-08-17 at 17:59 +0200, Erik Slagter wrote:
> On Wed, 2005-08-17 at 11:40 -0400, Davidlohr Bueso A. wrote:
> ROFL! Sorry...

I didn't mention that I recompiled/rebooted my system after making the
changes because it is obvious that I did it. I'm also not using my
debian-precompiled kernel -> I got 2.6.12.3 from kernel.org
> 
> You're changing a kernel BUILDING parameter here. It will not have any
> effect until you recompile your kernel, so kiss your debian pre-compiled
> kernel goodbye ;-)
> 
> There are actually several HOWTO's for kernel (re)building, btw.
> 
> If you are going to do this, you need to apply this patch as well (see
> attachment) or your computer will lock up every now and then.
> 
> If you have built the new kernel and booted it, your cd/dvd drive will
> now be claimed by libata and show up as /dev/scd0 instead of /dev/hdc
> (or similar). Hdparm -d 1 will not work (either), but DMA will be used
> anyway.

I added the patch you attached, recompiled, rebooted and still can't
use /dev/scd0 (not a valid block device), here's what I get with dmes|
grep ata:

libata version 1.11 loaded.
ata_piix version 1.03
ata: 0x170 IDE port busy
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:7fe9 84:4023 85:f469 86:3e49 87:4023
88:203f
ata1: dev 0 ATA, max UDMA/100, 117210240 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix

Thanks,
Dave
