From: "eyck" <eyck@ghost.anime.pl>
Subject: [PATCH] 2.4.x sata_promis pci_ids update
Date: Fri, 28 Apr 2006 16:32:19 +0200
Message-ID: <20060428143219.GD24713@ghost.anime.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ghost.anime.pl ([195.242.124.71]:62606 "EHLO srv.nn")
	by vger.kernel.org with ESMTP id S965208AbWD1OcY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Apr 2006 10:32:24 -0400
Received: from localhost ([127.0.0.1] ident=eyck)
	by srv.nn with esmtp (Exim 4.50)
	id 1FZU17-0005O0-HQ
	for linux-ide@vger.kernel.org; Fri, 28 Apr 2006 16:32:21 +0200
Received: from srv.nn ([127.0.0.1])
	by localhost (srv [81.219.64.71]) (amavisd-new, port 20024)
	with ESMTP id 16356-08 for <linux-ide@vger.kernel.org>;
	Fri, 28 Apr 2006 16:32:21 +0200 (CEST)
Received: from ghost.nn ([10.1.0.30] helo=desktop.nn)
	by srv.nn with smtp (Exim 4.50)
	id 1FZU15-0005Nt-Vb
	for linux-ide@vger.kernel.org; Fri, 28 Apr 2006 16:32:21 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Hi, 
 this little update (taken from 2.6) makes 2.4.32 recognize 'newer' promis
controllers.
-- 
Key fingerprint = 40D0 9FFB 9939 7320 8294  05E0 BCC7 02C4 75CC 50D9
 Total Existance Failure

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="012-promis.pci.ids.103.diff"

diff -ruN linux-2.4.32.orig/drivers/scsi/sata_promise.c linux-2.4.32/drivers/scsi/sata_promise.c
--- linux-2.4.32.orig/drivers/scsi/sata_promise.c	2005-11-16 20:12:54.000000000 +0100
+++ linux-2.4.32/drivers/scsi/sata_promise.c	2006-04-25 19:46:35.000000000 +0200
@@ -42,6 +42,7 @@
 #define DRV_NAME	"sata_promise"
 #define DRV_VERSION	"1.01"
 
+// pci device id list from 1.03
 
 enum {
 	PDC_PKT_SUBMIT		= 0x40, /* Command packet pointer addr */
@@ -161,9 +162,12 @@
 	},
 };
 
-static struct pci_device_id pdc_ata_pci_tbl[] = {
+
+static const struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -176,11 +180,17 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 
@@ -190,3 +200,3 @@
 	{ }	/* terminate list */
 };
 


--oyUTqETQ0mS9luUI--
