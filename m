From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: long boot delay for atapi dvdrom on 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 11:54:38 +0200
Message-ID: <44F954DE.1010504@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:34822 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1750951AbWIBJyl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Sep 2006 05:54:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

On Linux-2.6.18-rc5-mm1 (and in fact all previous -mm which
supported PATA in ata_piix) I experience long boot delays when
ata_piix detects the dvd drive.
System is a i810 laptop with ICH2M, harddisk at channel 0 and dvd
at channel 1.
Attached is the debug output of ata_piix. I added a line where
the ~30 second delay occurs.

Thanks,
 Manuel Lauss


piix_init: pci_register_driver
ata_pci_init_one: ENTER
ata_device_add: ENTER
ata_port_add: ENTER
ata_port_start: prd alloc, virt c79aa000, dma 79aa000
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1800 irq 14
__ata_port_freeze: ata1 port frozen
ata_port_add: ENTER
ata_port_start: prd alloc, virt c79b4000, dma 79b4000
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1808 irq 15
__ata_port_freeze: ata2 port frozen
ata_device_add: probe begin
scsi0 : ata_piix
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_pio: ata1: cmd 0xEC
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dump_id: 49==0x0b00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x003c  81==0x0013  82==0x746b  83==0x5988  84==0x4003
ata_dump_id: 88==0x203f  93==0x600b
ata1.00: ATA-5, max UDMA/100, 117210240 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_dev_set_xfermode: set features - xfer mode
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x3 nsect 0x45 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 task_state 3
ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dev_set_xfermode: EXIT, err_mask=0
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_pio: ata1: cmd 0xEC
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dump_id: 49==0x0b00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x003c  81==0x0013  82==0x746b  83==0x5988  84==0x4003
ata_dump_id: 88==0x203f  93==0x600b
ata_dev_set_mode: xfer_shift=12, xfer_mode=0x45
ata1.00: configured for UDMA/100
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
scsi1 : ata_piix
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata2 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata2: bus reset via SRST

<30 seconds delay>

ata_dev_classify: found ATAPI device by sig
ata_std_softreset: EXIT, classes[0]=3 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata2 port thawed
ata_eh_revalidate_and_attach: ENTER
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_exec_command_pio: ata2: cmd 0xA1
ata_host_intr: ata2: protocol 2 task_state 2
ata_hsm_move: ata2: protocol 2 task_state 2 (dev_stat 0x8)
ata_pio_sector: data read
ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dump_id: 49==0x0f00  53==0x0006  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x0020  81==0x0000  82==0x0000  83==0x0000  84==0x0000
ata_dump_id: 88==0x0407  93==0x0000
ata2.00: ATAPI, max UDMA/33
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_dev_set_xfermode: set features - xfer mode
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x3 nsect 0x42 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xEF
ata_host_intr: ata2: protocol 1 task_state 3
ata_hsm_move: ata2: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dev_set_xfermode: EXIT, err_mask=0
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_exec_command_pio: ata2: cmd 0xA1
ata_host_intr: ata2: protocol 2 task_state 2
ata_hsm_move: ata2: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dump_id: 49==0x0f00  53==0x0006  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x0020  81==0x0000  82==0x0000  83==0x0000  84==0x0000
ata_dump_id: 88==0x0407  93==0x0000
ata_dev_set_mode: xfer_shift=12, xfer_mode=0x42
ata2.00: configured for UDMA/33
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_device_add: host probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 00
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      HITACHI_DK23EA-6 00K2 PQ: 0 ANSI: 5
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sda: Write Protect is off
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: drive cache: write back
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sda: Write Protect is off
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: drive cache: write back
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x7C8A000, 0x1000)
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xE0
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 3 task_state 3
ata_host_intr: ata1: host_stat 0x24
ata_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
 sda1 sda2 sda3 <<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 81 ac d0 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x113E000, 0x1000)
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0xD0 0xAC 0x81
ata_tf_load_pio: device 0xE0
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 3 task_state 3
ata_host_intr: ata1: host_stat 0x24
ata_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
 sda5<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 81 d6 a0 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x7CB1000, 0x1000)
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0xA0 0xD6 0x81
ata_tf_load_pio: device 0xE1
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 3 task_state 3
ata_host_intr: ata1: host_stat 0x24
ata_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
 sda6<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 01 92 04 68 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x7E02000, 0x1000)
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0x68 0x4 0x92
ata_tf_load_pio: device 0xE1
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 3 task_state 3
ata_host_intr: ata1: host_stat 0x24
ata_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
 sda7<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 03 47 94 20 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x7976000, 0x1000)
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0x20 0x94 0x47
ata_tf_load_pio: device 0xE3
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 3 task_state 3
ata_host_intr: ata1: host_stat 0x24
ata_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
 sda8 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata2
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x7E59DE0, 0x24)
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
ata_scsi_translate: EXIT
ata_hsm_move: ata2: protocol 7 task_state 5 (dev_stat 0x58)
atapi_send_cdb: send cdb
ata_host_intr: ata2: protocol 7 task_state 3
ata_host_intr: ata2: host_stat 0x24
ata_hsm_move: ata2: protocol 7 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
atapi_qc_complete: ENTER, err_mask 0x0
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 00 00 00
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata2
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x7E59DE0, 0x60)
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
ata_scsi_translate: EXIT
ata_hsm_move: ata2: protocol 7 task_state 5 (dev_stat 0x58)
atapi_send_cdb: send cdb
ata_host_intr: ata2: protocol 7 task_state 3
ata_host_intr: ata2: host_stat 0x24
ata_hsm_move: ata2: protocol 7 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
atapi_qc_complete: ENTER, err_mask 0x0
scsi 1:0:0:0: CD-ROM            QSI      DVD-ROM SDR-081  EHA9 PQ: 0 ANSI: 5
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsi_translate: ENTER
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
ata_scsi_translate: EXIT
ata_hsm_move: ata2: protocol 6 task_state 5 (dev_stat 0x58)
atapi_send_cdb: send cdb
ata_host_intr: ata2: protocol 6 task_state 3
ata_hsm_move: ata2: protocol 6 task_state 3 (dev_stat 0x51)
ata_hsm_move: ata2: protocol 6 task_state 4 (dev_stat 0x51)
ata_scsi_timed_out: ENTER
ata_scsi_timed_out: EXIT, ret=0
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_eh_autopsy: ENTER
atapi_eh_request_sense: ATAPI request sense
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x64 nsect 0x3 lba 0x0 0x0 0x20
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
ata_hsm_move: ata2: protocol 5 task_state 5 (dev_stat 0x58)
atapi_send_cdb: send cdb
ata_host_intr: ata2: protocol 5 task_state 2
ata_hsm_move: ata2: protocol 5 task_state 2 (dev_stat 0x58)
atapi_pio_bytes: ata2: xfering 18 bytes
__atapi_pio_bytes: data read
ata_host_intr: ata2: protocol 5 task_state 2
ata_hsm_move: ata2: protocol 5 task_state 2 (dev_stat 0x50)
ata_hsm_move: ata2: protocol 5 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_eh_autopsy: EXIT
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
atapi_qc_complete: ENTER, err_mask 0x0
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsi_translate: ENTER
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
ata_scsi_translate: EXIT
ata_hsm_move: ata2: protocol 6 task_state 5 (dev_stat 0x58)
atapi_send_cdb: send cdb
ata_host_intr: ata2: protocol 6 task_state 3
ata_hsm_move: ata2: protocol 6 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
atapi_qc_complete: ENTER, err_mask 0x0
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 2a 00 00 00 00 00 80
ata_scsi_translate: ENTER
ata_sg_setup: ENTER, ata2
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x4C7E00, 0x80)
ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata2: cmd 0xA0
ata_scsi_translate: EXIT
ata_hsm_move: ata2: protocol 7 task_state 5 (dev_stat 0x58)
atapi_send_cdb: send cdb
ata_host_intr: ata2: protocol 7 task_state 3
ata_host_intr: ata2: host_stat 0x25
ata_hsm_move: ata2: protocol 7 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata2: dev 0 command complete, drv_stat 0x50
ata_sg_clean: unmapping 1 sg elements
atapi_qc_complete: ENTER, err_mask 0x0
sr0: scsi3-mmc drive: 36x/61x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg1 type 5
ata_device_add: EXIT, returning 2
piix_init: done

-- 
VGER BF report: U 0.466555
