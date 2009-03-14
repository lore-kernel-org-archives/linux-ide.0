From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 33/73] pata_mpc52xx: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:17:19 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142016280.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61949 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928AbZCNTRW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:17:22 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZMF-000FdX-SM
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:17:19 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_mpc52xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 50ae6d1..68d27bc 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -737,10 +737,10 @@ mpc52xx_ata_probe(struct of_device *op, const str=
uct of_device_id *match)
 	 */
 	prop =3D of_get_property(op->node, "mwdma-mode", &proplen);
 	if ((prop) && (proplen >=3D 4))
-		mwdma_mask =3D 0x7 & ((1 << (*prop + 1)) - 1);
+		mwdma_mask =3D ATA_MWDMA2 & ((1 << (*prop + 1)) - 1);
 	prop =3D of_get_property(op->node, "udma-mode", &proplen);
 	if ((prop) && (proplen >=3D 4))
-		udma_mask =3D 0x7 & ((1 << (*prop + 1)) - 1);
+		udma_mask =3D ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
=20
 	ata_irq =3D irq_of_parse_and_map(op->node, 0);
 	if (ata_irq =3D=3D NO_IRQ) {
--=20
1.5.6.3

