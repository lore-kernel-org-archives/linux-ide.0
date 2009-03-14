From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 43/73] pata_pdc2027x: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:19:11 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142019060.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62420 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741AbZCNTTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:19:13 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZO3-000Ffl-4C
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:19:11 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_pdc2027x.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index e94efcc..ca5cad0 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -152,18 +152,18 @@ static struct ata_port_info pdc2027x_port_info[] =
=3D {
 	{
 		.flags		=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
 		                  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5, /* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &pdc2027x_pata100_ops,
 	},
 	/* PDC_UDMA_133 */
 	{
 		.flags		=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
                         	  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA6, /* udma0-6 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc2027x_pata133_ops,
 	},
 };
--=20
1.5.6.3

