From: Harsha Padmanabha <harsha@purplevisiontech.com>
Subject: Sil 3512 and Seagate ST3802110AS
Date: Fri, 11 Aug 2006 14:00:49 +0530
Message-ID: <455FCE13-2A0E-4BBE-8D1B-45C02C3C1C69@purplevisiontech.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms16.webminders.com ([64.37.88.34]:45576 "EHLO
	ms16.webminders.com") by vger.kernel.org with ESMTP
	id S1750805AbWHKIa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Aug 2006 04:30:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

I am trying to get sata_sil running on a MPC8349(PPC) board, I runto  
the following errors. I cannot upgrade my kernel to the latest one  
since most of my changes for MPC8349 to work  are for 2.6.11.

1) How can i patch the latest release of libata for 2.6.11 without  
having to change to 2.6.17
2) I have tried SIL 3112 card with the same results
3) I have also tried different hard drives like samsung and WDC


Please let me know what i can do to get this running.


~harsha

-----------------Kernel 2.6.11 dmesg  
dump--------------------------------------------------
PCI: Probing PCI hardware

PCI:0000:00:10.0: Resource 0: 00fffff8-00ffffff (f=101)

PCI:0000:00:10.0: Resource 1: 00fffff4-00fffff7 (f=101)

PCI:0000:00:10.0: Resource 2: 00ffffe8-00ffffef (f=101)

PCI:0000:00:10.0: Resource 3: 00ffffe4-00ffffe7 (f=101)

PCI:0000:00:10.0: Resource 4: 00ffffd0-00ffffdf (f=101)

PCI:0000:00:10.0: Resource 5: 9ffffe00-9fffffff (f=200)

SCSI subsystem initialized

Linux Kernel Card Services

   options:  [pci] [cardbus]

Initializing Cryptographic API

Serial: 8250/16550 driver $Revision: 1.90 $ 3 ports, IRQ sharing  
disabled

ttyS0 at MMIO 0x0 (irq = 9) is a 16450

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize

loop: loaded (max 8 devices)

ath_pci: 0.9.4.5 (svn r1692)

ATH_PCI: intializing the ath_pci

ATH_PCI: after pci_register_driver

ath_hal: 0.9.17.2 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413,  
RF5413, REGOPS_FUNC)

wlan: 0.8.4.2 (svn r1692)

wlan: mac acl policy registered

ath_rate_onoe: 1.0 (svn r1692)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with  
idebus=xx

ata_device_add: ENTER

ata_host_add: ENTER

ata_port_start: prd alloc, virt c372b000, dma 372b000

ata1: SATA max UDMA/100 cmd 0xC5000E80 ctl 0xC5000E8A bmdma  
0xC5000E00 irq 22

ata_host_add: ENTER

ata_port_start: prd alloc, virt c372e000, dma 372e000

ata2: SATA max UDMA/100 cmd 0xC5000EC0 ctl 0xC5000ECA bmdma  
0xC5000E08 irq 22

ata_device_add: probe begin

ata_device_add: ata1: probe begin

ata1: no device found (phy stat 00000000)

ata_device_add: ata1: probe end

scsi0 : sata_sil

ata_device_add: ata2: probe begin

ata_bus_reset: ENTER, host 2, port 1

ata_bus_edd: execute-device-diag

ata_exec: ata2: cmd 0x90

ata_exec_command_mmio: ata2: cmd 0x90

ata_dev_classify: found ATA device by sig

ata_bus_reset: EXIT

ata_dev_identify: ENTER, host 2, dev 0

ata_dev_select: ENTER, ata2: device 0, wait 1

ata_dev_identify: do ATA identify

ata_dev_select: ENTER, ata2: device 0, wait 1

ata_exec_command_mmio: ata2: cmd 0xEC

ata_pio_sector: data read

ata_qc_complete: EXIT

ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f

ata_dump_id: 80==0x00fe  81==0x0000  82==0x346b  83==0x7d01  84==0x4023

ata_dump_id: 88==0x207f  93==0x0000

ata2: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48

ata_dev_identify: EXIT, drv_stat = 0x50

ata2(0): applying Seagate errata fix

ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev

ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4

ata_dev_set_xfermode: set features - xfer mode

ata_dev_select: ENTER, ata2: device 0, wait 1

ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0

ata_tf_load_mmio: feat 0x3 nsect 0x45 lba 0x0 0x0 0x0

ata_tf_load_mmio: device 0xA0

ata_exec_command_mmio: ata2: cmd 0xEF

ata_host_intr: ata2: protocol 1 (dev_stat 0x50)

ata_qc_complete: EXIT

ata_dev_set_xfermode: EXIT

ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, base=0x40,  
offset=5

ata2: dev 0 configured for UDMA/100

ata_device_add: ata2: probe end

scsi1 : sata_sil

ata_device_add: probe begin

ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,1,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,2,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,3,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,4,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,5,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,6,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,7,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,8,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,9,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,10,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,11,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,12,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,13,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,14,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:0,15,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,0,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,1,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,2,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,3,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,4,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,5,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,6,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,7,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,8,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,9,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,10,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,11,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,12,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,13,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,14,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (1:1,15,0) 12 00 00 00 24 00 c9 58 00

ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 c9 58 00

ata_scsiop_inq_std: ENTER

ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 c9 58 00

ata_scsiop_inq_std: ENTER

   Vendor: ATA       Model: ST3802110AS       Rev: 3.AA

   Type:   Direct-Access                      ANSI SCSI revision: 05

ata_scsi_dump_cdb: CDB (2:0,0,0) a0 00 00 00 00 00 00 00 10

ata_scsiop_report_luns: ENTER

ata_scsi_dump_cdb: CDB (2:0,1,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,2,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,3,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,4,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,5,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,6,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,7,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,8,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,9,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,10,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,11,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,12,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,13,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,14,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:0,15,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,0,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,1,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,2,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,3,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,4,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,5,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,6,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,7,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,8,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,9,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,10,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,11,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,12,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,13,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,14,0) 12 00 00 00 24 00 10 00 c3

ata_scsi_dump_cdb: CDB (2:1,15,0) 12 00 00 00 24 00 10 00 c3

ata_device_add: EXIT, returning 2

ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00

ata_scsiop_noop: ENTER

ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00

ata_scsiop_read_cap: ENTER

SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)

ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08

ata_scsiop_mode_sense: ENTER

ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 1c

ata_scsiop_mode_sense: ENTER

SCSI device sda: drive cache: write back

ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00

ata_scsiop_noop: ENTER

ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00

ata_scsiop_read_cap: ENTER

SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)

ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08

ata_scsiop_mode_sense: ENTER

ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 1c

ata_scsiop_mode_sense: ENTER

SCSI device sda: drive cache: write back

sda:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08

ata_scsi_translate: ENTER

ata_scsi_rw_xlat: ten-byte command

ata_sg_setup: ENTER, ata2

ata_sg_setup: 1 sg elements mapped

ata_fill_sg: PRD[0] = (0x3748000, 0x1000)

ata_dev_select: ENTER, ata2: device 0, wait 1

ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0

ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0

ata_tf_load_mmio: device 0xE0

ata_exec_command_mmio: ata2: cmd 0x25

ata_scsi_translate: EXIT

ata_scsi_error: ENTER

ata_eng_timeout: ENTER

ata_qc_timeout: ENTER

ata2: command 0x25 timeout, stat 0x58 host_stat 0x2

ata_sg_clean: unmapping 1 sg elements

ata2: status=0x58 { DriveReady SeekComplete DataRequest }

SCSI error : <1 0 0 0> return code = 0x8000002

sda: Current: sense key: Aborted Command

     Additional sense: Scsi parity error

end_request: I/O error, dev sda, sector 0

Buffer I/O error on device sda, logical block 0

ata_qc_complete: EXIT

ata_qc_timeout: EXIT

ata_eng_timeout: EXIT

ata_scsi_error: EXIT

ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08

ata_scsi_translate: ENTER

ata_scsi_rw_xlat: ten-byte command

ata_sg_setup: ENTER, ata2

ata_sg_setup: 1 sg elements mapped

ata_fill_sg: PRD[0] = (0x3748000, 0x1000)

ata_dev_select: ENTER, ata2: device 0, wait 1

ATA: abnormal status 0x58 on port 0xC5000EC7

ATA: abnormal status 0x58 on port 0xC5000EC7

ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0

ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0

ata_tf_load_mmio: device 0xE0

ATA: abnormal status 0x58 on port 0xC5000EC7

ata_exec_command_mmio: ata2: cmd 0x25

ata_scsi_translate: EXIT

ata_scsi_error: ENTER

ata_eng_timeout: ENTER

ata_qc_timeout: ENTER

ata2: command 0x25 timeout, stat 0x58 host_stat 0x2

ata_sg_clean: unmapping 1 sg elements

ata2: status=0x58 { DriveReady SeekComplete DataRequest }

SCSI error : <1 0 0 0> return code = 0x8000002

sda: Current: sense key: Aborted Command

     Additional sense: Scsi parity error

end_request: I/O error, dev sda, sector 0

Buffer I/O error on device sda, logical block 0

ata_qc_complete: EXIT

ata_qc_timeout: EXIT

ata_eng_timeout: EXIT

ata_scsi_error: EXIT

ldm_validate_partition_table(): Disk read failed.

ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08

ata_scsi_translate: ENTER

ata_scsi_rw_xlat: ten-byte command

ata_sg_setup: ENTER, ata2

ata_sg_setup: 1 sg elements mapped

ata_fill_sg: PRD[0] = (0x3748000, 0x1000)

ata_dev_select: ENTER, ata2: device 0, wait 1

ATA: abnormal status 0x58 on port 0xC5000EC7

ATA: abnormal status 0x58 on port 0xC5000EC7

ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0

ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0

ata_tf_load_mmio: device 0xE0

ATA: abnormal status 0x58 on port 0xC5000EC7

ata_exec_command_mmio: ata2: cmd 0x25

ata_scsi_translate: EXIT

ata_scsi_error: ENTER

ata_eng_timeout: ENTER

ata_qc_timeout: ENTER

ata2: command 0x25 timeout, stat 0x58 host_stat 0x2

ata_sg_clean: unmapping 1 sg elements

ata2: status=0x58 { DriveReady SeekComplete DataRequest }

SCSI error : <1 0 0 0> return code = 0x8000002

sda: Current: sense key: Aborted Command

     Additional sense: Scsi parity error

end_request: I/O error, dev sda, sector 0

Buffer I/O error on device sda, logical block 0

unable to read partition table

Attached scsi disk sda at scsi1, channel 0, id 0, lun 0

ata_qc_complete: EXIT

ata_qc_timeout: EXIT

ata_eng_timeout: EXIT

ata_scsi_error: EXIT

Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0

md: linear personality registered as nr 1

md: raid0 personality registered as nr 2

md: raid1 personality registered as nr 3

md: faulty personality registered as nr 10

md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27

NET: Registered protocol family 2

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP established hash table entries: 4096 (order: 3, 32768 bytes)

TCP bind hash table entries: 4096 (order: 2, 16384 bytes)

TCP: Hash tables configured (established 4096 bind 4096)

NET: Registered protocol family 1

NET: Registered protocol family 17

md: Autodetecting RAID arrays.

md: autorun ...

md: ... autorun DONE.

RAMDISK: Compressed image found at block 0

VFS: Mounted root (ext2 filesystem).

