From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 21/22] libata: implement ATA printk helpers
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <11473487912421-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:33397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751578AbWEKMAG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:06 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170506nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:06 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_{port|dev}_printk() which prefixes the message with
proper identification string.  This change is necessary for later PM
support because devices and links should be identified differently
depending on how they are attached.

This also helps unifying device id strings.  Currently, there are two
forms in use (P is the port number D device number) - 'ataP(D):', and
'ataP: dev D '.  These macros also make it harder to forget proper ID
string (e.g. printing only port number when a device is in question).

Debug message handling can be integrated into these printk macros by
passing debug type and level via @lv.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

387b4ba08bdce6d729cf441e7c1173d9863f4c04
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bd8cd3b..7b54d92 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -650,7 +650,18 @@ extern void ata_eng_timeout(struct ata_p
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
+/*
+ * printk helpers
+ */
+#define ata_port_printk(ap, lv, fmt, args...) \
+	printk(lv"ata%u: "fmt, (ap)->id , ##args)
+
+#define ata_dev_printk(dev, lv, fmt, args...) \
+	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
 
+/*
+ * qc helpers
+ */
 static inline int
 ata_sg_is_last(struct scatterlist *sg, struct ata_queued_cmd *qc)
 {
-- 
1.2.4


