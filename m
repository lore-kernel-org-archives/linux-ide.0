From: Jarno Paananen <jpaana@s2.org>
Subject: Promise 579 with current(?) libata in libata-dev-2.6 queue
Date: Mon, 11 Oct 2004 19:22:15 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3sm8ljkco.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.org ([195.197.64.39]:61633 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id S269048AbUJKQWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2004 12:22:19 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi,

I have a MSI K8T Neo2 FIR AMD64 board with Promise 579 SATA
controller onboard. With slight hesitation of losing my disks I
tried the latest libata I could find and added the PCI id (which
interestingly is 0x3574 although the chip definitely is called 579
and is printed on the chip itself...) with the controller type 37x
which I thought was closest. The controller has two SATA ports and a
PATA port so in that respect it is pretty close to 379 for example,
but is advertised as SATA-II 150 controller, what ever that means.

The two disks are PATA, but connected to SATA ports with
ABIT Serielbrille2 converters (using some SiL bridge chips), the
PATA port is empty.

Anyway, the results were not as bad nor as good as I had
feared/hoped, but here's the log after insmoding the modified
sata_promise:

libata version 1.02 loaded.
sata_promise version 1.00
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 169
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xF8C04200 ctl 0xF8C04238 bmdma 0x0 irq 169
ata2: SATA max UDMA/133 cmd 0xF8C04280 ctl 0xF8C042B8 bmdma 0x0 irq 169
ata3: PATA max UDMA/133 cmd 0xF8C04300 ctl 0xF8C04338 bmdma 0x0 irq 169
ata1: dev 0 cfg 49:2f00 82:7c69 83:4f09 84:4003 85:7c69 86:0e01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors: lba48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi1 : sata_promise
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:203f
ata2: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi2 : sata_promise
irq 169: nobody cared!
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+289/304] do_IRQ+0x121/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+0/48] default_idle+0x0/0x30
 [default_idle+35/48] default_idle+0x23/0x30
 [cpu_idle+58/96] cpu_idle+0x3a/0x60
 [start_kernel+345/384] start_kernel+0x159/0x180
 [unknown_bootoption+0/352] unknown_bootoption+0x0/0x160
handlers:
[pg0+944559744/1068774400] (snd_emu10k1_interrupt+0x0/0x400 [snd_emu10k1])
[pg0+943174000/1068774400] (interrupt_hw+0x0/0x330 [saa7146])
[pg0+947107120/1068774400] (pdc_interrupt+0x0/0x1c0 [sata_promise])
Disabling IRQ #169
ATA: abnormal status 0x8 on port 0xF8C0431C
ata3: disabling port
scsi3 : sata_promise
  Vendor: ATA       Model: Maxtor 4G120J6    Rev: GAK8
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write back
 sdb:<3>ata1: command timeout
ata1: status=0x51 { DriveReady SeekComplete Error }
SCSI error : <1 0 0 0> return code = 0x8000002
EOM Current sdb: sense = 70 4d
ASC=c2 ASCQ=f8
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ata1: command timeout
ata1: status=0x51 { DriveReady SeekComplete Error }
SCSI error : <1 0 0 0> return code = 0x8000002
EOM Current sdb: sense = 70 4d
ASC=c2 ASCQ=f8
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
 unable to read partition table
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: SAMSUNG SV1604N   Rev: TR10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc:<3>ata2: command timeout
ata2: status=0x51 { DriveReady SeekComplete Error }
SCSI error : <2 0 0 0> return code = 0x8000002
EOM Current sdc: sense = 70 4d
ASC=c2 ASCQ=f8
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
ata2: command timeout
ata2: status=0x51 { DriveReady SeekComplete Error }
SCSI error : <2 0 0 0> return code = 0x8000002
EOM Current sdc: sense = 70 4d
ASC=c2 ASCQ=f8
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
 unable to read partition table
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg4 at scsi2, channel 0, id 0, lun 0,  type 0

I have a SCSI disk as sda and scsi cd-r, therefore the oddish
device names.

Promise also has a GPL'ed driver for the chip (source at
http://www.promise.com/support/file/driver/1_SATAII%20Linux%20source%20code.tgz)
which works fine for 2.4 kernels, but doesn't compile for 2.6 (I
tried to make it but only got null pointer oopses in return...) nor
too well for AMD64 kernels. But on i386 2.4 kernel it gives:

PROMISE SATA-II 150 Series Linux Driver v1.00.0.12
ulsata2:[info] Drive 1: Maxtor 4G120J6         240121727s 122942MB  UDMA6
ulsata2:[info] Drive 3: SAMSUNG SV1604N        312581807s 160042MB  UDMA5
scsi3 : ulsata2
  Vendor:           Model: Maxtor 4G120J6    Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor:           Model: SAMSUNG SV1604N   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
Attached scsi disk sde at scsi3, channel 0, id 2, lun 0
SCSI device sdd: 240121728 512-byte hdwr sectors (122942 MB)
 sdd: sdd1 < sdd5 sdd6 sdd7 >
SCSI device sde: 312581808 512-byte hdwr sectors (160042 MB)
 sde: sde1 sde2 < sde5 >

Any ideas I could try or any other pointers?

Thanks,
// Jarno
