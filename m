From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/10] sata_sil24: separate out sil24_do_softreset()
Date: Fri, 12 May 2006 01:43:43 +0900
Message-ID: <1147365823906-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:21914 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030348AbWEKQnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:55 -0400
Received: by wr-out-0506.google.com with SMTP id i12so408534wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:55 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sil24_do_softreset() which takes @pmp as its last
argument.  This will be used to implement sil24_pm_softreset().

---

 drivers/scsi/sata_sil24.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

201f4cac006ca715aafa794a2f7020cbc40086ca
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 34f2e67..75b04e2 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -562,7 +562,8 @@ static int sil24_exec_polled_cmd(struct 
 	return rc;
 }
 
-static int sil24_softreset(struct ata_link *link, unsigned int *class)
+static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
+			      int pmp)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_taskfile tf;
@@ -585,7 +586,7 @@ static int sil24_softreset(struct ata_li
 
 	/* do SRST */
 	ata_tf_init(link->device, &tf);	/* doesn't really matter */
-	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, 0, 0,
+	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, pmp, 0,
 				   ATA_TMOUT_BOOT / HZ * 1000);
 	if (rc == -EBUSY) {
 		reason = "timeout";
@@ -610,6 +611,11 @@ static int sil24_softreset(struct ata_li
 	return -EIO;
 }
 
+static int sil24_softreset(struct ata_link *link, unsigned int *class)
+{
+	return sil24_do_softreset(link, class, 0);
+}
+
 static int sil24_hardreset(struct ata_link *link, unsigned int *class)
 {
 	struct ata_port *ap = link->ap;
-- 
1.2.4


