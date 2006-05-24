From: Ming Zhang <mingz@ele.uri.edu>
Subject: Re: hotplug works, but newly plug not
Date: Wed, 24 May 2006 17:32:51 -0400
Message-ID: <1148506371.26093.182.camel@localhost.localdomain>
References: <1148484316.26093.72.camel@localhost.localdomain>
	 <4474C737.9000600@gmail.com>
	 <1148504987.26093.177.camel@localhost.localdomain>
	 <1148505606.26093.179.camel@localhost.localdomain>
	 <4474CF3C.4050504@gmail.com>
Reply-To: mingz@ele.uri.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orca.ele.uri.edu ([131.128.51.63]:55498 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S932757AbWEXVc7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2006 17:32:59 -0400
In-Reply-To: <4474CF3C.4050504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide-list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

nothing changed. no plug detected.

ahci 0000:00:1f.2: version 1.3
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: pcs 0xf->0xf
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x0 impl SATA
mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
ata5: SATA max UDMA/133 cmd 0xF8820500 ctl 0x0 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xF8820580 ctl 0x0 bmdma 0x0 irq 19
ata7: SATA max UDMA/133 cmd 0xF8820600 ctl 0x0 bmdma 0x0 irq 19
ata8: SATA max UDMA/133 cmd 0xF8820680 ctl 0x0 bmdma 0x0 irq 19
scsi4 : ahci
ata5: SATA link down (SStatus 0 SControl 0)
scsi5 : ahci
ata6: SATA link down (SStatus 0 SControl 0)
scsi6 : ahci
ata7: SATA link down (SStatus 0 SControl 0)
scsi7 : ahci
ata8: SATA link down (SStatus 0 SControl 0)


On Wed, 2006-05-24 at 14:25 -0700, Tejun Heo wrote:
> Ming Zhang wrote:
> > my fault. forgot to say that the patch does not change the behavior.
> > nothing happen after plug a disk to empty slot.
> > 
> 
> Can you change 0xf to 0xff of the following line in the patch and see if 
> anything changes?
> 
> pci_write_config_byte(pdev, 0x92, 0xf);
>                                    ^^^^-> 0xff
> 
> 

