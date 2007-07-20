From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: PATA driver for Atmel AVR32
Date: Fri, 20 Jul 2007 11:08:19 +0200
Message-ID: <200707201108.19174.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DuHoGFUGhJFcpkO"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:50139 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752801AbXGTJJA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 05:09:00 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kernel@avr32linux.org, kngregertsen@norway.atmel.com, gregerts@stud.ntnu.no

--Boundary-00=_DuHoGFUGhJFcpkO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,

I'm developing an PATA driver for the Atmel AVR32 architecture (driver code 
will be sent as reply to this thread). I develop on version 2.6.22.atmel.3.

The driver is currently partially working, but there are some issues with data 
transfers (PIO 0). Data transfers hang after some seconds until EH times out 
and resets the disk. While hanging DASP- is asserted. INTRQ is not asserted 
during hangs.

I've look at the bus with a logic analyzer during data transfer, things seems 
to be working fine until it hangs. During hangs the bus is dead silent. I've 
tried with two different harddisks and I get the same failure on both.

This is how a faulty disk transfer looks like with verbose output:

-sh-3.2# modprobe ... (see attached file modprobe_dmesg.txt)
-sh-3.2# dmesg -n 8
-sh-3.2# dd if=/dev/zero of=/dev/sda1 count=10k
...
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data write
...
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data write
ata_host_intr: ata1: protocol 2 task_state 3
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 07 46 00 00 01
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_tf_load: feat 0x0 nsect 0x1 lba 0x46 0x7 0x0
ata_tf_load: device 0xE0
ata_exec_command: ata1: cmd 0x30
ata_scsi_translate: EXIT
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data write
ata_host_intr: ata1: protocol 2 task_state 3
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 07 47 00 00 02
...
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_tf_load: feat 0x0 nsect 0x2 lba 0x4F 0x7 0x0
ata_tf_load: device 0xE0
ata_exec_command: ata1: cmd 0x30
ata_scsi_translate: EXIT
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data write
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data write
ata_host_intr: ata1: protocol 2 task_state 3
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_scsi_dump_cdb: CDB (1:0,0,0) 2a 00 00 00 07 51 00 00 02
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_tf_load: feat 0x0 nsect 0x2 lba 0x51 0x7 0x0
ata_tf_load: device 0xE0
ata_exec_command: ata1: cmd 0x30
ata_scsi_translate: EXIT
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data write

<Here it hangs for some seconds, DASP- asserted>

ata_scsi_timed_out: ENTER
ata_scsi_timed_out: EXIT, ret=0
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
__ata_port_freeze: ata1 port frozen
ata_eh_autopsy: ENTER
ata_eh_autopsy: EXIT
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 30/00:02:51:07:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 1024 out
         res 40/00:7f:bb:05:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=0
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEC
...

I get the same kind of behaviour when running without deugging output. The 
messages from EH appear after some time when the transfer hangs. Transfer 
always hangs after 'ata_pio_sector: data write'.

There might be problems with the signals from the AVR32s External Bus 
Interface to the ATA device, although it seems fine when looking with the 
logic analyzer. Can a random signal fault generate this kind of failure? Or 
is it my driver code that is to blame?

Any advice where to look for faults would be appriciated :)
-- 
Kristoffer Nyborg Gregertsen
MSc. student / Summer intern
Atmel Norway

--Boundary-00=_DuHoGFUGhJFcpkO
Content-Type: text/plain;
  charset="us-ascii";
  name="modprobe_dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modprobe_dmesg.txt"

-sh-3.2# modprobe pata_at32
libata version 2.21 loaded.
at32_ide at32_ide.0: RESET: 57 DMARQ: -1 DMACK: -1
at32_ide at32_ide.0: Memory setup on CS4
at32_ide at32_ide.0: RESOURCE: ide: 4c00000 to 4c007ff flags 200
at32_ide at32_ide.0: RESOURCE: alt: 4e00000 to 4e007ff flags 200
smc cs4: setup/000e000e pulse/311c311c cycle/00310031 mode/00001001
ata_host_alloc: ENTER
ata_port_alloc: ENTER
ata_port_start: prd alloc, virt b06a1000, dma 106a1000
__ata_port_freeze: ata4294967295 port frozen
scsi0 : pata_at32
ata1: PATA max PIO0 cmd 0xa4c00000 ctl 0xa4e0000c bmdma 0x00000000 irq 65
ata_host_register: probe begin
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=1
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=0
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1.00: ata_dev_read_id: ENTER
ata1: ata_dev_select: ENTER, device 0, wait 1
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x7 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 task_state 3
ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: ENTER
ata1.00: ata_dev_configure: cfg 49:2f00 82:746b 83:7fe8 84:4023 85:7468 86:3e00 87:4023 88:003f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000
ata_dump_id: 80==0x007c  81==0x0019  82==0x746b  83==0x7fe8  84==0x4023
ata_dump_id: 88==0x003f  93==0x600b
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xE0
ata_exec_command: ata1: cmd 0x27
ata_host_intr: ata1: protocol 1 task_state 3
ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: ATA-6: IC35L060AVV207-0, V22OA66A, max UDMA/100
ata1.00: 78125000 sectors, multi 0: LBA48
ata1.00: ata_dev_configure: EXIT, drv_stat = 0x50
ata_dev_set_xfermode: set features - xfer mode
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x3 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEF
ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata_dev_set_xfermode: EXIT, err_mask=0
ata1.00: ata_dev_read_id: ENTER
ata1: ata_dev_select: ENTER, device 0, wait 1
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x7 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 task_state 3
ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xA0
ata_exec_command: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: ENTER
ata1.00: ata_dev_configure: cfg 49:2f00 82:746b 83:7fe8 84:4023 85:7468 86:3e00 87:4023 88:003f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000
ata_dump_id: 80==0x007c  81==0x0019  82==0x746b  83==0x7fe8  84==0x4023
ata_dump_id: 88==0x003f  93==0x600b
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load: device 0xE0
ata_exec_command: ata1: cmd 0x27
ata_host_intr: ata1: protocol 1 task_state 3
ata_hsm_move: ata1: protocol 1 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1: ata_port_flush_task: flush #2
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: EXIT, drv_stat = 0x50
ata_dev_set_mode: xfer_shift=0, xfer_mode=0x8
ata1.00: configured for PIO0
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_host_register: host probe begin
isa bounce pool size: 16 pages
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 9c 7e dd
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 9c 7e dd
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      IC35L060AVV207-0 V22O PQ: 0 ANSI: 5
-sh-3.2# modprobe sd_mod
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 bf 88 90
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
sd 0:0:0:0: [sda] 78125000 512-byte hardware sectors (40000 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
sd 0:0:0:0: [sda] 78125000 512-byte hardware sectors (40000 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata1: ata_dev_select: ENTER, device 0, wait 1
ata_tf_load: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load: device 0xE0
ata_exec_command: ata1: cmd 0x20
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 2
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
 sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
--Boundary-00=_DuHoGFUGhJFcpkO--
