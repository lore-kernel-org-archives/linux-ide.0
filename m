From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 46/73] pata_radisys: use ata.h mode mask defines, add
 ATA_UDMA24_ONLY
Date: Sat, 14 Mar 2009 20:19:45 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142019350.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62576 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617AbZCNTTr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:19:47 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZOb-000FgV-60
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:19:45 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_radisys.c |    6 +++---
 include/linux/ata.h        |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 695d44a..1956d5c 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -216,9 +216,9 @@ static int radisys_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma1-2 */
-		.udma_mask	=3D 0x14, /* UDMA33/66 only */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2, /* mwdma1-2 */
+		.udma_mask	=3D ATA_UDMA24_ONLY,
 		.port_ops	=3D &radisys_pata_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 386eeac..e06d4c1 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -133,6 +133,8 @@ enum {
 	ATA_UDMA7		=3D ATA_UDMA6 | (1 << 7),
 	/* ATA_UDMA7 is just for completeness... doesn't exist (yet?).  */
=20
+	ATA_UDMA24_ONLY		=3D (1 << 2) | (1 << 4),
+
 	ATA_UDMA_MASK_40C	=3D ATA_UDMA2,	/* udma0-2 */
=20
 	/* DMA-related */
--=20
1.5.6.3

