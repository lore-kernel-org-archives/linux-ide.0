From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/21] ahci: separate out ahci_do_softreset()
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <11845637793597-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:58841 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761043AbXGPF3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:50 -0400
Received: by py-out-1112.google.com with SMTP id d32so2086899pye
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:46 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out ahci_do_softreset() which takes @pmp as its last
argument.  This will be used to implement ahci_pmp_softreset().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index db65f4a..c5034d4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1023,8 +1023,8 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return 0;
 }
 
-static int ahci_softreset(struct ata_port *ap, unsigned int *class,
-			  unsigned long deadline)
+static int ahci_do_softreset(struct ata_port *ap, unsigned int *class,
+			     int pmp, unsigned long deadline)
 {
 	const char *reason = NULL;
 	unsigned long now, msecs;
@@ -1054,7 +1054,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 		msecs = jiffies_to_msecs(deadline - now);
 
 	tf.ctl |= ATA_SRST;
-	if (ahci_exec_polled_cmd(ap, 0, &tf, 0,
+	if (ahci_exec_polled_cmd(ap, pmp, &tf, 0,
 				 AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY, msecs)) {
 		rc = -EIO;
 		reason = "1st FIS failed";
@@ -1066,7 +1066,7 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 
 	/* issue the second D2H Register FIS */
 	tf.ctl &= ~ATA_SRST;
-	ahci_exec_polled_cmd(ap, 0, &tf, 0, 0, 0);
+	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* spec mandates ">= 2ms" before checking status.
 	 * We wait 150ms, because that was the magic delay used for
@@ -1094,6 +1094,12 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	return rc;
 }
 
+static int ahci_softreset(struct ata_port *ap, unsigned int *class,
+			  unsigned long deadline)
+{
+	return ahci_do_softreset(ap, class, 0, deadline);
+}
+
 static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
 			  unsigned long deadline)
 {
-- 
1.5.0.3


