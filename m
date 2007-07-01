From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/15] sata_sil24: separate out sil24_do_softreset()
Date: Sun, 1 Jul 2007 19:54:15 +0900
Message-ID: <11832872551548-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:12448 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbXGAKyX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1891721wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:23 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out sil24_do_softreset() which takes @pmp as its last
argument.  This will be used to implement sil24_pmp_softreset().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 8273b8e..24d3d6b 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -587,8 +587,8 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return rc;
 }
 
-static int sil24_softreset(struct ata_link *link, unsigned int *class,
-			   unsigned long deadline)
+static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
+			      int pmp, unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	unsigned long timeout_msec = 0;
@@ -615,7 +615,8 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 		timeout_msec = jiffies_to_msecs(deadline - jiffies);
 
 	ata_tf_init(link->device, &tf);	/* doesn't really matter */
-	rc = sil24_exec_polled_cmd(ap, 0, &tf, 0, PRB_CTRL_SRST, timeout_msec);
+	rc = sil24_exec_polled_cmd(ap, pmp, &tf, 0, PRB_CTRL_SRST,
+				   timeout_msec);
 	if (rc == -EBUSY) {
 		reason = "timeout";
 		goto err;
@@ -639,6 +640,12 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 	return -EIO;
 }
 
+static int sil24_softreset(struct ata_link *link, unsigned int *class,
+			   unsigned long deadline)
+{
+	return sil24_do_softreset(link, class, 0, deadline);
+}
+
 static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
-- 
1.5.0.3


