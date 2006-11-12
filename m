From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [Fwd: promise-sata-pata, No release code PATA port on Promise
 PDC20579, TODO?]
Date: Sun, 12 Nov 2006 23:08:13 +0100
Message-ID: <45579B4D.2010303@gmx.de>
References: <4555C0B0.1020608@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:21410 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1753356AbWKLWIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Nov 2006 17:08:45 -0500
In-Reply-To: <4555C0B0.1020608@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

thomas schorpp wrote:
> 
> ------------------------------------------------------------------------
> 
> Subject:
> promise-sata-pata, No release code PATA port on Promise PDC20579, TODO?
> From:
> thomas schorpp <t.schorpp@gmx.de>
> Date:
> Fri, 10 Nov 2006 14:41:53 +0100
> To:
> Linux SCSI list <linux-scsi@vger.kernel.org>
> 
> To:
> Linux SCSI list <linux-scsi@vger.kernel.org>
> 
> 
> hi,
> 
> got a msi neo-2 fir now, cause nforce4 is incompatible with scsi+2xdvb 
> on its pci.
> 
> like to use the PATA port of PDC20579 SATA II 150.
> 
> pls list TODOs and outstanding issues blocking the release.
> 
> some testcases for me?
> 
> y
> tom
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

no support at all for this chip's PATA in libata-dev.git:

ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 21
ata1: SATA max UDMA/133 cmd 0xE0EE4200 ctl 0xE0EE4238 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0xE0EE4280 ctl 0xE0EE42B8 bmdma 0x0 irq 21
scsi1 : sata_promise
ata1: SATA link down (SStatus 0 SControl 300)
scsi2 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)
     sata_promise: loaded successfully
     ohci1394: already loaded
     ata_generic: loaded successfully
     pata_via: loaded successfully

but it is mentioned in source, some hints to enable it, pls.

thx,
y
tom
