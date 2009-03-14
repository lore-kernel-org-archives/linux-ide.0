From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 72/73] sata_via: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:24:06 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142024010.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60342 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756581AbZCNTYJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:24:09 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZSo-000FoA-OJ
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:24:06 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_via.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 5c62da9..98e8c50 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -146,24 +146,24 @@ static struct ata_port_operations vt8251_ops =3D =
{
=20
 static const struct ata_port_info vt6420_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x07,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt6420_sata_ops,
 };
=20
 static struct ata_port_info vt6421_sport_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x07,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt6421_sata_ops,
 };
=20
 static struct ata_port_info vt6421_pport_info =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0,
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt6421_pata_ops,
 };
@@ -171,8 +171,8 @@ static struct ata_port_info vt6421_pport_info =3D {
 static struct ata_port_info vt8251_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_SLAVE_POSS |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x07,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt8251_ops,
 };
--=20
1.5.6.3

