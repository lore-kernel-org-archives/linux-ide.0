From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Nadeau?= <fred.nadeau@gmail.com>
Subject: Intel SSD: NODEV after polling detection
Date: Mon, 15 Apr 2013 13:52:05 -0400
Message-ID: <CANCW2kWMwCpmvFtDNjTxyq2DtiQc_6rU27K=AK0T6Af-vRPKVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:42219 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934470Ab3DORwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Apr 2013 13:52:06 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so4582182iad.10
        for <linux-ide@vger.kernel.org>; Mon, 15 Apr 2013 10:52:05 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a MPC8349E-mITX board (we actually have an in house board based
on this desing, but for debuging, the dev board is way more
convenient) and all works well except when we plug in a specific SSD.

So far, we have this:
 - HDD WD Scorpion Blue (various size 250G, 500G, 1T): OK
 - HDD WD Scorpion 250G: OK
 - SSD Kingston SSDNOW 200 V+ 240G & 480G: OK
 - SSD Kingston SSDNOW KC100 240G: OK
 - SSD Intel DC S3700 Series 200GB: Fail

All kernels were build using mpc834x_itx_defconfig, except 2.6.13.4
and 2.6.16 which used config provided by ltib/freescale(if anyone
cares to know).

2.6.13.4: Failed with PIO error
2.6.16: Failed with PIO error
2.6.34.14: Failed with NODEV after polling detection
2.6.35.5: Failed with NODEV after polling detection
3.0.72 Failed with NODEV after polling detection
3.4.39: Failed with NODEV after polling detection
3.8.6: Failed with NODEV after polling detection

If I enabled ATA_DEBUG and ATA_DEBUG_VERBOSE in include/linux/libata.h
in kernels that failed with NODEV, the drive works properly at the
cost of poluting dmesg. This would lead me to beleive that it is a
timing issue occuring during drive detection.

So far, all I have is this:
http://marc.info/?l=linux-ide&m=128232270016754

It seems I have the same behavior. If I put a printk in
libata-sff.c@1385 right before:
poll_next = ata_sff_hsm_move(ap, qc, status, 1);
Status is 0x50 and not 0x58. Putting a udelay at top doesn't change anything.

Despite the fact that the bug in bugzilla 16606 is close, I tried and
still have the issue in 2.6.35.5.

Would anyone have an idea on how to debug this?

Thanks,
Fred

Kernel 3.8.6 untouched:
[root@mpc8349e-mitx /root]# uname -a
Linux mpc8349e-mitx 3.8.6 #1 Fri Apr 12 09:13:19 EDT 2013 ppc GNU/Linux
[root@mpc8349e-mitx /root]# dmesg | grep -i ata
libata version 3.00 loaded.
sata_sil 0000:00:10.0: version 2.4
sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000080 irq 22
ata2: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900000c0 irq 22
ata3: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000280 irq 22
ata4: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900002c0 irq 22
scsi4 : pata_platform
ata5: PATA max PIO6 mmio cmd 0xf0000000 ctl 0xf000020c irq 24
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: NODEV after polling detection
ata2: SATA link down (SStatus 0 SControl 310)
ata3: SATA link down (SStatus 0 SControl 310)
ata4: SATA link down (SStatus 0 SControl 310)
ata5.00: qc timeout (cmd 0x91)
ata5.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)
ata5.00: qc timeout (cmd 0x91)
ata5.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)
ata5.00: qc timeout (cmd 0x91)
ata5.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)

Kernel 3.8.6 with libata debug enable:
ata_host_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000080 irq 22
ata2: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900000c0 irq 22
ata3: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000280 irq 22
ata4: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900002c0 irq 22
ata_std_sched_eh: port EH scheduled
ata_scsi_error: ENTER
ata_sff_flush_pio_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
sata_link_hardreset: ENTER
ata_host_alloc: ENTER
ata_port_alloc: ENTER
__ata_port_freeze: ata4294967295 port frozen
scsi4 : pata_platform
ata5: PATA max PIO6 mmio cmd 0xf0000000 ctl 0xf000020c irq 24
ata_std_sched_eh: port EH scheduled
ata_scsi_error: ENTER
ata_sff_flush_pio_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata5 port frozen
ata_sff_softreset: ENTER
ata_sff_softreset: about to softreset, devmask=1
ata_bus_softreset: ata5: bus reset via SRST
sata_link_hardreset: EXIT, rc=0
ata_dev_classify: found ATA device by sig
sata_sff_hardreset: EXIT, class=1
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata1: cmd 0xEC
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_dev_classify: found ATA device by sig
ata_sff_softreset: EXIT, classes[0]=1 [1]=9
ata_eh_thaw_port: ata5 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata5: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata5: cmd 0xEC
ata_sff_hsm_move: ata5: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata5: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata5: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0x27
ata_sff_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata_dev_init_params: init dev params
ata5: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x3F lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xAF
ata_sff_exec_command: ata5: cmd 0x91
ata_sff_flush_pio_task: ENTER
ata1.00: HPA detected: current 16384, native 390721968
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f
ata_dump_id: 80==0x01fc  81==0x0029  82==0x746b  83==0x7501  84==0x6163
ata_dump_id: 88==0x407f  93==0x0000
ata1.00: ATA-8: INTEL SSDSC2BA200G3, 5DV10250, max UDMA/133
ata1.00: 16384 sectors, multi 1: LBA48 NCQ (depth 0/32)
ata_dev_set_xfermode: set features - xfer mode
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x3 nsect 0x45 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata1: cmd 0xEF
ata_sff_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata_dev_set_xfermode: EXIT, err_mask=0
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata1: cmd 0xEC
ata_sff_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0x27
ata_sff_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f
ata_dump_id: 80==0x01fc  81==0x0029  82==0x746b  83==0x7501  84==0x6163
ata_dump_id: 88==0x407f  93==0x0000
ata_dev_set_mode: xfer_shift=12, xfer_mode=0x45
ata1.00: configured for UDMA/100
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 00
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BA20 5DV1 PQ: 0 ANSI: 5
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 9e 10 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 08 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b2 00 08 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b0 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b1 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
ata_std_sched_eh: port EH scheduled
ata_scsi_error: ENTER
ata_sff_flush_pio_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata2 port frozen
sata_link_hardreset: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 9e 10 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 08 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b2 00 08 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b0 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b1 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 9e 10 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 08 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b2 00 08 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b0 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 00 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 b1 00 40 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
sata_link_hardreset: EXIT, rc=0
sata_sff_hardreset: EXIT, class=0
ata_eh_thaw_port: ata2 port thawed
ata_std_postreset: ENTER
ata2: SATA link down (SStatus 0 SControl 310)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_std_sched_eh: port EH scheduled
ata_scsi_error: ENTER
ata_sff_flush_pio_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata3 port frozen
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
sata_sff_hardreset: EXIT, class=0
ata_eh_thaw_port: ata3 port thawed
ata_std_postreset: ENTER
ata3: SATA link down (SStatus 0 SControl 310)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_std_sched_eh: port EH scheduled
ata_scsi_error: ENTER
ata_sff_flush_pio_task: ENTER
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata4 port frozen
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
sata_sff_hardreset: EXIT, class=0
ata_eh_thaw_port: ata4 port thawed
ata_std_postreset: ENTER
ata4: SATA link down (SStatus 0 SControl 310)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_sff_flush_pio_task: ENTER
__ata_port_freeze: ata5 port frozen
ata5.00: qc timeout (cmd 0x91)
ata_dev_init_params: EXIT, err_mask=4
ata5.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)
ata_eh_revalidate_and_attach: EXIT rc=-5
__ata_port_freeze: ata5 port frozen
ata_sff_softreset: ENTER
ata_sff_softreset: about to softreset, devmask=1
ata_bus_softreset: ata5: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_sff_softreset: EXIT, classes[0]=1 [1]=9
ata_eh_thaw_port: ata5 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata5: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata5: cmd 0xEC
ata_sff_hsm_move: ata5: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata5: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata5: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata_dev_init_params: init dev params
ata5: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x3F lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xAF
ata_sff_exec_command: ata5: cmd 0x91
ata_sff_flush_pio_task: ENTER
__ata_port_freeze: ata5 port frozen
ata5.00: qc timeout (cmd 0x91)
ata_dev_init_params: EXIT, err_mask=4
ata5.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)
ata_eh_revalidate_and_attach: EXIT rc=-5
__ata_port_freeze: ata5 port frozen
ata_sff_softreset: ENTER
ata_sff_softreset: about to softreset, devmask=1
ata_bus_softreset: ata5: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_sff_softreset: EXIT, classes[0]=1 [1]=9
ata_eh_thaw_port: ata5 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata5: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xA0
ata_sff_exec_command: ata5: cmd 0xEC
ata_sff_hsm_move: ata5: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_sff_hsm_move: ata5: protocol 2 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata5: dev 0 command complete, drv_stat 0x50
ata_sff_flush_pio_task: ENTER
ata_dev_init_params: init dev params
ata5: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x3F lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xAF
ata_sff_exec_command: ata5: cmd 0x91
ata_sff_flush_pio_task: ENTER
__ata_port_freeze: ata5 port frozen
ata5.00: qc timeout (cmd 0x91)
ata_dev_init_params: EXIT, err_mask=4
ata5.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x4)
ata_eh_revalidate_and_attach: EXIT rc=-5
__ata_port_freeze: ata5 port frozen
ata_sff_softreset: ENTER
ata_sff_softreset: about to softreset, devmask=1
ata_bus_softreset: ata5: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_sff_softreset: EXIT, classes[0]=1 [1]=9
ata_eh_thaw_port: ata5 port thawed
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 3f 80 00 00 08
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x8 lba 0x80 0x3F 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 3f f0 00 00 08
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x8 lba 0xF0 0x3F 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 20
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x20 lba 0x0 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 20 00 00 40
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 8 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x40 lba 0x20 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 8 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 3f f8 00 00 08
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x8 lba 0xF8 0x3F 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 3f c0 00 00 20
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x20 lba 0xC0 0x3F 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 4 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 3f 00 00 00 20
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x20 lba 0x0 0x3F 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 4 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 3e 70 00 00 20
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 4 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x20 lba 0x70 0x3E 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 4 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 60 00 01 00
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 23 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x60 0x0 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 23 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 01 60 00 01 00
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 15 sg elements mapped
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_sff_tf_load: feat 0x0 nsect 0x0 lba 0x60 0x1 0x0
ata_sff_tf_load: device 0xE0
ata_sff_exec_command: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_sff_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_sff_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 15 sg elements
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
