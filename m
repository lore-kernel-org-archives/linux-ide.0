From: Nicholas Dronen <ndronen@technolalia.com>
Subject: Panics with libata functions in stack.
Date: Thu, 27 Jul 2006 12:00:27 -0600
Message-ID: <20060727180027.GM27144@technolalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from technolalia.com ([209.120.188.217]:19435 "EHLO
	mail.technolalia.com") by vger.kernel.org with ESMTP
	id S1751901AbWG0SAR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jul 2006 14:00:17 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, linux-ide:

We have a workstation with a dual-core Pentium 4 3.4 Ghz processor that
started to panic last Friday.  The machine stays up for 15 minutes to
a few hours, then it panics again.  We suspect a hardware problem, but
I'd like to ask here whether there's newer libata or other code that
fixes the panic.

I've seen two panics since I heard about the problem and the stack trace
each time has been:

  Badness in i8042_panic_blink at drivers/input/serio/i8042.c:988
  i8042_panic_blink +0x188/0x1a0
  panic +0xc/0x147
  die +0x164/0x16b
  vprintk +0x136/0x149
  do_page_fault +0x0/0x5b6
  do_page_fault +0x3f0/0x5b6
  ata_to_sense_error +0x40/0x299 [libata]
  recalc_task_prio +0x128/0x133
  activate_task +0x88/0x95
  try_to_wakeup +0x222/0x22d
  autoremove_wake_function +0xd/0x2d
  __wake_up_common +0x36/0x51
  do_page_fault +0x0/0x5b6
  error_code + 0x2f/0x38
  ata_to_sense_error +0x40/0x299 [libata]
  ata_scsi_qc_complete +0x17/0x2d [libata]
  ata_qc_complete +0x6b/0x7b [libata]
  ahci_interrupt +0x100/0x151 [ahci]
  handle_IRQ_event +0x25/0x4f
  do_IRQ +0xb0/0x130
  common_interrupt +0x18/0x20
  unix_detach_fds +0x2e/0x31

(Anything confusing about the stack might be due to the fact that I
wrote it down by hand.)

The kernel came with RedHat EL 4.0.  Uname -r shows 2.6.9-5.ELsmp.
In case it's useful, here is output from dmesg.

    SCSI subsystem initialized
    libata version 1.02 loaded.
    ahci version 1.00a
    ACPI: PCI interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 217
    PCI: Setting latency timer of device 0000:00:1f.2 to 64
    ahci(0000:00:1f.2) AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA
    mode
    ahci(0000:00:1f.2) flags: 64bit ncq pm led clo pio slum part
    ata1: SATA max UDMA/133 cmd 0xF881AD00 ctl 0x0 bmdma 0x0 irq 217
    ata2: SATA max UDMA/133 cmd 0xF881AD80 ctl 0x0 bmdma 0x0 irq 217
    ata3: SATA max UDMA/133 cmd 0xF881AE00 ctl 0x0 bmdma 0x0 irq 217
    ata4: SATA max UDMA/133 cmd 0xF881AE80 ctl 0x0 bmdma 0x0 irq 217
    ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3e01 87:4023
    88:207f
    ata1: dev 0 ATA, max UDMA/133, 156250000 sectors: lba48
    ata1: dev 0 configured for UDMA/133
    scsi0 : ahci
    ata2: no device found (phy stat 00000000)
    scsi1 : ahci
    ata3: no device found (phy stat 00000000)
    scsi2 : ahci
    ata4: no device found (phy stat 00000000)
    scsi3 : ahci
      Vendor: ATA       Model: WDC WD800JD-75MS  Rev: 10.0
      Type:   Direct-Access                      ANSI SCSI revision: 05
    SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
    SCSI device sda: drive cache: write back
     sda: sda1 sda2
    Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Is this something that's been patched already?  An irredeemable hardware
problem?  Something else altogether?

If anyone would like more information, I'd be happy to provide it.

Regards,

Nick


