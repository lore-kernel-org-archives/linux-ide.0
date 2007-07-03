From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Wed, 4 Jul 2007 00:22:05 +0200
Message-ID: <20070703222205.GA18532@electric-eye.fr.zoreil.com>
References: <20070702163847.GV29122@htj.dyndns.org> <20070702214747.GA23182@electric-eye.fr.zoreil.com> <4689A432.6080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60174 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023AbXGCWYb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 18:24:31 -0400
Content-Disposition: inline
In-Reply-To: <4689A432.6080104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo <htejun@gmail.com> :
> Francois Romieu wrote:
> > Tejun Heo <htejun@gmail.com> :
[...@
> >> The port info printing in ata_host_register() doesn't fit all the
> >> different controllers.  It should probably be moved out to LLDs with
> >> some helpers in the future.
> >>
> >> Signed-off-by: Tejun Heo <htejun@gmail.com>
> > 
> > Is it supposed to change the behavior below ?
> 
> Yeah, didn't it?

I have rebuilt on top of 872aad45d6174570dd2e1defc3efee50f2cfcc72 and it
still seems bizarre:

[    0.000000] Linux version 2.6.22-rc7 (root@localhost.localdomain) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-51)) #13 Tue Jul 3 20:42:14 CEST 2007
[...]
[   30.140053] input: AT Translated Set 2 keyboard as /class/input/input0
[   30.405873] SCSI subsystem initialized
[   30.419216] libata version 2.21 loaded.
[   30.421854] ata_piix 0000:00:1f.2: version 2.11
[   30.421865] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   30.427343] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   30.435010] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   30.435123] scsi0 : ata_piix
[   30.438336] scsi1 : ata_piix
[   30.441502] ata1: SATA max UDMA/133 cmd 0x0001c080 ctl 0x0001c002 bmdma 0x0001b800 irq 0
                                                                                          ^
[   30.449680] ata2: SATA max UDMA/133 cmd 0x0001bc00 ctl 0x0001b882 bmdma 0x0001b808 irq 0
                                                                                          ^
[   30.658396] ata1.00: ata_hpa_resize 1: sectors = 312581808, hpa_sectors = 312581808
[   30.666137] ata1.00: ATA-7: MAXTOR STM3160211AS, 3.AAE, max UDMA/133
[   30.672537] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   30.733289] ata1.00: ata_hpa_resize 1: sectors = 312581808, hpa_sectors = 312581808
[   30.741026] ata1.00: configured for UDMA/133

As Alan said, it is not a serious problem though.

-- 
Ueimor
