From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 31/73] pata_legacy: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:16:13 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142016070.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61767 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbZCNTQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:16:15 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZLB-000Fcn-2u
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:16:13 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_legacy.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index e3bc1b4..3f830f0 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -129,7 +129,7 @@ static int qdi;			/* Set to probe QDI controllers *=
/
 static int winbond;		/* Set to probe Winbond controllers,
 					give I/O port if non standard */
 static int autospeed;		/* Chip present which snoops speed changes */
-static int pio_mask =3D 0x1F;	/* PIO range for autospeed devices */
+static int pio_mask =3D ATA_PIO4;	/* PIO range for autospeed devices *=
/
 static int iordy_mask =3D 0xFFFFFFFF;	/* Use iordy if available */
=20
 /**
--=20
1.5.6.3

