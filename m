From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Mon, 2 Jul 2007 23:47:47 +0200
Message-ID: <20070702214747.GA23182@electric-eye.fr.zoreil.com>
References: <20070702163847.GV29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:52705 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855AbXGBWIU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 18:08:20 -0400
Content-Disposition: inline
In-Reply-To: <20070702163847.GV29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo <htejun@gmail.com> :
> host->irq and host->irq2 should be set before ata_host_register() for
> IRQ reporting to work.  Move up host->irq assignment in
> ata_host_activate() and add it to ata_pci_init_one() native path and
> pata_cs5520.
> 
> The port info printing in ata_host_register() doesn't fit all the
> different controllers.  It should probably be moved out to LLDs with
> some helpers in the future.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Is it supposed to change the behavior below ?

[    0.000000] Linux version 2.6.22-rc7 (root@localhost.localdomain) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) #12 Mon Jul 2 22:36:43 CEST 2007
[...]
[   30.322290] SCSI subsystem initialized
[   30.335668] libata version 2.21 loaded.
[   30.338329] ata_piix 0000:00:1f.2: version 2.11
[   30.338341] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   30.343809] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   30.351476] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   30.351592] scsi0 : ata_piix
[   30.354807] scsi1 : ata_piix
[   30.357975] ata1: SATA max UDMA/133 cmd 0x0001c080 ctl 0x0001c002 bmdma 0x0001b800 irq 0
                                                                                          ^
[   30.366152] ata2: SATA max UDMA/133 cmd 0x0001bc00 ctl 0x0001b882 bmdma 0x0001b808 irq 0
                                                                                          ^

-- 
Ueimor
