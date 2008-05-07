From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [git patches] libata updates - (improve post-reset device
	ready test) regression
Date: Wed, 7 May 2008 16:56:16 +0200
Message-ID: <20080507145616.GA2210@gentoox2.trippelsdorf.de>
References: <20080506154847.GA15299@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760442AbYEGO5p@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080506154847.GA15299@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, htejun@gmail.com
List-Id: linux-ide@vger.kernel.org

> 
> Tejun Heo (12):
>       libata: improve post-reset device ready test

This commit (78ab88f04f44bed566d51dce0c7cbfeff6449a06) causes a long
boot delay with my onboard Promise controller. It seems like libata
probes for a nonexisting PATA drive...

ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
ata1: SATA max UDMA/133 mmio m4096@0xfb600000 port 0xfb600200 irq 18
ata2: SATA max UDMA/133 mmio m4096@0xfb600000 port 0xfb600280 irq 18
ata3: PATA max UDMA/133 mmio m4096@0xfb600000 port 0xfb600300 irq 18
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: SAMSUNG HD753LJ, 1AA01109, max UDMA7
ata2.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133                                                                                          
ata3: link is slow to respond, please be patient (ready=0)
ata3: device not ready (errno=-16), forcing hardreset
ata3: link is slow to respond, please be patient (ready=0)
ata3: SRST failed (errno=-16)
ata3: link is slow to respond, please be patient (ready=0)
ata3: SRST failed (errno=-16)
ata3: link is slow to respond, please be patient (ready=0)
ata3: SRST failed (errno=-16)
  - Last output repeated twice -
ata3: reset failed, giving up

-- 
Markus
