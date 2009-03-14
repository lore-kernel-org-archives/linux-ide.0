From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 24/73] pata_hpt3x3: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:15:10 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142015020.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61556 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbZCNTPN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:15:13 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZKA-000FbX-UL
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:15:11 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_hpt3x3.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index f19cc64..7e31025 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -188,11 +188,11 @@ static int hpt3x3_init_one(struct pci_dev *pdev, =
const struct pci_device_id *id)
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 #if defined(CONFIG_PATA_HPT3X3_DMA)
 		/* Further debug needed */
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 #endif
 		.port_ops =3D &hpt3x3_port_ops
 	};
--=20
1.5.6.3

