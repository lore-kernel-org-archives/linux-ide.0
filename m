From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Fri, 04 Aug 2006 09:56:09 -0400
Message-ID: <44D351F9.3070302@rtr.ca>
References: <44D336EE.5000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:11139 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161193AbWHDN4L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Aug 2006 09:56:11 -0400
In-Reply-To: <44D336EE.5000907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> pdc_adma in libata-dev#upstream fails to IDENTIFY device w/ AC_ERR_HSM.
> 
> libata version 2.00 loaded.
> pdc_adma 0000:01:02.0: version 0.04
> ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKG] -> GSI 5 (level, low) 
> -> IRQ 5
> [ata_device_add      ] ENTER
> [ata_port_add        ] ENTER
> [ata_port_start      ] prd alloc, virt f62e1000, dma 362e1000
> ata1: PATA max UDMA/66 cmd 0xF881AC00 ctl 0xF881AC38 bmdma 0x0 irq 5
> [ata_port_add        ] ENTER
> [ata_port_start      ] prd alloc, virt f6304000, dma 36304000
> ata2: PATA max UDMA/66 cmd 0xF881AC40 ctl 0xF881AC78 bmdma 0x0 irq 5
> [ata_device_add      ] probe begin
> scsi0 : pdc_adma
> [ata_device_add      ] ata1: bus probe begin
> [ata_bus_reset       ] ENTER, host 1, port 0
> [ata_bus_softreset   ] ata1: bus reset via SRST
> [ata_dev_classify    ] found ATA device by sig
> [ata_dev_classify    ] found ATA device by sig
> [ata_bus_reset       ] EXIT
> ata1.00: ata_dev_read_id: ENTER, host 1, dev 0
> [ata_exec_command_mmio] ata1: cmd 0xEC
> [adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
> [ata_port_flush_task ] ENTER
> [ata_port_flush_task ] flush #1
> ata1: ata_port_flush_task: flush #2
> ata1: ata_port_flush_task: EXIT
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
..
> I've tested both cards and cables Mark sent me (thanks!), and both show 
> the same symptom for ATA harddisk and ATAPI cdrom, so this seems to be a 
> driver issue.  Any ideas?

Well, ATAPI not working is no suprise -- officially that chipset doesn't
support ATAPI (on MS Win), but it ought to be workable in PIO mode for us.

But not finding the HD is more of an issue.  I wonder what motherboard/CPU
you are trying this on, and has it *ever* worked for you Tejun?

My newish old AMD64 box here seems to have problems with a number
of boards, including the pdc_adma ones.  Not sure why, as the exact same
kernels work fine with the exact same board/drives in my Intel P4 box.

Something to add to the list of things to look at, I suppose.

Cheers
