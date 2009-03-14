From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 35/73] pata_netcell: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:17:48 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142017400.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62011 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117AbZCNTRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:17:50 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZMi-000Fe2-BS
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:17:48 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_netcell.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 9dc05e1..bdb2369 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -51,8 +51,8 @@ static int netcell_init_one (struct pci_dev *pdev, co=
nst struct pci_device_id *e
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
 		/* Actually we don't really care about these as the
 		   firmware deals with it */
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA5, /* UDMA 133 */
 		.port_ops	=3D &netcell_ops,
 	};
--=20
1.5.6.3

