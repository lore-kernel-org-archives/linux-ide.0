From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: 05 Jan 2006 23:08:12 +0900
Message-ID: <87aceag437.fsf@marrow.phys.tohoku.ac.jp>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de> <20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
	<20060103164009.1c7418a7.randy_d_dunlap@linux.intel.com>
	<87ek3o22z8.fsf@marrow.phys.tohoku.ac.jp>
	<20060104114222.25182742.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tuhepnat.phys.tohoku.ac.jp ([130.34.123.133]:29201 "EHLO
	izanagi.tuhep.physp") by vger.kernel.org with ESMTP
	id S1751315AbWAEOIl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jan 2006 09:08:41 -0500
In-Reply-To: <20060104114222.25182742.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:
>
> Does your system work without using the AHCI driver?
> or is it required?

I tested turning off AHCI with 2.6.15-rc7 + git-libata-all.patch +
libata_resume_fix.patch + libata_suspend-fix.patch +
libata_suspend.patch.  The system runs okay, and ACPI suspend/resume
and suspend2 work, without AHCI.

> Of course, even if the AHCI driver is not needed,
> it shouldn't be oopsing like this.
> 
> It looks like the ata_piix driver is the one that is
> actually being used, from what I can see here.
> 
> Please send your /proc/interrupts, /proc/iomem, /proc/ioports,
> and 'lspci -v'.

They are enclosed below.

> If you are up to it, please enable libata verbose debugging
> and then boot & cause this bug again and send me as much
> output as you can collect.
> Patch is below.

Let me remind you that I used kernel 2.6.15-rc7 +
http://www.xenotime.net/linux/SATA/2.6.15-rc7/libata-combine.patch +
libata verbose debug patch.  libata-combine-2615.patch does not cause
kernel panic.

I copied boot up messages below for cases with CONFIG_SCSI_SATA_AHCI
turned off and on.  After turning on verbose debugging messages, the
call trace has changed, and the kernel panics for
CONFIG_SCSI_SATA_AHCI=n as well.

Jae-hyeon




Kernel output when CONFIG_SCSI_SATA_AHCI=n:


  PREFETCH window: d0000000-d1ffffff
  MEM window: a2000000-a3ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-6fff
  MEM window: a0200000-afffffff
  PREFETCH window: d0000000-d7ffffff
acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 16
acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 17
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
audit(1136496723.633:1): initialized
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 6144k, total 7872k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x96
fb0: VESA VGA frame buffer device
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
piix_init: pci_module_init
ata_pci_init_one: ENTER
acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt c1ff0000, dma 1ff0000
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identfy: do ATA identify
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_pio: ata1: cmd 0xEC
ata_pio_sector: data read
ata_qc_complete: EXIT
ata_dump_id: 49==0x0b00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x0078  81==0x0019  82==0x746b  83==0x5988  84==0x6003
ata_dump_id: 88==0x203f  93==0x600b
ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
ata_dev_identify: EXIT, drv_stat = 0x50
ata1(0): applying bridge limits
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x3 nsect 0x45 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 (dev_stat 0x50)
ata_qc_complete: EXIT
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, base=0x40, offset=5
ata1: dev 0 configured for UDMA/100
do_drive_set_taskfiles: unexpected GTF length (-1040260476)
ata_device_add: ata1: probe end
scsi0 : ata_piix
ata_device_add: probe_begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 32 c0 00
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 32 c0 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: HTC426060G9AT00   Rev: 00P3
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_device_add: EXIT, returning 1
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt c1ff9000, dma 1ff9000
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
ata_device_add: probe begin
ata_device_add: ata2: probe begin
ata_bus_reset: ENTER, host 2, port 0
ata_bus_softreset: ata2: bus reset via SRST
ata2: disabling port
ata_bus_reset: EXIT
ata_device_add: ata2: probe end
scsi1 : ata_piix
ata_device_add: probe begin
ata_device_add: EXIT, returning 1
piix_init: done
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 32 c0 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
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
ata_fill_sg: PRD[0] = (0x37C0B000, 0x1000)
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xE0
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: host_stat 0x24
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
ata_sg_clean: unmapping 1 sg elements
Unable to handle kernel NULL pointer dereference at virtual address 00000172
 printing eip:
c0118fc5
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c0118fc5>]    Not tainted VLI
EFLAGS: 00010006   (2.6.15-rc7-debugnoahci)
EIP is at complete+0x15/0x60
eax: 00000172   ebx: c036a000   ecx: 00000000   edx: c1fee760
esi: 00000082   edi: 00000001   ebp: c036bee4   esp: c036bec8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c036a000 task=c0327b00)
Stack: c0255933 c1fefb58 c1fefb00 c0252800 00000046 00000000 c1fee284 00000000
       c026242d c1fee760 00000000 c1fee760 c0262520 c1fee760 00000000 c1fee760
       00000000 c011cb87 c1fd0260 c1fee284 c0262bf8 c1fee760 00000000 00000001
Call Trace:
 [<c0255933>] scsi_delete_timer+0x13/0x30
 [<c0252800>] scsi_done+0x10/0x30
 [<c026242d>] __ata_qc_complete+0x6d/0x80
 [<c0262520>] ata_qc_complete+0x50/0xe0
 [<c011cb87>] printk+0x17/0x20
 [<c0262bf8>] ata_interrupt+0x178/0x190
 [<c013f5e9>] handle_IRQ_event+0x39/0x70
 [<c013f69e>] __do_IRQ+0x7e/0x120
 [<c01219a1>] __do_softirq+0x41/0xa0
 [<c0105739>] do_IRQ+0x19/0x30
 [<c0103b82>] common_interrupt+0x1a/0x20
 [<c010105d>] default_idle+0x2d/0x50
 [<c01010e2>] cpu_idle+0x42/0x60
 [<c036c87f>] start_kernel+0x15f/0x180
 [<c036c3b0>] unknown_bootoption+0x0/0x1f0
Code: 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d e9 c5 bf 1b 00 90 8d 74 26 00 55 89 e5 56 53 83 ec 14 9c 5e fa bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 00 31 c9 31 d2 89 4c 24 10 83 c0 04 b9 01 00 00 00 89 54 24
 <0>Kernel panic - not syncing: Fatal exception in interrupt




Kernel output when CONFIG_SCSI_SATA_AHCI=y:


  PREFETCH window: d0000000-d1ffffff
  MEM window: a2000000-a3ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-6fff
  MEM window: a0200000-afffffff
  PREFETCH window: d0000000-d7ffffff
acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 16
acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 17
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
audit(1136491631.351:1): initialized
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 6144k, total 7872k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x96
fb0: VESA VGA frame buffer device
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
ahci_init_one: ENTER
acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
ahci: probe of 0000:00:1f.2 failed with error -12
piix_init: pci_module_init
ata_pci_init_one: ENTER
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt c1ff0000, dma 1ff0000
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identfy: do ATA identify
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_exec_command_pio: ata1: cmd 0xEC
ata_pio_sector: data read
ata_qc_complete: EXIT
ata_dump_id: 49==0x0b00  53==0x0007  63==0x0007  64==0x0003  75==0x0000
ata_dump_id: 80==0x0078  81==0x0019  82==0x746b  83==0x5988  84==0x6003
ata_dump_id: 88==0x203f  93==0x600b
ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
ata_dev_identify: EXIT, drv_stat = 0x50
ata1(0): applying bridge limits
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x3 nsect 0x45 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 (dev_stat 0x50)
ata_qc_complete: EXIT
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, base=0x40, offset=5
ata1: dev 0 configured for UDMA/100
do_drive_set_taskfiles: unexpected GTF length (-1040260476)
ata_device_add: ata1: probe end
scsi0 : ata_piix
ata_device_add: probe_begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 ff c1 50
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 ff c1 50
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: HTC426060G9AT00   Rev: 00P3
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_device_add: EXIT, returning 1
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt c1ff9000, dma 1ff9000
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
ata_device_add: probe begin
ata_device_add: ata2: probe begin
ata_bus_reset: ENTER, host 2, port 0
ata_bus_softreset: ata2: bus reset via SRST
ata2: disabling port
ata_bus_reset: EXIT
ata_device_add: ata2: probe end
scsi1 : ata_piix
ata_device_add: probe begin
ata_device_add: EXIT, returning 1
piix_init: done
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 ff c1 50
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
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
ata_fill_sg: PRD[0] = (0x37C0B000, 0x1000)
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xE0
ata_exec_command_pio: ata1: cmd 0xC8
ata_scsi_translate: EXIT
ata_host_intr: ata1: host_stat 0x24
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
ata_sg_clean: unmapping 1 sg elements
Unable to handle kernel NULL pointer dereference at virtual address 00000172
 printing eip:
c0118fc5
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c0118fc5>]    Not tainted VLI
EFLAGS: 00010006   (2.6.15-rc7-debugahci)
EIP is at complete+0x15/0x60
eax: 00000172   ebx: c036c000   ecx: 00000000   edx: c1fee760
esi: 00000082   edi: 00000001   ebp: c036dee4   esp: c036dec8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c036c000 task=c0329b00)
Stack: c0255933 c1fefb58 c1fefb00 c0252800 00000046 00000000 c1fee284 00000000
       c026242d c1fee760 00000000 c1fee760 c0262520 c1fee760 00000000 c1fee760
       00000000 c011cb87 c1fd0260 c1fee284 c0262bf8 c1fee760 00000000 00000001
Call Trace:
 [<c0255933>] scsi_delete_timer+0x13/0x30
 [<c0252800>] scsi_done+0x10/0x30
 [<c026242d>] __ata_qc_complete+0x6d/0x80
 [<c0262520>] ata_qc_complete+0x50/0xe0
 [<c011cb87>] printk+0x17/0x20
 [<c0262bf8>] ata_interrupt+0x178/0x190
 [<c013f5e9>] handle_IRQ_event+0x39/0x70
 [<c013f69e>] __do_IRQ+0x7e/0x120
 [<c01219a1>] __do_softirq+0x41/0xa0
 [<c0105739>] do_IRQ+0x19/0x30
 [<c0103b82>] common_interrupt+0x1a/0x20
 [<c010105d>] default_idle+0x2d/0x50
 [<c01010e2>] cpu_idle+0x42/0x60
 [<c036e87f>] start_kernel+0x15f/0x180
 [<c036e3b0>] unknown_bootoption+0x0/0x1f0
Code: 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d e9 05 d6 1b 00 90 8d 74 26 00 55 89 e5 56 53 83 ec 14 9c 5e fa bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 00 31 c9 31 d2 89 4c 24 10 83 c0 04 b9 01 00 00 00 89 54 24
 <0>Kernel panic - not syncing: Fatal exception in interrupt




The following information was collected with the working kernel
mentioned above because I cannot boot otherwise.


/proc/interrupts:

           CPU0       
  0:     118963    IO-APIC-edge  timer
  1:        131    IO-APIC-edge  i8042
  5:         10    IO-APIC-edge  serial
  8:          4    IO-APIC-edge  rtc
  9:       2982   IO-APIC-level  acpi
 12:        707    IO-APIC-edge  i8042
 14:       6517    IO-APIC-edge  libata
 15:          1    IO-APIC-edge  libata
 17:          0   IO-APIC-level  uhci_hcd:usb1, eth0, i915@pci:0000:00:02.0
 18:          0   IO-APIC-level  Intel ICH6 Modem
 19:          0   IO-APIC-level  uhci_hcd:usb2
 20:         21   IO-APIC-level  uhci_hcd:usb3
 21:          2   IO-APIC-level  uhci_hcd:usb4, ehci_hcd:usb5
 22:          0   IO-APIC-level  Intel ICH6
 23:       6650   IO-APIC-level  ipw2200
NMI:          0 
LOC:      22882 
ERR:          0
MIS:          0


/proc/iomem:

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce800-000cfdff : Adapter ROM
000d0000-000d0fff : Adapter ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-5f6dffff : System RAM
  00100000-002cec28 : Kernel code
  002cec29-0035db1f : Kernel data
5f6e0000-5f6f4fff : ACPI Tables
5f6f5000-5f6fffff : ACPI Non-volatile Storage
5f700000-5fffffff : reserved
68000000-6807ffff : 0000:00:02.1
a0000000-a003ffff : 0000:00:02.0
a0040000-a00403ff : 0000:00:1d.7
  a0040000-a00403ff : ehci_hcd
a0040400-a00404ff : 0000:00:1e.2
  a0040400-a00404ff : Intel ICH6
a0040800-a00409ff : 0000:00:1e.2
  a0040800-a00409ff : Intel ICH6
a0080000-a00fffff : 0000:00:02.0
a0100000-a01fffff : PCI Bus #02
  a0100000-a010ffff : 0000:02:00.0
    a0100000-a010ffff : tg3
a0200000-afffffff : PCI Bus #04
  a0200000-a0200fff : 0000:04:00.0
  a0201000-a02010ff : 0000:04:00.1
  a0202000-a0202fff : 0000:04:02.0
    a0202000-a0202fff : ipw2200
  a2000000-a3ffffff : PCI CardBus #05
c0000000-cfffffff : 0000:00:02.0
  c0000000-c07affff : vesafb
d0000000-d7ffffff : PCI Bus #04
  d0000000-d1ffffff : PCI CardBus #05
e0000000-efffffff : reserved
f0008000-f000bfff : reserved
fec00000-fec0ffff : reserved
fed14000-fed19fff : reserved
fed20000-fed8ffff : reserved
fee00000-fee00fff : reserved
ff000000-ffffffff : reserved


/proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : libata
01f0-01f7 : libata
0200-0207 : serial
03c0-03df : vesafb
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
15c0-15df : motherboard
15e0-15ef : motherboard
1600-162f : motherboard
1632-167f : motherboard
1800-1807 : 0000:00:02.0
1810-181f : 0000:00:1f.2
  1810-181f : libata
1820-183f : 0000:00:1d.0
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.1
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.2
  1860-187f : uhci_hcd
1880-189f : 0000:00:1d.3
  1880-189f : uhci_hcd
18a0-18bf : 0000:00:1f.3
18c0-18ff : 0000:00:1e.2
  18c0-18ff : Intel ICH6
1c00-1cff : 0000:00:1e.2
  1c00-1cff : Intel ICH6
2000-207f : 0000:00:1e.3
  2000-207f : Intel ICH6 Modem
2400-24ff : 0000:00:1e.3
  2400-24ff : Intel ICH6 Modem
3000-6fff : PCI Bus #04
  3000-30ff : PCI CardBus #05
  3400-34ff : PCI CardBus #05


lspci -v:

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
	Subsystem: IBM: Unknown device 0575
	Flags: bus master, fast devsel, latency 0
	Capabilities: <available only to root>

0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0582
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at a0080000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1800 [size=8]
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Memory at a0000000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: <available only to root>

0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
	Subsystem: IBM: Unknown device 0582
	Flags: fast devsel
	Memory at 68000000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: <available only to root>

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: a0100000-a01fffff
	Capabilities: <available only to root>

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at 1820 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 1840 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at 1860 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 1880 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 0566
	Flags: bus master, medium devsel, latency 0, IRQ 21
	Memory at a0040000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=07, sec-latency=64
	I/O behind bridge: 00003000-00006fff
	Memory behind bridge: a0200000-afffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d7f00000
	Capabilities: <available only to root>

0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: IBM: Unknown device 0581
	Flags: bus master, medium devsel, latency 0, IRQ 22
	I/O ports at 1c00 [size=256]
	I/O ports at 18c0 [size=64]
	Memory at a0040800 (32-bit, non-prefetchable) [size=512]
	Memory at a0040400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0576
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
	Subsystem: IBM: Unknown device 0568
	Flags: bus master, medium devsel, latency 0

0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])
	Subsystem: IBM: Unknown device 056a
	Flags: bus master, 66MHz, medium devsel, latency 0
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1810 [size=16]
	Capabilities: <available only to root>

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: IBM: Unknown device 056b
	Flags: medium devsel, IRQ 11
	I/O ports at 18a0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 11)
	Subsystem: IBM: Unknown device 0577
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at a0100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:04:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8d)
	Subsystem: IBM: Unknown device 0555
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at a0200000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=04, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: d0000000-d1fff000 (prefetchable)
	Memory window 1: a2000000-a3fff000 (prefetchable)
	I/O window 0: 00003000-000030ff
	I/O window 1: 00003400-000034ff
	16-bit legacy interface ports at 0001

0000:04:00.1 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 13)
	Subsystem: IBM: Unknown device 0556
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at a0201000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:04:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2712
	Flags: bus master, medium devsel, latency 64, IRQ 23
	Memory at a0202000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

