From: Daniel Drake <dsd@gentoo.org>
Subject: SX4060 support in sata_sx4
Date: Sun, 11 Sep 2005 21:51:48 +0100
Message-ID: <432498E4.1060801@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070605080903060105080102"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:32461 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750867AbVIKUvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Sep 2005 16:51:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, xultra@gmail.com

This is a multi-part message in MIME format.
--------------070605080903060105080102
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Chris (on CC) owns a Promise SX4060 4-port IDE controller which he is trying 
to get working on Linux 2.6.

As this device appears to be based on a pdc20621 controller we tried a quick 
patch against sata_sx4 which worked to an extent (it recognised the attached 
disks) but was unable to read the partition table or any data.

I'm attaching the patch we tried. Here's what happened when we tried it:

sata_sx4 version 0.7
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 185
ata6: PATA max UDMA/133 cmd 0xFFFFC20000140200 ctl 0xFFFFC20000140238 bmdma 
0x0 irq 185
ata7: PATA max UDMA/133 cmd 0xFFFFC20000140280 ctl 0xFFFFC200001402B8 bmdma 
0x0 irq 185
ata8: PATA max UDMA/133 cmd 0xFFFFC20000140300 ctl 0xFFFFC20000140338 bmdma 
0x0 irq 185
ata9: PATA max UDMA/133 cmd 0xFFFFC20000140380 ctl 0xFFFFC200001403B8 bmdma 
0x0 irq 185
ata6: dev 0 cfg 49:2f00 82:346b 83:4b01 84:4000 85:3469 86:0801 87:4000 88:203f
ata6: dev 0 ATA, max UDMA/100, 234441648 sectors:
ata6(0): applying bridge limits
ata6: dev 0 configured for UDMA/100
scsi5 : sata_sx4
ata7: dev 0 cfg 49:2f00 82:346b 83:4b01 84:4000 85:3469 86:0801 87:4000 88:203f
ata7: dev 0 ATA, max UDMA/100, 234441648 sectors:
ata7(0): applying bridge limits
ata7: dev 0 configured for UDMA/100
scsi6 : sata_sx4
ata8: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
ata8: dev 0 ATA, max UDMA/100, 234441648 sectors: lba48
ata8(0): applying bridge limits
ata8: dev 0 configured for UDMA/100
scsi7 : sata_sx4
ATA: abnormal status 0x8 on port 0xFFFFC2000014039C
ata9: disabling port
scsi8 : sata_sx4
Vendor: ATA Model: WDC WD1200JB-00C Rev: 16.0
Type: Direct-Access ANSI SCSI revision: 05
Vendor: ATA Model: WDC WD1200JB-00C Rev: 16.0
Type: Direct-Access ANSI SCSI revision: 05
Vendor: ATA Model: WDC WD1200JB-00G Rev: 08.0
Type: Direct-Access ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
/dev/scsi/host5/bus0/target0/lun0:<3>ata6: command timeout
ata6: status=0x51 { DriveReady SeekComplete Error }
ata6: error=0x84 { DriveStatusError BadCRC }
SCSI error : <5 0 0 0> return code = 0x8000002
sda: Current: sense key=0xb
ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ata6: command timeout
ata6: status=0x51 { DriveReady SeekComplete Error }
ata6: error=0x84 { DriveStatusError BadCRC }
SCSI error : <5 0 0 0> return code = 0x8000002
sda: Current: sense key=0xb
ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
unable to read partition table
Attached scsi disk sda at scsi5, channel 0, id 0, lun 0
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdb: drive cache: write back
/dev/scsi/host6/bus0/target0/lun0:<3>ata7: command timeout
ata7: status=0x51 { DriveReady SeekComplete Error }
ata7: called with no error (51)!
SCSI error : <6 0 0 0> return code = 0x8000002
sdb: Current: sense key=0x3
ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ata7: command timeout
ata7: status=0x51 { DriveReady SeekComplete Error }
ata7: called with no error (51)!
SCSI error : <6 0 0 0> return code = 0x8000002
sdb: Current: sense key=0x3
ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
unable to read partition table
Attached scsi disk sdb at scsi6, channel 0, id 0, lun 0
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdc: drive cache: write back
/dev/scsi/host7/bus0/target0/lun0:<3>ata8: command timeout
ata8: status=0x51 { DriveReady SeekComplete Error }
ata8: error=0x84 { DriveStatusError BadCRC }
SCSI error : <7 0 0 0> return code = 0x8000002
sdc: Current: sense key=0xb
ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
ata8: command timeout
ata8: status=0x51 { DriveReady SeekComplete Error }
ata8: error=0x84 { DriveStatusError BadCRC }
SCSI error : <7 0 0 0> return code = 0x8000002
sdc: Current: sense key=0xb
ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
unable to read partition table
Attached scsi disk sdc at scsi7, channel 0, id 0, lun 0

If you have the resources to develop support for this hardware (and the time 
to do so!), Chris would be happy to test patches to get this device supported 
under Linux. Please let us know if we can provide any useful info.

Daniel

--------------070605080903060105080102
Content-Type: text/x-patch;
 name="sx4060.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sx4060.patch"

--- linux/drivers/scsi/sata_sx4.c.orig	2005-08-20 00:53:48.000000000 +0100
+++ linux/drivers/scsi/sata_sx4.c	2005-08-20 01:12:40.000000000 +0100
@@ -79,6 +79,7 @@ enum {
 				  (1<<23),
 
 	board_20621		= 0,	/* FastTrak S150 SX4 */
+	board_20621_pata	= 1,	/* FastTrak S150 SX4060 */
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
@@ -221,9 +222,21 @@ static struct ata_port_info pdc_port_inf
 		.port_ops	= &pdc_20621_ops,
 	},
 
+	/* board_20621_pata */
+	{
+		.sht		= &pdc_sata_sht,
+		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+				  ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_20621_ops,
+	},
 };
 
 static struct pci_device_id pdc_sata_pci_tbl[] = {
+	{ PCI_VENDOR_ID_PROMISE, 0x6621, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20621_pata },
 	{ PCI_VENDOR_ID_PROMISE, 0x6622, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20621 },
 	{ }	/* terminate list */

--------------070605080903060105080102--
