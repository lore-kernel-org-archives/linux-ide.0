From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/4] pata_cmd64x: turn string of *if* statements into *switch*
Date: Sun, 11 Mar 2012 22:23:06 +0300
Message-ID: <201203112223.06954.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:41837 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753580Ab2CKSXy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 14:23:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Convert string of the *if* statements all checking 'pdev->revision' into more
natural *switch* statement. While at it, somewhat clarify the comments there...

Increment the driver version, accounting for the patches that neglected to do
this in the past.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ata/pata_cmd64x.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/ata/pata_cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd64x.c
+++ linux-2.6/drivers/ata/pata_cmd64x.c
@@ -32,7 +32,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.5"
+#define DRV_VERSION "0.2.15"
 
 /*
  * CMD64x specific registers definition.
@@ -368,21 +368,27 @@ static int cmd64x_init_one(struct pci_de
 	if (id->driver_data == 0)	/* 643 */
 		ata_pci_bmdma_clear_simplex(pdev);
 
-	if (pdev->device == PCI_DEVICE_ID_CMD_646) {
-		/* Does UDMA work ? */
-		if (pdev->revision > 4) {
+	if (pdev->device == PCI_DEVICE_ID_CMD_646)
+		switch (pdev->revision) {
+		/* UDMA works since rev 5 */
+		default:
 			ppi[0] = &cmd_info[2];
 			ppi[1] = &cmd_info[2];
-		}
-		/* Early rev with other problems ? */
-		else if (pdev->revision == 1) {
+			break;
+		case 3:
+		case 4:
+			break;
+		/* Rev 1 with other problems? */
+		case 1:
 			ppi[0] = &cmd_info[3];
 			ppi[1] = &cmd_info[3];
-		}
-		/* revs 1,2 have no CNTRL_CH0 */
-		if (pdev->revision < 3)
+			/* FALL THRU */
+		/* Early revs have no CNTRL_CH0 */
+		case 2:
+		case 0:
 			cntrl_ch0_ok = 0;
-	}
+			break;
+		}
 
 	cmd64x_fixup(pdev);
 
