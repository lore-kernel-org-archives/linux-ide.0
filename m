From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/21] sata_sil24: separate out sil24_do_softreset()
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <11845637791907-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:11862 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759344AbXGPF3t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736630nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:48 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index e6fe4c4..e538edc 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -578,8 +578,8 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return rc;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class,
-			   unsigned long deadline)
+static int sil24_do_softreset(struct ata_port *ap, unsigned int *class,
+			      int pmp, unsigned long deadline)
 {
 	unsigned long timeout_msec = 0;
 	struct ata_taskfile tf;
@@ -605,7 +605,8 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 		timeout_msec = jiffies_to_msecs(deadline - jiffies);
 
 	ata_tf_init(ap->device, &tf);	/* doesn't really matter */
-	rc = sil24_exec_polled_cmd(ap, 0, &tf, 0, PRB_CTRL_SRST, timeout_msec);
+	rc = sil24_exec_polled_cmd(ap, pmp, &tf, 0, PRB_CTRL_SRST,
+				   timeout_msec);
 	if (rc == -EBUSY) {
 		reason = "timeout";
 		goto err;
@@ -629,6 +630,12 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 	return -EIO;
 }
 
+static int sil24_softreset(struct ata_port *ap, unsigned int *class,
+			   unsigned long deadline)
+{
+	return sil24_do_softreset(ap, class, 0, deadline);
+}
+
 static int sil24_hardreset(struct ata_port *ap, unsigned int *class,
 			   unsigned long deadline)
 {
-- 
1.5.0.3


