From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Sat, 05 Aug 2006 00:02:14 +0900
Message-ID: <44D36176.7030407@gmail.com>
References: <44D336EE.5000907@gmail.com> <44D351F9.3070302@rtr.ca> <44D3572E.6040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:11441 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932274AbWHDPCW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 11:02:22 -0400
Received: by nf-out-0910.google.com with SMTP id n15so100317nfc
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 08:02:21 -0700 (PDT)
In-Reply-To: <44D3572E.6040907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>> But not finding the HD is more of an issue.  I wonder what 
>> motherboard/CPU
>> you are trying this on, and has it *ever* worked for you Tejun?
> 
> This is P5LD2 (ICH7R) w/ P4 celeron.  The kernel was built for i386. 
> This is my first time to actually try these cards.  I'm updating 
> initialization, so I'm doing sweep-test on all the cards I have.  I'll 
> put it into via-c3 and see what happens.  I'll also try older kernel 
> before big libata EH updates.

Okay, the same on via-c3 with the same libata-dev#upstream.

ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 10 (level, 
low) -> IRQ 10
[ata_device_add      ] ENTER
[ata_host_add        ] ENTER
[ata_port_start      ] prd alloc, virt cc46c000, dma c46c000
ata1: PATA max UDMA/66 cmd 0xCE8AC000 ctl 0xCE8AC038 bmdma 0x0 irq 10
[ata_host_add        ] ENTER
[ata_port_start      ] prd alloc, virt cca6d000, dma ca6d000
ata2: PATA max UDMA/66 cmd 0xCE8AC040 ctl 0xCE8AC078 bmdma 0x0 irq 10
[ata_device_add      ] probe begin
scsi0 : pdc_adma
[ata_device_add      ] ata1: bus probe begin
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
[ata_exec_command_mmio] ata1: cmd 0xEC
[adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
[ata_exec_command_mmio] ata1: cmd 0xEC
[adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
[ata_exec_command_mmio] ata1: cmd 0xEC
[adma_intr_mmio      ] ata1: protocol 2 (dev_stat 0x58)
[ata_port_flush_task ] ENTER
[ata_port_flush_task ] flush #1
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

===============================================================

v2.6.17 successfully identifies the disk but times out while trying to 
read the partition table and locks up the whole machine. (complete 
lockup, IRQ dead)


ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 10 (level, 
low) -> IRQ 10
ata1: PATA max UDMA/66 cmd 0xCE8AC000 ctl 0xCE8AC038 bmdma 0x0 irq 10
ata2: PATA max UDMA/66 cmd 0xCE8AC040 ctl 0xCE8AC078 bmdma 0x0 irq 10
ata1: dev 0 ATA-7, max UDMA/100, 156368016 sectors: LBA48
ata1: dev 0 configured for UDMA/66
scsi0 : pdc_adma
ata2: disabling port
scsi1 : pdc_adma
   Vendor: ATA       Model: SAMSUNG SP0802N   Rev: TK30
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda:<3>ata1: command 0xc8 timeout, stat 0x58 host_stat 0x0
ata1: translated ATA stat/err 0x58/00 to SCSI SK/ASC/ASCQ 0xb/47/00
<---- locked up ---->
===============================================================

2.6.16 successfully identifies the disk but locks up the whole machine 
while trying to read partition table.  (complete lockup, IRQ dead)

ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 10 (level, 
low) -> IRQ 10
[ata_device_add      ] ENTER
[ata_host_add        ] ENTER
[ata_port_start      ] prd alloc, virt cd563000, dma d563000
ata1: PATA max UDMA/66 cmd 0xCE8AC000 ctl 0xCE8AC038 bmdma 0x0 irq 10
[ata_host_add        ] ENTER
[ata_port_start      ] prd alloc, virt cc593000, dma c593000
ata2: PATA max UDMA/66 cmd 0xCE8AC040 ctl 0xCE8AC078 bmdma 0x0 irq 10
[ata_device_add      ] probe begin
[ata_device_add      ] ata1: probe begin
[ata_bus_reset       ] ENTER, host 1, port 0
[ata_bus_softreset   ] ata1: bus reset via SRST
[ata_dev_classify    ] found ATA device by sig
[ata_dev_classify    ] found ATA device by sig
[ata_bus_reset       ] EXIT
[ata_dev_identify    ] ENTER, host 1, dev 0
[ata_dev_identify    ] do ATA identify
[ata_exec_command_mmio] ata1: cmd 0xEC
[ata_pio_sector      ] data read
[ata_dump_id         ] 49==0x2f00  53==0x0007  63==0x0407  64==0x0003 
75==0x0000
[ata_dump_id         ] 80==0x00fe  81==0x001e  82==0x346b  83==0x7f01 
84==0x4003
[ata_dump_id         ] 88==0x003f  93==0x600b
ata1: dev 0 ATA-7, max UDMA/100, 156368016 sectors: LBA48
[ata_dev_identify    ] EXIT, drv_stat = 0x50
[ata_dev_identify    ] ENTER/EXIT (host 1, dev 1) -- nodev
[ata_host_set_pio    ] base 0x8 xfer_mode 0xc mask 0x10 x 4
[ata_dev_set_xfermode] set features - xfer mode
[ata_exec_command_mmio] ata1: cmd 0xEF
[adma_intr_mmio      ] ata1: protocol 1 (dev_stat 0x50)
[ata_dev_set_xfermode] EXIT
[ata_dev_set_mode    ] idx=4 xfer_shift=0, xfer_mode=0x44, base=0x40, 
offset=4
ata1: dev 0 configured for UDMA/66
[ata_device_add      ] ata1: probe end
scsi0 : pdc_adma
[ata_device_add      ] ata2: probe begin
[ata_bus_reset       ] ENTER, host 2, port 1
[ata_bus_softreset   ] ata2: bus reset via SRST
ata2: disabling port
[ata_bus_reset       ] EXIT
[ata_device_add      ] ata2: probe end
scsi1 : pdc_adma
[ata_device_add      ] probe begin
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 12 00 00 00 24 00 5a 5a 5a
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 12 00 00 00 60 00 5a 5a 5a
   Vendor: ATA       Model: SAMSUNG SP0802N   Rev: TK30
   Type:   Direct-Access                      ANSI SCSI revision: 05
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 00 00 00 00 00 00 5a 5a 5a
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
sda: Write Protect is off
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sda: drive cache: write back
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 00 00 00 00 00 00 5a 5a 5a
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
sda: Write Protect is off
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sda: drive cache: write back
  sda:<3>[ata_scsi_dump_cdb   ] CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
[ata_sg_setup        ] 1 sg elements mapped
<-----locked up------>

-- 
tejun
