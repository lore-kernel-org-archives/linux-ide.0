From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Comments - using the qc_defer hook for serializing controllers ?
Date: Wed, 5 Dec 2007 15:26:58 +0000
Message-ID: <20071205152658.563466b7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53183 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754309AbXLEPb3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 10:31:29 -0500
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.1/8.13.8) with ESMTP id lB5FQwZU005250
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 15:26:58 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc3-mm2/drivers/ata/pata_sl82c105.c linux-2.6.24-rc3-mm2/drivers/ata/pata_sl82c105.c
--- linux.vanilla-2.6.24-rc3-mm2/drivers/ata/pata_sl82c105.c	2007-11-30 17:43:24.000000000 +0000
+++ linux-2.6.24-rc3-mm2/drivers/ata/pata_sl82c105.c	2007-12-05 15:14:42.437347728 +0000
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sl82c105"
-#define DRV_VERSION "0.3.2"
+#define DRV_VERSION "0.3.3"
 
 enum {
 	/*
@@ -206,6 +206,37 @@
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
+	int rc;
+
+	/* First apply the usual rules */	
+	rc = ata_std_qc_defer(qc);
+	if (rc != 0)
+		return rc;
+
+	/* Now apply serialization rules. Only allow a command if the
+	   other channel state machine is idle */
+	if (host->port[0] != qc->ap && 
+			host->port[0]->hsm_task_state != HSM_ST_IDLE)
+		return	ATA_DEFER_PORT;
+	if (host->port[1] != qc->ap && 
+			host->port[1]->hsm_task_state != HSM_ST_IDLE)
+		return	ATA_DEFER_PORT;
+	return 0;
+}
+
 static struct scsi_host_template sl82c105_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -245,6 +276,7 @@
 	.bmdma_stop	= sl82c105_bmdma_stop,
 	.bmdma_status 	= ata_bmdma_status,
 
+	.qc_defer	= sl82c105_qc_defer,
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
 
@@ -312,7 +344,7 @@
 	};
 	/* for now use only the first port */
 	const struct ata_port_info *ppi[] = { &info_early,
-					       &ata_dummy_port_info };
+					       NULL };
 	u32 val;
 	int rev;
 
