From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/7] libata: add 5s sleep between resets
Date: Sun, 2 Apr 2006 17:54:46 +0900
Message-ID: <11439680861847-git-send-email-htejun@gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:17521 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932187AbWDBIyw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:52 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438215nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:51 -0800 (PST)
In-Reply-To: <11439680863256-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Some devices react badly if resets are performed back-to-back.  Give
devices some time to breath and tell user that we're taking a nap.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

648928e9d46f4d2d8426d83614c101c4a41d789e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f8ee314..dfa2b36 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2577,6 +2577,9 @@ int ata_drive_probe_reset(struct ata_por
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
+		printk(KERN_INFO "ata%u: softreset failed, will try "
+		       "hardreset in 5 secs\n", ap->id);
+		ssleep(5);
 	}
 
 	if (!hardreset)
@@ -2592,10 +2595,20 @@ int ata_drive_probe_reset(struct ata_por
 
 		if (ata_down_sata_spd_limit(ap))
 			goto done;
+
+		printk(KERN_INFO "ata%u: hardreset failed, will retry "
+		       "in 5 secs\n", ap->id);
+		ssleep(5);
 	}
 
-	if (softreset)
+	if (softreset) {
+		printk(KERN_INFO "ata%u: hardreset succeeded without "
+		       "classification, will retry softreset in 5 secs",
+		       ap->id);
+		ssleep(5);
+
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
+	}
 
  done:
 	if (rc == 0 && classes[0] == ATA_DEV_UNKNOWN)
-- 
1.2.4


