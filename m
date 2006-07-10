From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Fixes for PIIX driver
Date: Mon, 10 Jul 2006 17:54:29 +0100
Message-ID: <1152550469.27368.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16524 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422687AbWGJQhv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 12:37:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

A couple of cases were mishandled by the PIIX driver because of wrong
entries in tables. This caused some ICH chips to select UDMA33 not the
correct higher UDMA speed. It could also cause the original ICH to
select a mode the controller didn't support and then fail on boot. 

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/scsi/ata_piix.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

88d42653b87dcf9359c7a7874ce21031b71df117
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 3eb2c86..0f21940 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -93,7 +93,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"2.00ac5"
+#define DRV_VERSION	"2.00ac6"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -412,7 +412,7 @@ static struct ata_port_info piix_port_in
 		.host_flags	= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
 		.pio_mask 	= 0x1f,	/* pio 0-4 */
 		.mwdma_mask	= 0x06, /* Check: maybe 0x07  */
-		.udma_mask	= ATA_UDMA6, /* UDMA133 */
+		.udma_mask	= ATA_UDMA2, /* UDMA33 */
 		.port_ops	= &ich_pata_ops,
 	},
 	/* ich_pata_66: 2 	ICH controllers up to 66MHz */
@@ -431,8 +431,8 @@ static struct ata_port_info piix_port_in
 		.host_flags	= ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
-		.udma_mask	= 0x3f, /* udma0-5 */
-		.port_ops	= &piix_pata_ops,
+		.udma_mask	= ATA_UDMA5, /* udma0-5 */
+		.port_ops	= &ich_pata_ops,
 	},
 
 	/* ich_pata_133: 4 	ICH with full UDMA6 */
-- 
1.2.GIT


