From: akpm@osdl.org
Subject: [patch 12/12] libata: use correct map_db values for ICH8
Date: Fri, 20 Oct 2006 14:39:45 -0700
Message-ID: <200610202139.k9KLdj4i003597@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:34947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422979AbWJTVka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, kristen.c.accardi@intel.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Use valid values for ICH8 map_db.  With the old values, when the controller
was in Native mode, and SCC was 1 (drives configured for IDE), any drive
plugged into a slave port was not recognized.  For Combined Mode (and SCC
is still 1), 2 is a value value for MAP.map_value, and needs to be
recognized.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/ata_piix.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ata/ata_piix.c~libata-use-correct-map_db-values-for-ich8 drivers/ata/ata_piix.c
--- a/drivers/ata/ata_piix.c~libata-use-correct-map_db-values-for-ich8
+++ a/drivers/ata/ata_piix.c
@@ -427,9 +427,9 @@ static const struct piix_map_db ich8_map
 	.port_enable = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  NA,  P1,  NA }, /* 00b (hardwired) */
+		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
 		{  RV,  RV,  RV,  RV },
-		{  RV,  RV,  RV,  RV }, /* 10b (never) */
+		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
 		{  RV,  RV,  RV,  RV },
 	},
 };
_
