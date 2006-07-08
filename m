From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] sata_sil24: separate out sil24_do_softreset()
Date: Sat, 8 Jul 2006 14:58:08 +0900
Message-ID: <1152338288884-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.197]:48889 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964811AbWGHF5V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:21 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206446wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:20 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sil24_do_softreset() which takes @pmp as its last
argument.  This will be used to implement sil24_pmp_softreset().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

fcd3110e005d4db89e0e0df4eb10230dafbf708d
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 0ee8d45..7c868f6 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -588,7 +588,8 @@ static int sil24_exec_polled_cmd(struct 
 	return rc;
 }
 
-static int sil24_softreset(struct ata_link *link, unsigned int *class)
+static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
+			      int pmp)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_taskfile tf;
@@ -611,7 +612,7 @@ static int sil24_softreset(struct ata_li
 
 	/* do SRST */
 	ata_tf_init(link->device, &tf);	/* doesn't really matter */
-	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, 0, 0,
+	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, pmp, 0,
 				   ATA_TMOUT_BOOT / HZ * 1000);
 	if (rc == -EBUSY) {
 		reason = "timeout";
@@ -636,6 +637,11 @@ static int sil24_softreset(struct ata_li
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
1.3.2


