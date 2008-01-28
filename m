From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sl82c105: dual channel support
Date: Mon, 28 Jan 2008 16:08:23 +0000
Message-ID: <20080128160823.4c9f2783@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42049 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752765AbYA1QM2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 11:12:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

Use qc_defer to serialize the two channels

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24/drivers/ata/pata_sl82c105.c linux-2.6.24/drivers/ata/pata_sl82c105.c
--- linux.vanilla-2.6.24/drivers/ata/pata_sl82c105.c	2008-01-24 22:58:37.000000000 +0000
+++ linux-2.6.24/drivers/ata/pata_sl82c105.c	2008-01-28 15:44:11.000000000 +0000
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sl82c105"
-#define DRV_VERSION "0.3.2"
+#define DRV_VERSION "0.3.3"
 
 enum {
 	/*
@@ -206,6 +206,34 @@
 	sl82c105_set_piomode(ap, qc->dev);
 }
 
+/**
+ *	sl82c105_qc_defer	-	implement serialization
+ *	@qc: command
+ *
+ *	We must issue one command per host not per channel because
+ *	of the reset bug.
+ *
+ *	Q: is the scsi host lock sufficient ?
+ */
+
+static int sl82c105_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_host *host = qc->ap->host;
+	struct ata_port *alt = host->ports[1 ^ qc->ap->port_no];
+	int rc;
+
+	/* First apply the usual rules */	
+	rc = ata_std_qc_defer(qc);
+	if (rc != 0)
+		return rc;
+
+	/* Now apply serialization rules. Only allow a command if the
+	   other channel state machine is idle */
+	if (alt && alt->qc_active)
+		return	ATA_DEFER_PORT;
+	return 0;
+}
+
 static struct scsi_host_template sl82c105_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -245,6 +273,7 @@
 	.bmdma_stop	= sl82c105_bmdma_stop,
 	.bmdma_status 	= ata_bmdma_status,
 
+	.qc_defer	= sl82c105_qc_defer,
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
 
@@ -312,7 +341,7 @@
 	};
 	/* for now use only the first port */
 	const struct ata_port_info *ppi[] = { &info_early,
-					       &ata_dummy_port_info };
+					       NULL };
 	u32 val;
 	int rev;
 
