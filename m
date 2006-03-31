From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/15] libata: use SATA speeding down in ata_drive_probe_reset()
Date: Sat, 1 Apr 2006 01:38:19 +0900
Message-ID: <11438230992911-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:30179 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751414AbWCaQil (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:41 -0500
Received: by zproxy.gmail.com with SMTP id o37so955016nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:41 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_drive_probe_reset() use SATA SPD configuration.  Hardreset
will be force if speed renegotiation is necessary.  Also, if a
hardreset fails, PHY speed is stepped down and hardreset is retried
until the lowest speed is reached.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

c927e2f9d4688d9d34e7d1d5f7f2e34e86e93827
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 16095d8..30ee203 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2629,7 +2629,7 @@ int ata_drive_probe_reset(struct ata_por
 	if (probeinit)
 		probeinit(ap);
 
-	if (softreset) {
+	if (softreset && !ata_set_sata_spd_needed(ap, &ap->device[0])) {
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
@@ -2638,9 +2638,18 @@ int ata_drive_probe_reset(struct ata_por
 	if (!hardreset)
 		goto done;
 
-	rc = ata_do_reset(ap, hardreset, postreset, 0, classes);
-	if (rc || classes[0] != ATA_DEV_UNKNOWN)
-		goto done;
+	while (1) {
+		ata_set_sata_spd(ap, &ap->device[0]);
+		rc = ata_do_reset(ap, hardreset, postreset, 0, classes);
+		if (rc == 0) {
+			if (classes[0] != ATA_DEV_UNKNOWN)
+				goto done;
+			break;
+		}
+
+		if (ata_down_sata_spd_limit(ap, &ap->device[0]))
+			goto done;
+	}
 
 	if (softreset)
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
-- 
1.2.4


