From: Tejun Heo <htejun@gmail.com>
Subject: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Fri, 04 Aug 2006 21:00:46 +0900
Message-ID: <44D336EE.5000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:48316 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932611AbWHDMAx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 08:00:53 -0400
Received: by py-out-1112.google.com with SMTP id t32so274439pyc
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 05:00:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

pdc_adma in libata-dev#upstream fails to IDENTIFY device w/ AC_ERR_HSM.

libata version 2.00 loaded.
pdc_adma 0000:01:02.0: version 0.04
ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKG] -> GSI 5 (level, low) 
-> IRQ 5
[ata_device_add      ] ENTER
[ata_port_add        ] ENTER
[ata_port_start      ] prd alloc, virt f62e1000, dma 362e1000
ata1: PATA max UDMA/66 cmd 0xF881AC00 ctl 0xF881AC38 bmdma 0x0 irq 5
[ata_port_add        ] ENTER
[ata_port_start      ] prd alloc, virt f6304000, dma 36304000
ata2: PATA max UDMA/66 cmd 0xF881AC40 ctl 0xF881AC78 bmdma 0x0 irq 5
[ata_device_add      ] probe begin
scsi0 : pdc_adma
[ata_device_add      ] ata1: bus probe begin
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
ata1.00: ata_dev_read_id: ENTER, host 1, dev 0
[ata_exec_command_mmio] ata1: cmd 0xEC
[adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
ata1.00: ata_dev_read_id: ENTER, host 1, dev 0
[ata_exec_command_mmio] ata1: cmd 0xEC
[adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
ata1.00: ata_dev_read_id: ENTER, host 1, dev 0
[ata_exec_command_mmio] ata1: cmd 0xEC
[adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata1.00: limiting speed to PIO0
ata1.00: disabled
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
[ata_device_add      ] ata1: bus probe end
scsi1 : pdc_adma
[ata_device_add      ] ata2: bus probe begin
[ata_bus_reset       ] ENTER, host 2, port 1
[ata_bus_softreset   ] ata2: bus reset via SRST
ata2: disabling port
[ata_bus_reset       ] EXIT
[ata_device_add      ] ata2: bus probe end
[ata_device_add      ] host probe begin

I've tested both cards and cables Mark sent me (thanks!), and both show 
the same symptom for ATA harddisk and ATAPI cdrom, so this seems to be a 
driver issue.  Any ideas?

Thanks.

-- 
tejun
