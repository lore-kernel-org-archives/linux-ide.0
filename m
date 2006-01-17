From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Adaptec 1420SA issues with MSI
Date: Tue, 17 Jan 2006 14:39:44 -0500
Message-ID: <43CD4800.20604@pobox.com>
References: <1136667984.2799.0.camel@obelisk.thedillows.org> <20060109221323.65f6987d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932416AbWAQTjy@vger.kernel.org>
In-Reply-To: <20060109221323.65f6987d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Dillow <dave@thedillows.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andrew Morton wrote:
> Andi says "It's more likely a hardware bug that needs to be handled by the
> driver maintainer.  sata_mv has an pci_enable_msi().  Hardware that reports
> MSI capability but breaks when it's actually used is not unheard of."
> 
> -sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via MSI
> -ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 177
> -ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 177
> -ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 177
> -ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 177
> +sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via INTx
> +ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 18
> +ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 18
> +ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 18
> +ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 18
> 
> It seems strange that pci_enable_msi() succeeded if the device is not
> MSI-capable?

See http://lkml.org/lkml/2006/1/17/145

pci_enable_msi() has a problem where it succeeds when it should not, but 
also, sata_mv is still missing some errata workarounds that could be 
affecting MSI platforms.

	Jeff
