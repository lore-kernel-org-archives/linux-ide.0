From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.24-rc1 2/2] sata_promise: cleanups
Date: Tue, 30 Oct 2007 14:21:55 +0100 (MET)
Message-ID: <200710301321.l9UDLtA0028178@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:60108 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbXJ3NWE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:22:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Minor sata_promise cleanups:
- use C99 array initialisers in pdc_port_info[]
- add myself in the file head's Maintained by note,
  since users don't always read the MAINTAINERS file
- SG/PRD bug workaround warrants driver version bump

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
--
 drivers/ata/sata_promise.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff -rupN linux-2.6.24-rc1/drivers/ata/sata_promise.c linux-2.6.24-rc1.sata_promise-cleanups/drivers/ata/sata_promise.c
--- linux-2.6.24-rc1/drivers/ata/sata_promise.c	2007-10-30 13:55:05.000000000 +0100
+++ linux-2.6.24-rc1.sata_promise-cleanups/drivers/ata/sata_promise.c	2007-10-30 13:54:56.000000000 +0100
@@ -2,6 +2,7 @@
  *  sata_promise.c - Promise SATA
  *
  *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *		    Mikael Pettersson <mikpe@it.uu.se>
  *  		    Please ALWAYS copy linux-ide@vger.kernel.org
  *		    on emails.
  *
@@ -45,7 +46,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.10"
+#define DRV_VERSION	"2.11"
 
 enum {
 	PDC_MAX_PORTS		= 4,
@@ -239,7 +240,7 @@ static const struct ata_port_operations 
 };
 
 static const struct ata_port_info pdc_port_info[] = {
-	/* board_2037x */
+	[board_2037x] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_SATA_PATA,
@@ -249,7 +250,7 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_old_sata_ops,
 	},
 
-	/* board_2037x_pata */
+	[board_2037x_pata] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f, /* pio0-4 */
@@ -258,7 +259,7 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_pata_ops,
 	},
 
-	/* board_20319 */
+	[board_20319] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_4_PORTS,
@@ -268,7 +269,7 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_old_sata_ops,
 	},
 
-	/* board_20619 */
+	[board_20619] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
 				  PDC_FLAG_4_PORTS,
@@ -278,7 +279,7 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_pata_ops,
 	},
 
-	/* board_2057x */
+	[board_2057x] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_GEN_II | PDC_FLAG_SATA_PATA,
@@ -288,7 +289,7 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_sata_ops,
 	},
 
-	/* board_2057x_pata */
+	[board_2057x_pata] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
 				  PDC_FLAG_GEN_II,
@@ -298,7 +299,7 @@ static const struct ata_port_info pdc_po
 		.port_ops	= &pdc_pata_ops,
 	},
 
-	/* board_40518 */
+	[board_40518] =
 	{
 		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS,
