From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/7] libata: use SATA speed down in ata_drive_probe_reset()
Date: Sun, 2 Apr 2006 17:54:46 +0900
Message-ID: <11439680862487-git-send-email-htejun@gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:54046 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbWDBIyw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:52 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438213nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:51 -0800 (PST)
In-Reply-To: <11439680863256-git-send-email-htejun@gmail.com>
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

 drivers/scsi/libata-core.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

9281b880f7c1b2c88373eee9b5e33f5909714124
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 39afae1..f8ee314 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2573,7 +2573,7 @@ int ata_drive_probe_reset(struct ata_por
 	if (probeinit)
 		probeinit(ap);
 
-	if (softreset) {
+	if (softreset && !ata_set_sata_spd_needed(ap)) {
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
@@ -2582,9 +2582,17 @@ int ata_drive_probe_reset(struct ata_por
 	if (!hardreset)
 		goto done;
 
-	rc = ata_do_reset(ap, hardreset, postreset, 0, classes);
-	if (rc || classes[0] != ATA_DEV_UNKNOWN)
-		goto done;
+	while (1) {
+		rc = ata_do_reset(ap, hardreset, postreset, 0, classes);
+		if (rc == 0) {
+			if (classes[0] != ATA_DEV_UNKNOWN)
+				goto done;
+			break;
+		}
+
+		if (ata_down_sata_spd_limit(ap))
+			goto done;
+	}
 
 	if (softreset)
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
-- 
1.2.4


