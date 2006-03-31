From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/15] libata: convert do_probe_reset() to ata_do_reset()
Date: Sat, 1 Apr 2006 01:38:17 +0900
Message-ID: <11438230973234-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:30179 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751409AbWCaQi0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:26 -0500
Received: by zproxy.gmail.com with SMTP id o37so955016nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:26 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make do_probe_reset() generic by pushing classification check into
ata_drive_probe_reset() and rename it to ata_do_reset().  This will be
used by EH reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

de677bcf0480fe1ca900f5156f48af2a639570c4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6a336ba..559abe4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2371,16 +2371,16 @@ int ata_std_probe_reset(struct ata_port 
 				     ata_std_postreset, classes);
 }
 
-static int do_probe_reset(struct ata_port *ap, ata_reset_fn_t reset,
-			  ata_postreset_fn_t postreset,
-			  unsigned int *classes)
+static int ata_do_reset(struct ata_port *ap,
+			ata_reset_fn_t reset, ata_postreset_fn_t postreset,
+			int verbose, unsigned int *classes)
 {
 	int i, rc;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		classes[i] = ATA_DEV_UNKNOWN;
 
-	rc = reset(ap, 0, classes);
+	rc = reset(ap, verbose, classes);
 	if (rc)
 		return rc;
 
@@ -2400,7 +2400,7 @@ static int do_probe_reset(struct ata_por
 	if (postreset)
 		postreset(ap, classes);
 
-	return classes[0] != ATA_DEV_UNKNOWN ? 0 : -ENODEV;
+	return 0;
 }
 
 /**
@@ -2445,21 +2445,24 @@ int ata_drive_probe_reset(struct ata_por
 		probeinit(ap);
 
 	if (softreset) {
-		rc = do_probe_reset(ap, softreset, postreset, classes);
-		if (rc == 0)
-			return 0;
+		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
+		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
+			goto done;
 	}
 
 	if (!hardreset)
-		return rc;
+		goto done;
 
-	rc = do_probe_reset(ap, hardreset, postreset, classes);
-	if (rc == 0 || rc != -ENODEV)
-		return rc;
+	rc = ata_do_reset(ap, hardreset, postreset, 0, classes);
+	if (rc || classes[0] != ATA_DEV_UNKNOWN)
+		goto done;
 
 	if (softreset)
-		rc = do_probe_reset(ap, softreset, postreset, classes);
+		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
 
+ done:
+	if (rc == 0 && classes[0] == ATA_DEV_UNKNOWN)
+		rc = -ENODEV;
 	return rc;
 }
 
-- 
1.2.4


