From: Jochen Heuer <jogi-kernel@planetzork.ping.de>
Subject: Re: Bug or HW? ata1: command timeout, stat 0x50 host_stat 0x4
Date: Sun, 2 Jul 2006 02:07:06 +0200
Message-ID: <20060702000706.GA11103@planetzork.ping.de>
References: <20060627184320.GA16782@planetzork.ping.de> <44A222CB.1080300@gmail.com> <20060628080912.GA18463@planetzork.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lilly.ping.de ([83.97.42.2]:22284 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id S964867AbWGBAOq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Jul 2006 20:14:46 -0400
Content-Disposition: inline
In-Reply-To: <20060628080912.GA18463@planetzork.ping.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jun 28, 2006 at 10:09:12AM +0200, Jochen Heuer wrote:
[...]
> Patch is installed and system is running:
> 
> libata version 1.30 loaded.
> sata_via 0000:00:0f.0: version 1.2
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 18
> sata_via 0000:00:0f.0: routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 18
> ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 18
> scsi0 : sata_via
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for UDMA/133
> scsi1 : sata_via
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: configured for UDMA/133
>   Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> 
> I will monitor this for a some time. And thanks for the quick response!

Hi Tejun,

the system did hang again twice even with the new libata driver but I am not
sure if this really has something to do without. Somehow I am starting to
believe that the problem is somehow IRQ related. Today the network card (skge
driver) did not respond anymore (NETDEV WATCHDOG: eth0: transmit timed out) and
the interrupts did not count up anymore (even though the card still had a
link). Furthermore I remembered some problems with USB mouse and keyboard not
working properly anymore and logged in from remote I saw that interrupts were
also not increasing ... Are there any known issues in this area with SMP
kernels?

Best regards,

   Jochen

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
