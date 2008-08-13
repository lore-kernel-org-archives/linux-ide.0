From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Wed, 13 Aug 2008 09:40:24 +0200
Message-ID: <8db1092f0808130040u25876f45gbb4fa641959f5110@mail.gmail.com>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com>
	 <20080812081632.303de380@lxorguk.ukuu.org.uk>
	 <8db1092f0808120107k1f8a65f4sf406fa3a89125870@mail.gmail.com>
	 <200808121645.37539.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:46064 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbYHMHkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 03:40:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5342806wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 00:40:25 -0700 (PDT)
In-Reply-To: <200808121645.37539.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

I remove this options (2.6.27-rc2:
CONFIG_IDE, CONFIG_ATA_PIIX, CONFIG_ATA_SFF

from libata only I have CONFIG_ATA_ACPI and CONFIG_SATA_AHCI

boot dies on:

[...]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00000040, connection status changed irq 220
ata2: DUMMY
ata3: DUMMY
ata4: DUMMY

after should be:
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 filtered out
ata1.00: ACPI cmd c6/00:10:00:00:00:a0 succeeded
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
[...]

-- 
Maciek
