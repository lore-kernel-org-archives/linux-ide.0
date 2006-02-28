From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] ata_piix: don't scan non-existent device
Date: Wed, 1 Mar 2006 01:25:39 +0900
Message-ID: <11411439392891-git-send-email-htejun@gmail.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:3826 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932092AbWB1QZ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:57 -0500
Received: by wproxy.gmail.com with SMTP id 71so1133113wri
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:56 -0800 (PST)
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_std_softreset() sometimes reports presence of dev 1 even when it
doesn't exist (PCS-wise).  This usually happens reading dev 1's
signature returns that of dev 0 (e.g. on ICH6M).  This patch turns off
non-existent device on such cases.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

cda8686b4ad82a9272748af4388d47475c6acb2b
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 72e38e6..625db11 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -566,14 +566,31 @@ static unsigned int piix_sata_probe (str
  */
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
-	if (!piix_sata_probe(ap)) {
+	unsigned int mask;
+	int i, rc;
+
+	mask = piix_sata_probe(ap);
+	if (!mask) {
 		printk(KERN_INFO "ata%u: SATA port has no device.\n", ap->id);
 		return 0;
 	}
 
-	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     ata_std_softreset, NULL,
-				     ata_std_postreset, classes);
+	rc = ata_drive_probe_reset(ap, ata_std_probeinit,
+				   ata_std_softreset, NULL,
+				   ata_std_postreset, classes);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < 2; i++) {
+		if (ata_class_present(classes[i]) && !(mask & (1 << i))) {
+			printk(KERN_WARNING "ata%u: dev %u class %d for "
+			       "non-existent device, fixing up\n",
+			       ap->id, i, classes[i]);
+			classes[i] = ATA_DEV_NONE;
+		}
+	}
+
+	return 0;
 }
 
 /**
-- 
1.2.1


