From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_serverworks: Fix cable types and cosmetics
Date: Sat, 19 Jan 2008 15:52:56 +0000
Message-ID: <20080119155256.37a67fea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34205 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759343AbYASPyu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 10:54:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Minor tidying up. Only real change is to return UNK not 80 wire when we
don't know the cable type. This didn't use to matter but with Tejun's
reworking of cable detection it may.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_serverworks.c linux-2.6.24-rc8-mm1/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_serverworks.c	2008-01-19 14:22:32.000000000 +0000
+++ linux-2.6.24-rc8-mm1/drivers/ata/pata_serverworks.c	2008-01-19 14:58:01.000000000 +0000
@@ -41,7 +41,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_serverworks"
-#define DRV_VERSION "0.4.2"
+#define DRV_VERSION "0.4.3"
 
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
@@ -102,7 +102,7 @@
 }
 
 /**
- *	csb4_cable	-	CSB5/6 cable detect
+ *	csb_cable	-	CSB5/6 cable detect
  *	@ap: ATA port to check
  *
  *	Serverworks default arrangement is to use the drive side detection
@@ -110,7 +110,7 @@
  */
 
 static int csb_cable(struct ata_port *ap) {
-	return ATA_CBL_PATA80;
+	return ATA_CBL_PATA_UNK;
 }
 
 struct sv_cable_table {
@@ -231,7 +231,6 @@
 	return ata_pci_default_filter(adev, mask);
 }
 
-
 /**
  *	serverworks_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -243,7 +242,7 @@
 static void serverworks_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	static const u8 pio_mode[] = { 0x5d, 0x47, 0x34, 0x22, 0x20 };
-	int offset = 1 + (2 * ap->port_no) - adev->devno;
+	int offset = 1 + 2 * ap->port_no - adev->devno;
 	int devbits = (2 * ap->port_no + adev->devno) * 4;
 	u16 csb5_pio;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
