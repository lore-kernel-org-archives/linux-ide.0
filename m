From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 47/73] pata_rb532_cf: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:19:53 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142019470.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62598 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755621AbZCNTTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:19:55 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZOj-000Fgr-5I
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:19:53 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_rb532_cf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index ebfcda2..8acb5db 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -145,7 +145,7 @@ static void rb532_pata_setup_ports(struct ata_host =
*ah)
 	ap =3D ah->ports[0];
=20
 	ap->ops		=3D &rb532_pata_port_ops;
-	ap->pio_mask	=3D 0x1f; /* PIO4 */
+	ap->pio_mask	=3D ATA_PIO4;
 	ap->flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
=20
 	ap->ioaddr.cmd_addr	=3D info->iobase + RB500_CF_REG_BASE;
--=20
1.5.6.3

