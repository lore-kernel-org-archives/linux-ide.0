From: Andres Meyer <andres.meyer@computer.org>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Thu, 11 Mar 2004 22:58:32 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403112258.33170.andres.meyer@computer.org>
References: <200403100006.36405.andres.meyer@computer.org> <200403100831.34416.andres.meyer@computer.org> <404EC5C3.2060603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:28093 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261766AbUCKV7t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2004 16:59:49 -0500
In-Reply-To: <404EC5C3.2060603@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > As stated previously, It's a 32bit kernel, I did not event try 64bit SATA
> > yet.
>
> Whoops, I missed that.  Thanks, I'll look into it.  If you are willing,
> defining ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h, and
> emailing dmesg output, would provide helpful details to me.
>
> 	Jeff

I did enable that, but there was not more output in case of crashes. I did try 
to connect the 250GB SATA disks to the Promise, which seems to work ok.
The 160GB IDE Maxtor & Marvel IDE2SATA on the promise seem to trigger the mce.

I still do not have a clue why...

Andres



ata_ section from bootup:

ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt f6ae8000, dma 36ae8000
ata1: SATA max UDMA/133 cmd 0xF885C200 ctl 0xF885C238 bmdma 0x0 irq 29
ata_thread_iter: ata1: thr_state THR_PROBE_START
ata_host_add: ENTER
ata_port_start: prd alloc, virt f6adf000, dma 36adf000
ata2: SATA max UDMA/133 cmd 0xF885C280 ctl 0xF885C2B8 bmdma 0x0 irq 29
ata_thread_iter: ata2: thr_state THR_PROBE_START
ata_host_add: ENTER
ata_port_start: prd alloc, virt f6ad5000, dma 36ad5000
ata3: SATA max UDMA/133 cmd 0xF885C300 ctl 0xF885C338 bmdma 0x0 irq 29
ata_thread_iter: ata3: thr_state THR_PROBE_START
ata_host_add: ENTER
ata_port_start: prd alloc, virt f6acc000, dma 36acc000
ata4: SATA max UDMA/133 cmd 0xF885C380 ctl 0xF885C3B8 bmdma 0x0 irq 29
ata_thread_iter: ata4: thr_state THR_PROBE_START
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_device_add: ata1: probe-wait begin
ata_thread_iter: ata1: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata1: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata1: cmd 0xEC
ata_exec_command_mmio: ata1: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x007e  81==0x0018  82==0x7c69  83==0x4f09  84==0x4003
ata_dump_id: 88==0x207f  93==0x600b
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata1: cmd 0xEF
ata_exec_command_mmio: ata1: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata1: dev 0 configured for UDMA/133
ata_thread_iter: ata1: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata1: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 0
ata_device_add: ata1: probe-wait end
scsi0 : sata_promise
ata_device_add: ata2: probe begin
ata_device_add: ata2: probe-wait begin
ata_thread_iter: ata2: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata2: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 2, port 1
ata_bus_softreset: ata2: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 2, dev 0
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata2: cmd 0xEC
ata_exec_command_mmio: ata2: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x007e  81==0x0018  82==0x7c69  83==0x4f09  84==0x4003
ata_dump_id: 88==0x207f  93==0x600b
ata2: dev 0 ATA, max UDMA/133, 320173056 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata2: cmd 0xEF
ata_exec_command_mmio: ata2: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata2: dev 0 configured for UDMA/133
ata_thread_iter: ata2: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata2: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 0
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_device_add: ata2: probe-wait end
scsi1 : sata_promise
ata_device_add: ata3: probe begin
ata_device_add: ata3: probe-wait begin
ata_thread_iter: ata3: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata3: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 3, port 2
ata_bus_softreset: ata3: bus reset via SRST
ata_dev, ata3, use_sg 1
<3>ata_sg_setup: 1 sg elements mapped
pdc_fill_sg: ENTER
ata_fill_sg: PRD[0] = (0x36B82000, 0x1000)
pdc_dma_start: ENTER, ap f6ad99c4
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
pdc_interrupt: port 2
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 3
pdc_interrupt: EXIT
 p5 >
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (4:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdd: 320173056 512-byte hdwr sectors (163929 MB)
ata_scsi_queuecmd: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdd: drive cache: write through
 /dev/scsi/host3/bus0/target0/lun0:<3>ata_scsi_queuecmd: CDB (4:0,0,0) 28 00 
00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_sg_setup: ENTER, ata4, use_sg 1
ata_sg_setup: 1 sg elements mapped
pdc_fill_sg: ENTER
ata_fill_sg: PRD[0] = (0x36B81000, 0x1000)
pdc_dma_start: ENTER, ap f6ad09c4
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
pdc_interrupt: port 2
pdc_interrupt: port 3
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: EXIT
 p1 <<3>ata_scsi_queuecmd: CDB (4:0,0,0) 28 00 00 00 3e c0 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_sg_setup: ENTER, ata4, use_sg 1
ata_sg_setup: 1 sg elements mapped
pdc_fill_sg: ENTER
ata_fill_sg: PRD[0] = (0x36B80000, 0x1000)
pdc_dma_start: ENTER, ap f6ad09c4
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
pdc_interrupt: port 2
pdc_interrupt: port 3
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: EXIT
 p5 >
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (5:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (5:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sde: 490234752 512-byte hdwr sectors (251000 MB)
ata_scsi_queuecmd: CDB (5:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (5:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sde: drive cache: write through
 /dev/scsi/host4/bus0/target0/lun0:<3>ata_scsi_queuecmd: CDB (5:0,0,0) 28 00 
00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata5: device 0, wait 1
ata_sg_setup: ENTER, ata5, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x36B7F000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
ata_exec_command_mmio: ata5: cmd 0x25
ata_scsi_rw_queue: EXIT
ata_host_intr: BUS_DMA (host_stat 0x4)
ata_dma_complete: ENTER
ata_dma_complete: host 5, host_stat==0x4, drv_stat==0x50
ata_sg_clean: unmapping 1 sg elements
 p1 <<3>ata_scsi_queuecmd: CDB (5:0,0,0) 28 00 00 00 00 38 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata5: device 0, wait 1
ata_sg_setup: ENTER, ata5, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x36B7E000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x38 0x0 0x0
ata_tf_load_mmio: device 0xE0
ata_exec_command_mmio: ata5: cmd 0x25
ata_scsi_rw_queue: EXIT
ata_host_intr: BUS_DMA (host_stat 0x4)
ata_dma_complete: ENTER
ata_dma_complete: host 5, host_stat==0x4, drv_stat==0x50
ata_sg_clean: unmapping 1 sg elements
 p5 >
Attached scsi disk sde at scsi4, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (6:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (6:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
ata_scsi_queuecmd: CDB (6:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (6:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdf: drive cache: write through
 /dev/scsi/host5/bus0/target0/lun0:<3>ata_scsi_queuecmd: CDB (6:0,0,0) 28 00 
00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata6: device 0, wait 1
ata_sg_setup: ENTER, ata6, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x3674D000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
ata_exec_command_mmio: ata6: cmd 0x25
ata_scsi_rw_queue: EXIT
ata_host_intr: BUS_DMA (host_stat 0x4)
ata_dma_complete: ENTER
ata_dma_complete: host 6, host_stat==0x4, drv_stat==0x50
ata_sg_clean: unmapping 1 sg elements
 p1 <<3>ata_scsi_queuecmd: CDB (6:0,0,0) 28 00 00 00 00 38 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata6: device 0, wait 1
ata_sg_setup: ENTER, ata6, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x3674C000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x38 0x0 0x0
ata_tf_load_mmio: device 0xE0
ata_exec_command_mmio: ata6: cmd 0x25
ata_scsi_rw_queue: EXIT
ata_host_intr: BUS_DMA (host_stat 0x4)
ata_dma_complete: ENTER
ata_dma_complete: host 6, host_stat==0x4, drv_stat==0x50
ata_sg_clean: unmapping 1 sg elements
 p5 >
Attached scsi disk sdf at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg4 at scsi4, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg5 at scsi5, channel 0, id 0, lun 0,  type 0
