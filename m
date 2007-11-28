From: Chuck Ebbert <cebbert@redhat.com>
Subject: [stable patch] backport of "be tolerant of 12-byte ATAPI commands
 in 16-byte CDBs"
Date: Wed, 28 Nov 2007 18:36:07 -0500
Message-ID: <474DFB67.5070603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51663 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758286AbXK1XgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 18:36:08 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lASNa8OM001568
	for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 18:36:08 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lASNa8T9002943
	for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 18:36:08 -0500
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lASNa79Q005705
	for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 18:36:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Submitted for comment, not compile tested.


Backport of commit 607126c2a21cd6e9bb807fdd415c1a992f7b9009
libata-scsi: be tolerant of 12-byte ATAPI commands in 16-byte CDBs

---
 drivers/ata/libata-scsi.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

--- linux-2.6.23.noarch.orig/drivers/ata/libata-scsi.c
+++ linux-2.6.23.noarch/drivers/ata/libata-scsi.c
@@ -2747,16 +2747,15 @@ static inline int __ata_scsi_queuecmd(st
 				      struct ata_device *dev)
 {
 	int rc = 0;
+	u8 scsi_op = scmd->cmnd[0];
 
-	if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len)) {
-		DPRINTK("bad CDB len=%u, max=%u\n",
-			scmd->cmd_len, dev->cdb_len);
-		scmd->result = DID_ERROR << 16;
-		done(scmd);
-		return 0;
-	}
+	if (unlikely(!scmd->cmd_len))
+		goto bad_cdb_len;
 
 	if (dev->class == ATA_DEV_ATA) {
+		if (unlikely(scmd->cmd_len > dev->cdb_len))
+			goto bad_cdb_len;
+
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
 							      scmd->cmnd[0]);
 
@@ -2764,10 +2763,22 @@ static inline int __ata_scsi_queuecmd(st
 			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
 		else
 			ata_scsi_simulate(dev, scmd, done);
-	} else
+	} else {
+		int len = COMMAND_SIZE(scsi_op);
+		if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
+			goto bad_cdb_len;
+
 		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
+	}
 
 	return rc;
+
+ bad_cdb_len:
+	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
+		scmd->cmd_len, scsi_op, dev->cdb_len);
+	scmd->result = DID_ERROR << 16;
+	done(scmd);
+	return 0;
 }
 
 /**
