From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 10/73] pata_at32: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:12:13 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142012030.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60925 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbZCNTMP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:12:15 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZHJ-000FYF-1Y
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:12:13 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_at32.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index ab61095..131b20c 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -58,16 +58,18 @@
  * ATA PIO modes
  *
  *	Name	| Mb/s	| Min cycle time | Mask
- *	--------+-------+----------------+--------
- *	Mode 0	| 3.3	| 600 ns	 | 0x01
- *	Mode 1	| 5.2	| 383 ns	 | 0x03
- *	Mode 2	| 8.3	| 240 ns	 | 0x07
- *	Mode 3	| 11.1	| 180 ns	 | 0x0f
- *	Mode 4	| 16.7	| 120 ns	 | 0x1f
+ *	--------+-------+----------------+----------
+ *	Mode 0	| 3.3	| 600 ns	 | ATA_PIO0
+ *	Mode 1	| 5.2	| 383 ns	 | ATA_PIO1
+ *	Mode 2	| 8.3	| 240 ns	 | ATA_PIO2
+ *	Mode 3	| 11.1	| 180 ns	 | ATA_PIO3
+ *	Mode 4	| 16.7	| 120 ns	 | ATA_PIO4
  *
  * Alter PIO_MASK below according to table to set maximal PIO mode.
  */
-#define PIO_MASK (0x1f)
+enum {
+  PIO_MASK =3D ATA_PIO4,
+};
=20
 /*
  * Struct containing private information about device.
--=20
1.5.6.3

