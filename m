From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: piix dma setup code
Date: Wed, 19 May 2004 18:51:06 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405191851.06281.bzolnier@elka.pw.edu.pl>
References: <40A9F150.4070209@turbolinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24800 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264412AbUESQue
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 12:50:34 -0400
In-Reply-To: <40A9F150.4070209@turbolinux.co.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Go Taniguchi <go@turbolinux.co.jp>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>


On Tuesday 18 of May 2004 13:19, Go Taniguchi wrote:
> Hi,
>
> I think that there are some problems in piix dma setup code.
>
> At function piix_set_udmamode in ata_piix.c.These is same code in piix.c.
>
>
> //        if (!(reg48 & u_flag))
> //                pci_write_config_word(dev, 0x48, reg48|u_flag);
>
> ICH PCI register offset 48 "Synchronous DMA Control Register" register size
> is 8bit. pci_write_config_byte is better.

Yep.

> //        if (speed == XFER_UDMA_5) {
>
> If speed is XFER_UDMA_6, base clock is set to low base clock.
> It should be "speed >= XFER_UDMA_5". My ICH6 system reported XFER_UDMA_6,

Jeff, does ICH6 support UDMA6?
ICH5 doesn't but ata_piix.c allows it.

> //                pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
> //        } else {
> //                pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
> //        }
> //        if (!(reg4a & u_speed)) {
>
> If u_speed is 0, It is always the TRUE.
> And I think that this 2bit comparison is wrong.
> Probably It is "(reg4a & a_speed) != u_speed"

Yep, fortunately correct timings were always set thanks to:

> //                pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
> This set-up is done overwrite of with next line.
> //                pci_write_config_word(dev, 0x4a, reg4a|u_speed);
> We should do and/or with original data.
> So, these are pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) |
> u_speed);
>
> //        }
> //        if (speed > XFER_UDMA_2) {
> //                if (!(reg54 & v_flag)) {
>                         pci_write_config_word(dev, 0x54, reg54|v_flag);
> If word accesses to reg54, reg55 is overwritten by old original data.
> reg55 set already fails. It should be byte access.

Yep, this is a real bug.  Good catch.

> //                }
> //        } else {
> //                pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
> //        }
>
> I attched patch file.
> Two registers changed it in 8bit access and removed reg44 which was not
> used.

Thanks.

Jeff, here is updated patch
(limits ata_piix.c to UDMA5 and fixes comments in piix.c).

 linux-2.6.6-bk3-bzolnier/drivers/ide/pci/piix.c  |   35 +++++++++--------------
 linux-2.6.6-bk3-bzolnier/drivers/scsi/ata_piix.c |   30 +++++++------------
 2 files changed, 27 insertions(+), 38 deletions(-)

diff -puN drivers/ide/pci/piix.c~piix-dma-setmode drivers/ide/pci/piix.c
--- linux-2.6.6-bk3/drivers/ide/pci/piix.c~piix-dma-setmode	2004-05-19 18:20:03.620392840 +0200
+++ linux-2.6.6-bk3-bzolnier/drivers/ide/pci/piix.c	2004-05-19 18:39:03.421116792 +0200
@@ -49,9 +49,9 @@
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x40, &reg40);
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x42, &reg42);
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x44, &reg44);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x48, &reg48);
+ * pci_read_config_byte(HWIF(drive)->pci_dev, 0x48, &reg48);
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x4a, &reg4a);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x54, &reg54);
+ * pci_read_config_byte(HWIF(drive)->pci_dev, 0x54, &reg54);
  *
  * Documentation
  *	Publically available from Intel web site. Errata documentation
@@ -432,15 +432,14 @@ static int piix_tune_chipset (ide_drive_
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
 	int			sitre;
-	u16			reg4042, reg44, reg48, reg4a, reg54;
-	u8			reg55;
+	u16			reg4042, reg4a;
+	u8			reg48, reg54, reg55;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
-	pci_read_config_word(dev, 0x44, &reg44);
-	pci_read_config_word(dev, 0x48, &reg48);
+	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
-	pci_read_config_word(dev, 0x54, &reg54);
+	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
 
 	switch(speed) {
@@ -462,30 +461,26 @@ static int piix_tune_chipset (ide_drive_
 
 	if (speed >= XFER_UDMA_0) {
 		if (!(reg48 & u_flag))
-			pci_write_config_word(dev, 0x48, reg48|u_flag);
+			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed == XFER_UDMA_5) {
 			pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
 		} else {
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 		}
-		if (!(reg4a & u_speed)) {
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
-		}
+		if ((reg4a & a_speed) != u_speed)
+			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
 		if (speed > XFER_UDMA_2) {
-			if (!(reg54 & v_flag)) {
-				pci_write_config_word(dev, 0x54, reg54|v_flag);
-			}
-		} else {
-			pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
-		}
+			if (!(reg54 & v_flag))
+				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
+		} else
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 	} else {
 		if (reg48 & u_flag)
-			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
+			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
 		if (reg4a & a_speed)
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 		if (reg54 & v_flag)
-			pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 		if (reg55 & w_flag)
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
diff -puN drivers/scsi/ata_piix.c~piix-dma-setmode drivers/scsi/ata_piix.c
--- linux-2.6.6-bk3/drivers/scsi/ata_piix.c~piix-dma-setmode	2004-05-19 18:20:03.625392080 +0200
+++ linux-2.6.6-bk3-bzolnier/drivers/scsi/ata_piix.c	2004-05-19 18:34:04.613542448 +0200
@@ -187,7 +187,7 @@ static struct ata_port_info piix_port_in
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.udma_mask	= 0x3f,	/* udma0-5 ; FIXME */
 		.port_ops	= &piix_sata_ops,
 	},
 
@@ -424,22 +424,20 @@ static void piix_set_udmamode (struct at
 	int w_flag		= 0x10 << drive_dn;
 	int u_speed		= 0;
 	int			sitre;
-	u16			reg4042, reg44, reg48, reg4a, reg54;
-	u8			reg55;
+	u16			reg4042, reg4a;
+	u8			reg48, reg54, reg55;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	DPRINTK("reg4042 = 0x%04x\n", reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
-	pci_read_config_word(dev, 0x44, &reg44);
-	pci_read_config_word(dev, 0x48, &reg48);
+	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
-	pci_read_config_word(dev, 0x54, &reg54);
+	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
 
 	switch(speed) {
 		case XFER_UDMA_4:
 		case XFER_UDMA_2:	u_speed = 2 << (drive_dn * 4); break;
-		case XFER_UDMA_6:
 		case XFER_UDMA_5:
 		case XFER_UDMA_3:
 		case XFER_UDMA_1:	u_speed = 1 << (drive_dn * 4); break;
@@ -450,23 +448,19 @@ static void piix_set_udmamode (struct at
 	}
 
 	if (!(reg48 & u_flag))
-		pci_write_config_word(dev, 0x48, reg48|u_flag);
+		pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 	if (speed == XFER_UDMA_5) {
 		pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
 	} else {
 		pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
-	if (!(reg4a & u_speed)) {
-		pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-		pci_write_config_word(dev, 0x4a, reg4a|u_speed);
-	}
+	if ((reg4a & a_speed) != u_speed)
+		pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
 	if (speed > XFER_UDMA_2) {
-		if (!(reg54 & v_flag)) {
-			pci_write_config_word(dev, 0x54, reg54|v_flag);
-		}
-	} else {
-		pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
-	}
+		if (!(reg54 & v_flag))
+			pci_write_config_byte(dev, 0x54, reg54 | v_flag);
+	} else
+		pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 }
 
 /* move to PCI layer, integrate w/ MSI stuff */

_

