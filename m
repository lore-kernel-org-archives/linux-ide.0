From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 59/73] pdc_adma: use ata.h mode mask defines, add
 ATA_PIO4_ONLY
Date: Sat, 14 Mar 2009 20:21:39 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142021290.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59849 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756328AbZCNTVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:21:41 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZQR-000FjX-0v
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:21:39 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pdc_adma.c |    2 +-
 include/linux/ata.h    |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index be53545..c509c20 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -166,7 +166,7 @@ static struct ata_port_info adma_port_info[] =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS |
 				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_POLLING,
-		.pio_mask	=3D 0x10, /* pio4 */
+		.pio_mask	=3D ATA_PIO4_ONLY,
 		.udma_mask	=3D ATA_UDMA4,
 		.port_ops	=3D &adma_ata_ops,
 	},
diff --git a/include/linux/ata.h b/include/linux/ata.h
index e06d4c1..3901b00 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -108,6 +108,8 @@ enum {
 	ATA_PIO5		=3D ATA_PIO4 | (1 << 5),
 	ATA_PIO6		=3D ATA_PIO5 | (1 << 6),
=20
+	ATA_PIO4_ONLY		=3D (1 << 4),
+
 	ATA_SWDMA0		=3D (1 << 0),
 	ATA_SWDMA1		=3D ATA_SWDMA0 | (1 << 1),
 	ATA_SWDMA2		=3D ATA_SWDMA1 | (1 << 2),
--=20
1.5.6.3

