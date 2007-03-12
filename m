From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-rc3-git4 ata1.00: qc timeout (cmd 0xef) (crashdump kernel)
Date: Mon, 12 Mar 2007 17:40:56 +0900
Message-ID: <45F51218.9030907@gmail.com>
References: <6bffcb0e0703090857r14eda34bj92f3fd1d0008edb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:45221 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965349AbXCLIk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 04:40:56 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1304575nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 01:40:55 -0700 (PDT)
In-Reply-To: <6bffcb0e0703090857r14eda34bj92f3fd1d0008edb8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Michal Piotrowski wrote:
> Hi Jeff,
> 
> I've got some problems with my SATA controller on crashdump kernel.
> 
> Calling initcall 0xc1916081: fc_transport_init+0x0/0x35()
> Calling initcall 0xc19160b6: init_sd+0x0/0xbc()
> Calling initcall 0xc19161ec: piix_init+0x0/0x27()
> ata_piix 0000:00:1f.2: version 2.10
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> Link [LNKC] -> GSI 5 (level,
> low) -> IRQ 5
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x0001cc00 ctl 0x0001c882 bmdma 0x0001c400
> irq 5
> ata2: SATA max UDMA/133 cmd 0x0001c800 ctl 0x0001c482 bmdma 0x0001c408
> irq 5
> scsi0 : ata_piix
> PM: Adding info for No Bus:host0
> ata1.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
> ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
> ata1.00: qc timeout (cmd 0xef)
> ata1.00: failed to set xfermode (err_mask=0x4)

Does giving 'irqpoll' boot parameter fix the problem?

-- 
tejun
