From: Jochen Heuer <jogi-kernel@planetzork.ping.de>
Subject: Re: Bug or HW? ata1: command timeout, stat 0x50 host_stat 0x4
Date: Wed, 28 Jun 2006 10:09:12 +0200
Message-ID: <20060628080912.GA18463@planetzork.ping.de>
References: <20060627184320.GA16782@planetzork.ping.de> <44A222CB.1080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lilly.ping.de ([83.97.42.2]:5895 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id S1423216AbWF1IOo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jun 2006 04:14:44 -0400
Content-Disposition: inline
In-Reply-To: <44A222CB.1080300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

> >ata1: command 0xca timeout, stat 0x50 host_stat 0x4
> >ata1: status=0x50 { DriveReady SeekComplete }
> >ata1: command 0xea timeout, stat 0x50 host_stat 0x0
> >ata1: status=0x50 { DriveReady SeekComplete }
> 
> The original error is probably a hardware problem.

ok, I will try to get this disc replaced after some testing ...

> >I had hoped 2.6.17 would fix this since I seem to remember some fixes for
> >libata with similar error messages. But at least on my system it did not.
> 
> Can you apply the following patch and see what happens?

Patch is installed and system is running:

libata version 1.30 loaded.
sata_via 0000:00:0f.0: version 1.2
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 18
sata_via 0000:00:0f.0: routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 18
ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 18
scsi0 : sata_via
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
scsi1 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05

I will monitor this for a some time. And thanks for the quick response!

   Jochen

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
