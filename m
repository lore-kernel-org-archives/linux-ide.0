From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 73/73] sata_vsc: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:24:20 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142024080.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60375 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbZCNTYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:24:22 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZT2-000FoS-7T
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:24:20 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_vsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index c57cdff..ef211f3 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -345,8 +345,8 @@ static int __devinit vsc_sata_init_one(struct pci_d=
ev *pdev,
 	static const struct ata_port_info pi =3D {
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &vsc_sata_ops,
 	};
--=20
1.5.6.3
