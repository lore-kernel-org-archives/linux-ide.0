From: Paul Fisher <rao@gnu.org>
Subject: libata problems with 66Mhz Promise SATA150 TX4
Date: Mon, 13 Sep 2004 17:14:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m34qm13m8h.fsf@zathras.nivin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kosh.nivin.org ([66.92.70.92]:33412 "EHLO mail.nivin.org")
	by vger.kernel.org with ESMTP id S268907AbUIMVO1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Sep 2004 17:14:27 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

We're experiencing failures on a Promise SATA150 TX4 when run at 66Mhz
on either PCI-X bus on a Tyan S2882 (dual Opteron system).  The
problems manifest themselves rather quickly on an SMP-enabled kernel,
and it takes a bit longer to kill a non-SMP kernel.

We've tried swapping out the motherboard, hard drives (for the same
brand however -- Western Digital), as well as the SATA cables.

The only way we can get a stable system is to run the SATA150 TX4 off
the 33Mhz PCI bus.

Accessing the drives by building a RAID-5 array across four drives
will kill the machine in about 10 minutes.

During the array build, we sometimes receive error messages of:

ataX: status=0x51 { DriveReady, SeekComplete, Error }
ataX: called with no error (51)!

... and then we eventually get:

ataX: command timeout

After the command timeout, we immediately get a fatal Machine Check
Exception.  Turning on ATA_DEBUG and ATA_VERBOSE_DEBUG while using a
serial console causes the machine to die in a different way, as soon
as mdadm starts running.  (With debugging on, the machine dies in the
normal (command timeout) way if we're not using the serial console.)

We've tested 2.6.8, 2.6.9-rc1, and 2.6.9-rc1-bk16.

Below is relevant output from 2.6.9-rc1 along with the MCE following a
command timeout.  Other dumps of PCI information, kernel config, and
full serial console logs are at <URL:http://www.gnu.org/promise/>.

Mounted /pata1: SATA max UDMA/133 cmd 0xFFFFFF0000016200 ctl 0xFFFFFF0000016238 bmdma 0x0 irq 201
roc filesystem
ata2: SATA max UDMA/133 cmd 0xFFFFFF0000016280 ctl 0xFFFFFF00000162B8 bmdma 0x0 irq 201
Mounting sysfs
ata3: SATA max UDMA/133 cmd 0xFFFFFF0000016300 ctl 0xFFFFFF0000016338 bmdma 0x0 irq 201
Loading scsi_modata4: SATA max UDMA/133 cmd 0xFFFFFF0000016380 ctl 0xFFFFFF00000163B8 bmdma 0x0 irq 201
.ko module
Loading sd_mod.ko module
Loading libata.ko module
Loading sata_promise.ko module
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
ata3: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata4: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: WDC WD2500SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: WDC WD2500SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
  Vendor: ATA       Model: WDC WD2500SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
  Vendor: ATA       Model: WDC WD2500SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0

[...]

ata4: command timeout
CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
RIP !INEXACT! 10:<ffffffffa00244d7> {ata_check_status_mmio+0x7/0x10 [libata]}
TSC 84a68e655e 
Kernel panic - not syncing: Machine check
 Badness in smp_call_function at arch/x86_64/kernel/smp.c:408

Call Trace:<ffffffff8011cdad>{smp_call_function+109} <ffffffff8011cee9>{smp_send_stop+25} 
<ffffffff801381bc>{panic+204} <ffffffff80118140>{mce_available+0} 
<ffffffff8011851b>{do_machine_check+939} <ffffffffa00244d7>{:libata:ata_check_status_mmio+7} 
<ffffffffa00244d7>{:libata:ata_check_status_mmio+7} 
<ffffffff801116eb>{machine_check+127} <ffffffffa00244d7>{:libata:ata_check_status_mmio+7} 
 <EOE> <ffffffffa002f3c8>{:sata_promise:pdc_eng_timeout+136} 
       <ffffffffa00282d2>{:libata:ata_scsi_error+18} <ffffffffa0004152>{:scsi_mod:scsi_error_handler+434} 
       <ffffffff801111b3>{child_rip+8} <ffffffffa0003fa0>{:scsi_mod:scsi_error_handler+0} 
       <ffffffff801111ab>{child_rip+0} 
divide error: 0000 [1] SMP 
CPU 0 
Modules linked in: raid5 xor md5 ipv6 usbserial parport_pc lp parport autofs4 ds yenta_socket pcmcia_core e100 mii tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables floppy sg dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd sata_promise libata sd_mod scsi_mod
Pid: 206, comm: scsi_eh_3 Not tainted 2.6.9-rc1
RIP: 0010:[<ffffffff80133e50>] <ffffffff80133e50>{scheduler_tick+1024}
RSP: 0018:ffffffff803ef668  EFLAGS: 00010046
RAX: 000000000000004e RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff803f7508
RBP: ffffffff803ef698 R08: 00000000000927bf R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000004e
R13: 000001007fc2eab0 R14: 0000010002c20560 R15: 0000000000000000
FS:  0000002a958624c0(0000) GS:ffffffff80461b00(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a956f1bf0 CR3: 0000000000101000 CR4: 00000000000006e0
Process scsi_eh_3 (pid: 206, threadinfo 000001007f344000, task 000001007fc2eab0)
Stack: 0000000000000092 ffffffff8033462f ffffffff80379bc0 0000000000000000 
       00000084a68e5f44 ffffffff8033462f 00000000ffffffff ffffffff8011d6b4 
       0000000000000046 ffffffff80110eab 
Call Trace:<IRQ> <ffffffff8011d6b4>{smp_apic_timer_interrupt+52} <ffffffff80110eab>{apic_timer_interrupt+99} 
        <EOI> <ffffffff8011ceb0>{smp_really_stop_cpu+0} <ffffffff8011ceaf>{smp_stop_cpu+31} 
       <ffffffff801381bc>{panic+204} <ffffffff80118140>{mce_available+0} 
       <ffffffff8011851b>{do_machine_check+939} <ffffffffa00244d7>{:libata:ata_check_status_mmio+7} 
       <ffffffffa00244d7>{:libata:ata_check_status_mmio+7} 
       <ffffffff801116eb>{machine_check+127} <ffffffffa00244d7>{:libata:ata_check_status_mmio+7} 
       <ffffffff8010e9a0>{default_idle+0} 

Code: f7 f3 85 d2 0f 85 a6 00 00 00 be 08 00 00 00 48 c7 c7 08 75 
RIP <ffffffff80133e50>{scheduler_tick+1024} RSP <ffffffff803ef668>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
