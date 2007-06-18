From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF flash IDE failure to attach with 2.6.20+
Date: Mon, 18 Jun 2007 20:26:11 +0900
Message-ID: <46766BD3.4040702@gmail.com>
References: <11172839.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:3965 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXFRL0T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 07:26:19 -0400
Received: by py-out-1112.google.com with SMTP id a29so3025749pyi
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 04:26:18 -0700 (PDT)
In-Reply-To: <11172839.post@talk.nabble.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew_hall <andrew.a.hall@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Andrew_hall wrote:
> We have a series of machines that use CF as a boot media. Since upgrading to
> 2.6.20 (tried .9-.14), system will boot (from the flash media) but then fail
> to initialise the same media. Here is the dmesg from 2.6.20.14:
> 
> ata_piix 0000:00:1f.2: version 2.00ac7
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0xFA00 ctl 0xF902 bmdma 0xF600 irq 19
> ata2: SATA max UDMA/133 cmd 0xF800 ctl 0xF702 bmdma 0xF608 irq 19
> scsi0 : ata_piix
> ata1.00: ATA-0, max MWDMA2, 990864 sectors: LBA
> ata1.00: ata1: dev 0 multi count 0
> ata1.00: applying bridge limits
> ata1.00: configured for MWDMA2

For some reason, mwdma doesn't work in libata now.  I'm not sure why
tho.  Alan, can you enlighten us?

Thanks.

-- 
tejun
