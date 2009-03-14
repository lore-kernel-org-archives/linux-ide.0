From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 68/73] sata_sis: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:22:52 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142022470.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60067 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937AbZCNTWy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:22:54 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZRc-000FnX-AC
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:22:52 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_sis.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9c43b4e..8f98332 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -97,8 +97,8 @@ static struct ata_port_operations sis_ops =3D {
=20
 static const struct ata_port_info sis_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x7,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &sis_ops,
 };
--=20
1.5.6.3

