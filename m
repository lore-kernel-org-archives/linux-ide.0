From: Abhijit Bhopatkar <bainonline@gmail.com>
Subject: dma with libata and ATAPI in 2.6.13 ICH6M combined mode
Date: Sun, 4 Sep 2005 05:50:32 -0400
Message-ID: <2ff2162805090402506cad6416@mail.gmail.com>
Reply-To: bainonline@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:9061 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751323AbVIDJud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Sep 2005 05:50:33 -0400
Received: by zproxy.gmail.com with SMTP id r28so528920nza
        for <linux-ide@vger.kernel.org>; Sun, 04 Sep 2005 02:50:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

I have ACER TM4150NLCi with ICH6M chipset 
The chipset is in combined mode by default and bios has no way to turn it off.
It has a harddisk and dvd rom.
With latest kernel the lib_ata is able to work with harddisk and the
atapi also works fine for read and write (not thoroughly tested yet,
but it didn't work at all in previous kernels)
Unfortunately even though kernel reports UDMA capability the dma on
both drives is disabled ( i can tell by the time it takes to read and
write)

Is there any way to turn the dma on here?

Here is what i have....
Upon reading that ATAPI support in libata is out for testing i
downloaded 2.6.13 and diabled the ide_generic option in .config.

I also had to change drivers/scsi/ata_piix.c as

50,51c50,51
<       PIIX_COMB_PATA_P0       = (1 << 1),
<       PIIX_COMB               = (1 << 2), /* combined mode enabled? */
---
>       PIIX_COMB_PATA_P0       = (1 << 0),
>       PIIX_COMB               = (1 << 1), /* combined mode enabled? */

With this and following relevent .config part
--
#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y

#
# SCSI low-level drivers
#
...<snip>
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=y
CONFIG_SCSI_ATA_PIIX=y
--

The harddisk is now recognised as sda and the dvd rom as sr0.
ata_piix version 1.04
ata_piix: combined mode detected
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1100 irq 14
ata1: SATA port has no device.
scsi0 : ata_piix
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1108 irq 15
ata2: dev 0 cfg 49:0f00 82:746b 83:7fe8 84:4023 85:f468 86:3c48 87:4023 88:203f
ata2: dev 0 ATA, max UDMA/100, 78140160 sectors: lba48
ata2: dev 1 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata2: dev 1 ATAPI, max MWDMA2
ata2: dev 0 configured for PIO4
ata2: dev 1 configured for PIO4
scsi1 : ata_piix
  Vendor: ATA       Model: HTS424040M9AT00   Rev: MA2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: HL-DT-ST  Model: RW/DVD GCC-4243N  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 05
st: Version 20050501, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 0,  type 5
SCSI Media Changer driver v0.25
--

#hdparm  /dev/sda
/dev/sda:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 4864/255/63, sectors = 78140160, start = 0

# hdparm /dev/sr0
/dev/sr0:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Inappropriate ioctl for device

Thanks and regards 
Abhijit Bhopatkar
