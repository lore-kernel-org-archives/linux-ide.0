From: "Peter Wells" <pete.wells@gmail.com>
Subject: IT8212 driver seems to be broken - no DMA or functionality in general
Date: Tue, 12 Aug 2008 12:49:11 +0100
Message-ID: <4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
References: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:15255 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbYHLLtM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 07:49:12 -0400
Received: by yw-out-2324.google.com with SMTP id 9so861148ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 04:49:11 -0700 (PDT)
In-Reply-To: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello there,

I have been having a lot of trouble with my ITE 8212 RAID controller
after upgrading from kernel 2.6.18 to 2.6.26.  I have posed to kernel
trap and was advised to mail a copy to this mailing list.  If anyone
has any ideas on how to solve this problem i'd be extremely grateful.

The post is located at http://kerneltrap.org/node/16482 and looks like this:

IT8212 driver seems to be broken - no DMA or functionality in general

August 10, 2008 - 3:20pm
Submitted by Anonymous on August 10, 2008 - 3:20pm.

Hi there,

I am having some problems with my ITE 8212 raid controller. It was
working (more or less OK) in version 2.6.18 but now appears to be
broken in 2.6.25 and 2.6.26.2.

My main issue is that I cannot turn on DMA with the drive. When the
controller was working under 2.6.18, I had to enable DMA before
mounting or even checking the drive as strange disk errors would occur
which resulted in needing to reboot.

First I tried the driver (it8212) in Device Drivers->ATA/ATAPI and
friends->IT821X

After booting, hdparm gives me the following error when I try to set
DMA on the drive:

HDIO_SET_DMA failed: Input/output error

Dmesg also says the following during the boot:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
IT8212: IDE controller (0x1283:0x8212 rev 0x11) at PCI slot 0000:00:09.0
...it821x: controller in smart mode.
IT8212: 100% native mode on irq 10
ide2: BM-DMA at 0xe400-0xe407
ide3: BM-DMA at 0xe408-0xe40f
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
hde: IT8212 RAID 1 volume.
hde: no DMA mode selected
Probing IDE interface ide3...
...
hde: max request size: 128KiB
hde: 117231406 sectors (60022 MB), CHS=7297/255/63
hde: cache flushes not supported
hde: hde1
Driver 'sd' needs updating - please use bus_type methods

I managed to find this thread, which seemed relevant, but it seems the
problem still exists :<

I have also tried using the driver (IT8211/2 PATA Support) in Serial
ATA (prod) and Parallel ATA (experimental) drivers

Dmesg then gives me the following (see below).

Any help with this would be greatly appreciated, as I've been banging
my head against my monitor for almost the whole weekend :>

Kind regards,

Pete

pete dot wells at gmail dot com

Driver 'sd' needs updating - please use bus_type methods
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
pata_it821x: controller in smart mode.
PCI: Setting latency timer of device 0000:00:09.0 to 64
scsi0 : pata_it821x
scsi1 : pata_it821x
ata1: PATA max MWDMA2 cmd 0xd400 ctl 0xd800 bmdma 0xe400 irq 10
ata2: PATA max MWDMA2 cmd 0xdc00 ctl 0xe000 bmdma 0xe408 irq 10
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1: failed to recover some devices, retrying in 5 secs
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1: failed to recover some devices, retrying in 5 secs
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1: failed to recover some devices, retrying in 5 secs
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
