From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.20) pata_oldpiix: fix PIO2 underclocking
Date: Mon, 5 Feb 2007 19:45:38 +0300
Message-ID: <200702051945.38972.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15985 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751724AbXBEQpt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 11:45:49 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
fast timing bank starting with PIO2, just like the ata_piix driver does.
Also, fix/rephrase some comments while at it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ata/pata_oldpiix.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/ata/pata_oldpiix.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_oldpiix.c
+++ linux-2.6/drivers/ata/pata_oldpiix.c
@@ -25,7 +25,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_oldpiix"
-#define DRV_VERSION	"0.5.2"
+#define DRV_VERSION	"0.5.3"
 
 /**
  *	oldpiix_pre_reset		-	probe begin
@@ -94,19 +94,21 @@ static void oldpiix_set_piomode (struct 
 			    { 2, 1 },
 			    { 2, 3 }, };
 
-	if (pio > 2)
-		control |= 1;	/* TIME1 enable */
+	if (pio > 1)
+		control |= 1;	/* TIME */
 	if (ata_pio_need_iordy(adev))
-		control |= 2;	/* IE IORDY */
+		control |= 2;	/* IE */
 
-	/* Intel specifies that the PPE functionality is for disk only */
+	/* Intel specifies that the prefetch/posting is for disk only */
 	if (adev->class == ATA_DEV_ATA)
-		control |= 4;	/* PPE enable */
+		control |= 4;	/* PPE */
 
 	pci_read_config_word(dev, idetm_port, &idetm_data);
 
-	/* Enable PPE, IE and TIME as appropriate. Clear the other
-	   drive timing bits */
+	/*
+	 * Set PPE, IE and TIME as appropriate.
+	 * Clear the other drive's timing bits.
+	 */
 	if (adev->devno == 0) {
 		idetm_data &= 0xCCE0;
 		idetm_data |= control;

