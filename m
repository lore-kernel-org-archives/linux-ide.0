From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] Fix pata_pdc2027x incorrect pio_mask and mwdma_mask
Date: Wed, 27 Oct 2004 18:32:05 +0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <00e801c4bc10$387e33b0$8c764109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E5_01C4BC53.42755630"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:5108 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262373AbUJ0Kcz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 06:32:55 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_00E5_01C4BC53.42755630
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Jeff:

  Fix pata_pdc2027x incorrect pio_mask and mwdma_mask for your review.
(patch is against the libata-dev-2.6 tree.)

Albert

Signed-off-by: Albert Lee<albertcc@tw.ibm.com>
************************************************************
diff -Nru libata-dev-2.6/drivers/scsi/pata_pdc2027x.c
libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c
--- libata-dev-2.6/drivers/scsi/pata_pdc2027x.c 2004-10-27
16:10:54.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c 2004-10-27
17:55:38.000000000 +0800
@@ -162,9 +162,9 @@
   .sht  = &pdc2027x_sht,
   .host_flags = ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
                     ATA_FLAG_SRST,
-  .pio_mask = 0x03, /* pio3-4 */
-  .mwdma_mask = 0x06, /* mwdma1-2 */
-  .udma_mask = ATA_UDMA5,
+  .pio_mask = 0x1f, /* pio0-4 */
+  .mwdma_mask = 0x07, /* mwdma0-2 */
+  .udma_mask = ATA_UDMA5, /* udma0-5 */
   .port_ops = &pdc2027x_pata_ops,
  },
  /* PDC_UDMA_133 */
@@ -172,9 +172,9 @@
   .sht  = &pdc2027x_sht,
   .host_flags = ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
                            ATA_FLAG_SRST,
-  .pio_mask = 0x03, /* pio3-4 */
-  .mwdma_mask = 0x06, /* mwdma1-2 */
-  .udma_mask = ATA_UDMA6,
+  .pio_mask = 0x1f, /* pio0-4 */
+  .mwdma_mask = 0x07, /* mwdma0-2 */
+  .udma_mask = ATA_UDMA6, /* udma0-6 */
   .port_ops = &pdc2027x_pata_ops,
  },
 };


------=_NextPart_000_00E5_01C4BC53.42755630
Content-Type: application/octet-stream;
	name="patch-mode-mask"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-mode-mask"

diff -Nru libata-dev-2.6/drivers/scsi/pata_pdc2027x.c =
libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c=0A=
--- libata-dev-2.6/drivers/scsi/pata_pdc2027x.c	2004-10-27 =
16:10:54.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c	2004-10-27 =
17:55:38.000000000 +0800=0A=
@@ -162,9 +162,9 @@=0A=
 		.sht		=3D &pdc2027x_sht,=0A=
 		.host_flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | =0A=
 		                  ATA_FLAG_SRST,=0A=
-		.pio_mask	=3D 0x03, /* pio3-4 */=0A=
-		.mwdma_mask	=3D 0x06, /* mwdma1-2 */=0A=
-		.udma_mask	=3D ATA_UDMA5,=0A=
+		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
+		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
+		.udma_mask	=3D ATA_UDMA5, /* udma0-5 */=0A=
 		.port_ops	=3D &pdc2027x_pata_ops,=0A=
 	},=0A=
 	/* PDC_UDMA_133 */=0A=
@@ -172,9 +172,9 @@=0A=
 		.sht		=3D &pdc2027x_sht,=0A=
 		.host_flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | =0A=
                         	  ATA_FLAG_SRST,=0A=
-		.pio_mask	=3D 0x03, /* pio3-4 */=0A=
-		.mwdma_mask	=3D 0x06, /* mwdma1-2 */=0A=
-		.udma_mask	=3D ATA_UDMA6,=0A=
+		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
+		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
+		.udma_mask	=3D ATA_UDMA6, /* udma0-6 */=0A=
 		.port_ops	=3D &pdc2027x_pata_ops,=0A=
 	},=0A=
 };=0A=

------=_NextPart_000_00E5_01C4BC53.42755630--

