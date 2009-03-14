From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 51/73] pata_sch: remove superfluous mode mask comments
Date: Sat, 14 Mar 2009 20:20:28 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142020220.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62698 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396AbZCNTUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:20:31 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZPI-000FiB-Kl
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:20:28 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_sch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index 6aeeeeb..99cceb4 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -84,9 +84,9 @@ static struct ata_port_operations sch_pata_ops =3D {
=20
 static struct ata_port_info sch_port_info =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D ATA_PIO4,   /* pio0-4 */
-	.mwdma_mask	=3D ATA_MWDMA2, /* mwdma0-2 */
-	.udma_mask	=3D ATA_UDMA5,  /* udma0-5 */
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
+	.udma_mask	=3D ATA_UDMA5,
 	.port_ops	=3D &sch_pata_ops,
 };
=20
--=20
1.5.6.3

