From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] sata_sil24: separate out sil24_do_softreset()
Date: Mon, 16 Oct 2006 08:47:18 +0900
Message-ID: <11609560383707-git-send-email-htejun@gmail.com>
References: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:9616 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932232AbWJOXrc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:32 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636810nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:31 -0700 (PDT)
In-Reply-To: <11609560371552-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sil24_do_softreset() which takes @pmp as its last
argument.  This will be used to implement sil24_pmp_softreset().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 29e53d6..4530254 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -593,7 +593,8 @@ static int sil24_exec_polled_cmd(struct 
 	return rc;
 }
 
-static int sil24_softreset(struct ata_link *link, unsigned int *class)
+static int sil24_do_softreset(struct ata_link *link, unsigned int *class,
+			      int pmp)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_taskfile tf;
@@ -616,7 +617,7 @@ static int sil24_softreset(struct ata_li
 
 	/* do SRST */
 	ata_tf_init(link->device, &tf);	/* doesn't really matter */
-	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, 0, 0,
+	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, pmp, 0,
 				   ATA_TMOUT_BOOT / HZ * 1000);
 	if (rc == -EBUSY) {
 		reason = "timeout";
@@ -641,6 +642,11 @@ static int sil24_softreset(struct ata_li
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
1.4.2.3


