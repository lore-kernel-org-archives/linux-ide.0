From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Thu, 24 May 2007 01:31:31 +0200
Message-ID: <200705240131.32021.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755898AbXEWXbv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 19:31:51 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, alan@lxorguk.ukuu.org.uk, jeff@garzik.org
Cc: linux-ide@vger.kernel.org

The sata_sis driver supports SATA and PATA ports. The broken support
of both types in one controller is fixed.

the pata133 sis controllers does not support a drive present status
in the pci configspace like the older sis controllers, check removed.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/sata_sis.c	2007-05-22 11:05:38.000000000 +0200
+++ b/drivers/ata/sata_sis.c	2007-05-23 00:24:28.000000000 +0200
@@ -255,7 +255,7 @@
 {
 	static int printed_version;
 	struct ata_port_info pi = sis_port_info;
-	const struct ata_port_info *ppi[] = { &pi, NULL };
+	const struct ata_port_info *ppi[] = { &pi, &pi };
 	struct ata_host *host;
 	u32 genctl, val;
 	u8 pmr;
--- a/drivers/ata/pata_sis.c	2007-05-22 11:05:38.000000000 +0200
+++ b/drivers/ata/pata_sis.c	2007-05-23 23:10:33.000000000 +0200
@@ -154,6 +154,19 @@
 
 
 /**
+ *	sis_133_error_handler - Probe specified port on PATA host controller
+ *	@ap: Port to probe
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void sis_133_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL, ata_std_postreset);
+}
+
+/**
  *	sis_error_handler - Probe specified port on PATA host controller
  *	@ap: Port to probe
  *
@@ -540,7 +553,7 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_error_handler,
+	.error_handler		= sis_133_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= sis_133_cable_detect,
 

