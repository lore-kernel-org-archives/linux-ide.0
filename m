From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil via and seagate
Date: Sun, 09 Jul 2006 01:46:06 +0900
Message-ID: <44AFE14E.9000600@gmail.com>
References: <20060705212835.GA28904@lemming.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:52044 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964885AbWGHQpO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 12:45:14 -0400
Received: by py-out-1112.google.com with SMTP id 57so477657pya
        for <linux-ide@vger.kernel.org>; Sat, 08 Jul 2006 09:45:14 -0700 (PDT)
In-Reply-To: <20060705212835.GA28904@lemming.cita.utoronto.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robin Humble <rjh@cita.utoronto.ca>
Cc: linux-ide@vger.kernel.org

Robin Humble wrote:
> sata_sil 0000:00:0a.0: version 0.9
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
> PCI: setting IRQ 4 as level-triggered
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
> ata1: SATA max UDMA/100 cmd 0xE8832080 ctl 0xE883208A bmdma 0xE8832000 irq 4
> ata2: SATA max UDMA/100 cmd 0xE88320C0 ctl 0xE88320CA bmdma 0xE8832008 irq 4
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> irq 4: nobody cared (try booting with the "irqpoll" option)
>  <c013579a> __report_bad_irq+0x36/0x7d  <c0135962> note_interrupt+0x181/0x1b3
>  <c013533a> handle_IRQ_event+0x23/0x4c  <c01353d0> __do_IRQ+0x6d/0x95
>  <c0104b1f> do_IRQ+0x36/0x4e 
>  =======================
>  <c0103416> common_interrupt+0x1a/0x20  <c011d182> __do_softirq+0x2c/0x7f
>  <c0104b6f> do_softirq+0x38/0x41 
>  =======================
>  <c0104b2f> do_IRQ+0x46/0x4e  <c0103416> common_interrupt+0x1a/0x20
>  <c01dd392> acpi_processor_idle+0x15a/0x32c  <c0101db8> cpu_idle+0x3a/0x4f
>  <c03c165e> start_kernel+0x2c0/0x2c4  <c03c119d> unknown_bootoption+0x0/0x201
> handlers:
> [<e887f29c>] (ata_interrupt+0x0/0x128 [libata])
> Disabling IRQ #4
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
> ata1: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
> ata1: qc timeout (cmd 0xef)
> ata1: failed to set xfermode (err_mask=0x4)
> scsi0 : sata_sil
> ata2: SATA link down (SStatus 0)
> scsi1 : sata_sil

Can you try libata-tj-stable patch?

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060708.tar.bz2

-- 
tejun
