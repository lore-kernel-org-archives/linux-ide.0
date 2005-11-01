From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Asus A8V , via vt8251 AHCI
Date: Tue, 1 Nov 2005 07:40:06 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0511010736550.11761@shark.he.net>
References: <20051101064058.GA4902@vcr.star-c.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:12493 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750902AbVKAPkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2005 10:40:08 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 07:40:06 -0800
In-Reply-To: <20051101064058.GA4902@vcr.star-c.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ibedonc@star-c.comibedonc@star-c.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 1 Nov 2005, Don Carroll wrote:

> Hi , I added pci id 3349 to achi.c and I get it to load now
> ahci version 1.00
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 217
> PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 9
> ahci(0000:00:0f.0) AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
> ahci(0000:00:0f.0) flags: 64bit ncq pm led clo pmp pio slum part
> ata3: SATA max UDMA/133 cmd 0xFFFFC20000038900 ctl 0x0 bmdma 0x0 irq 217
> ata4: SATA max UDMA/133 cmd 0xFFFFC20000038980 ctl 0x0 bmdma 0x0 irq 217
> ata5: SATA max UDMA/133 cmd 0xFFFFC20000038A00 ctl 0x0 bmdma 0x0 irq 217
> ata6: SATA max UDMA/133 cmd 0xFFFFC20000038A80 ctl 0x0 bmdma 0x0 irq 217
> ata3: no device found (phy stat 00000000)
> scsi2 : ahci
> ata4: no device found (phy stat 00000000)
> scsi3 : ahci
> ata5: no device found (phy stat 00000000)
> scsi4 : ahci
> ata6 is slow to respond, please be patient
> ata6 failed to respond (30 secs)
> scsi5 : ahci
>
> I have a drive on ata6 , but it does not respond , timesout
>
> this is Mandriva 2006 x86_64 and it has 2.6.12 I have not been able to get .14
> to compile yet , does this look like something that ahci 1.01 would help , any
> ideas ?

Yes.
(a) boot with "irqpoll" added to the kernel command line to see
if the kernel can route the missed interrupts.

different test:
(b) Disable CONFIG_PCI_MSI and reboot/retest (without "irqpoll").

and report the results of those.

What are your configs for SMP and APIC options?

-- 
~Randy
