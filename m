From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Fri, 22 Jan 2010 13:57:49 +0100
Message-ID: <4B59A0CD.4000801@infernix.net>
References: <4B591D61.8030003@infernix.net> <4B593128.1040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:36450 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab0AVM5t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2010 07:57:49 -0500
Received: from [192.168.0.3] (believe.infernix.lan [192.168.0.3])
	by dx.infernix.net (8.14.3/8.14.3/Debian-5) with ESMTP id o0MCvjGY027565
	for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2010 13:57:46 +0100
In-Reply-To: <4B593128.1040104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 22/01/10 06:01, Robert Hancock wrote:
> If the board has PATA ports driven off the chipset, then in AHCI mode
> you should get two devices showing up, one AHCI controller for the SATA
> ports and one IDE controller for the PATA ports which ata_piix should
> drive. Is that not happening on this board?

This is indeed the problem. In AHCI mode, the PATA port is undetected. 
ata_piix does not handle it at all.


On 22/01/10 06:31, Jeff Garzik wrote:
 > What PCI device is the PATA port? Does the pata_marvell driver enable it?

In compatible mode it's /dev/disk/by-path/pci-0000:00:1f.2-scsi-0:0:0:0 
because i configured the bios to use PATA+SATA. This is the ICH7 
controller (according to lspci).

In Enhanced AHCI mode it does not show up at all on lspci. Poking around 
in /sys shows that ide-gd is responsible for discovering hda; without 
CONFIG_IDE, it's not found at all.

The pata_marvell driver is unrelated, it only serves the two external 
eSATA ports, nothing else. You can even see that it's situated close to 
the eSATA ports whereas the Intel ICH7 SATA and PATA ports are on the 
complete opposite side of the board: 
http://ss4200.pbworks.com/f/IMG_2187.jpg

Full mobo image here: http://ss4200.pbworks.com/f/CIMG0326.jpg

 > Can you provide full lspci?

Sure, compatible mode: 
http://dx.infernix.net/ss4200/lspci-vv.compatible_mode

Enhanced ahci mode: 
http://dx.infernix.net/ss4200/lspci-vv.enhanced_ahci_mode

And just for completion sake, here's what I have enabled in the normal 
2.6.33-rc3 build:

CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y
CONFIG_SATA_AHCI=y
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y
CONFIG_ATA_PIIX=y
CONFIG_SATA_SIL=y
CONFIG_PATA_ACPI=y
CONFIG_ATA_GENERIC=y
CONFIG_PATA_MPIIX=y
CONFIG_PATA_OLDPIIX=y
CONFIG_PATA_SCH=y
# CONFIG_IDE is not set

The build with the IDE driver also has:

CONFIG_IDE=y
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_IDE_PROC_FS=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_SFF=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y


