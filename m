From: Brian King <brking@us.ibm.com>
Subject: [PATCH 1/3] libata: ata_scsi_queuecmd cleanup
Date: Thu, 23 Mar 2006 17:30:02 -0600
Message-ID: <200603232330.k2NNU2lk011211@d01av03.pok.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60590 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932558AbWCWXaQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 18:30:16 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2NNUAjP032238
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:10 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2NNU321219878
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:03 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2NNU3Ma011218
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:30:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Encapsulate part of ata_scsi_queuecmd so that it can be
reused by future SAS patches.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-scsi.c |   32 ++++++++++++++------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff -puN drivers/scsi/libata-scsi.c~libata_scsi_queuecmd drivers/scsi/libata-scsi.c
--- libata-dev/drivers/scsi/libata-scsi.c~libata_scsi_queuecmd	2006-03-23 11:00:29.000000000 -0600
+++ libata-dev-bjking1/drivers/scsi/libata-scsi.c	2006-03-23 11:00:29.000000000 -0600
@@ -2597,6 +2597,21 @@ static inline void ata_scsi_dump_cdb(str
 #endif
 }
 
+static inline void __ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
+				       struct ata_port *ap, struct ata_device *dev)
+{
+	if (dev->class == ATA_DEV_ATA) {
+		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
+							      cmd->cmnd[0]);
+
+		if (xlat_func)
+			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
+		else
+			ata_scsi_simulate(ap, dev, cmd, done);
+	} else
+		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+}
+
 /**
  *	ata_scsi_queuecmd - Issue SCSI cdb to libata-managed device
  *	@cmd: SCSI command to be sent
@@ -2631,24 +2646,13 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	ata_scsi_dump_cdb(ap, cmd);
 
 	dev = ata_scsi_find_dev(ap, scsidev);
-	if (unlikely(!dev)) {
+	if (likely(dev))
+		__ata_scsi_queuecmd(cmd, done, ap, dev);
+	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
-		goto out_unlock;
 	}
 
-	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      cmd->cmnd[0]);
-
-		if (xlat_func)
-			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
-		else
-			ata_scsi_simulate(ap, dev, cmd, done);
-	} else
-		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
-
-out_unlock:
 	spin_unlock(&ap->host_set->lock);
 	spin_lock(shost->host_lock);
 	return 0;
_
