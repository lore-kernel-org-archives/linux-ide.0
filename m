From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/03] sata_mv: replace 0x1f with ATA_PIO4 (v2)
Date: Mon, 06 Apr 2009 15:22:21 -0400
Message-ID: <49DA566D.9040501@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33159 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbZDFTWX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 15:22:23 -0400
In-Reply-To: <49DA2E76.7000800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>, =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>

Cosmetic change: replace .pio_mask=3D0x1f with .pio_mask=3DATA_PIO4 eve=
rywhere.
Originally from Erik Inge Bols=C3=B8, now reworked for latest sata_mv.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
Signed-off-by: Mark Lord <mlord@pobox.com>
---

Resending to try and fix spelling of Bols=C3=B8's name,
and also to copy him on the email.

--- old/drivers/ata/sata_mv.c	2009-04-06 12:06:20.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 12:23:32.000000000 -0400
@@ -694,49 +694,49 @@
 static const struct ata_port_info mv_port_info[] =3D {
 	{  /* chip_504x */
 		.flags		=3D MV_GEN_I_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv5_ops,
 	},
 	{  /* chip_508x */
 		.flags		=3D MV_GEN_I_FLAGS | MV_FLAG_DUAL_HC,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv5_ops,
 	},
 	{  /* chip_5080 */
 		.flags		=3D MV_GEN_I_FLAGS | MV_FLAG_DUAL_HC,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv5_ops,
 	},
 	{  /* chip_604x */
 		.flags		=3D MV_GEN_II_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv6_ops,
 	},
 	{  /* chip_608x */
 		.flags		=3D MV_GEN_II_FLAGS | MV_FLAG_DUAL_HC,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv6_ops,
 	},
 	{  /* chip_6042 */
 		.flags		=3D MV_GEN_IIE_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
 	{  /* chip_7042 */
 		.flags		=3D MV_GEN_IIE_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
 	{  /* chip_soc */
 		.flags		=3D MV_GEN_IIE_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
