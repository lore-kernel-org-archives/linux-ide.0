From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_efar: fix PIO2 underclocking
Date: Mon, 1 Jun 2009 22:42:10 +0300
Message-ID: <200906012342.10374.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58774 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751998AbZFATkz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jun 2009 15:40:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
fast timing bank starting with PIO2, just like the PIIX/ICH drivers do.
Also, fix/rephrase some comments while at it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Overlooked this while fixing pata_oldpiix/pata_mpiix 2 years ago...

 drivers/ata/pata_efar.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/ata/pata_efar.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_efar.c
+++ linux-2.6/drivers/ata/pata_efar.c
@@ -22,7 +22,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_efar"
-#define DRV_VERSION	"0.4.4"
+#define DRV_VERSION	"0.4.5"
 
 /**
  *	efar_pre_reset	-	Enable bits
@@ -98,18 +98,17 @@ static void efar_set_piomode (struct ata
 			    { 2, 1 },
 			    { 2, 3 }, };
 
-	if (pio > 2)
-		control |= 1;	/* TIME1 enable */
+	if (pio > 1)
+		control |= 1;	/* TIME */
 	if (ata_pio_need_iordy(adev))	/* PIO 3/4 require IORDY */
-		control |= 2;	/* IE enable */
-	/* Intel specifies that the PPE functionality is for disk only */
+		control |= 2;	/* IE */
+	/* Intel specifies that the prefetch/posting is for disk only */
 	if (adev->class == ATA_DEV_ATA)
-		control |= 4;	/* PPE enable */
+		control |= 4;	/* PPE */
 
 	pci_read_config_word(dev, idetm_port, &idetm_data);
 
-	/* Enable PPE, IE and TIME as appropriate */
-
+	/* Set PPE, IE, and TIME as appropriate */
 	if (adev->devno == 0) {
 		idetm_data &= 0xCCF0;
 		idetm_data |= control;
@@ -129,7 +128,7 @@ static void efar_set_piomode (struct ata
 		pci_write_config_byte(dev, 0x44, slave_data);
 	}
 
-	idetm_data |= 0x4000;	/* Ensure SITRE is enabled */
+	idetm_data |= 0x4000;	/* Ensure SITRE is set */
 	pci_write_config_word(dev, idetm_port, idetm_data);
 }
 

