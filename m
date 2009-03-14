From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 63/73] sata_nv: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:22:11 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142022060.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59971 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756744AbZCNTWN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:22:13 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZQx-000FmU-6S
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:22:11 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_nv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f65b537..2f523f8 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -57,9 +57,9 @@ enum {
 	NV_MMIO_BAR			=3D 5,
=20
 	NV_PORTS			=3D 2,
-	NV_PIO_MASK			=3D 0x1f,
-	NV_MWDMA_MASK			=3D 0x07,
-	NV_UDMA_MASK			=3D 0x7f,
+	NV_PIO_MASK			=3D ATA_PIO4,
+	NV_MWDMA_MASK			=3D ATA_MWDMA2,
+	NV_UDMA_MASK			=3D ATA_UDMA6,
 	NV_PORT0_SCR_REG_OFFSET		=3D 0x00,
 	NV_PORT1_SCR_REG_OFFSET		=3D 0x40,
=20
--=20
1.5.6.3

