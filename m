From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/15] ahci: separate out ahci_do_softreset()
Date: Sun, 1 Jul 2007 19:54:16 +0900
Message-ID: <11832872562351-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:11952 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915AbXGAKyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1891696wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:24 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out ahci_do_softreset() which takes @pmp as its last
argument.  This will be used to implement ahci_pmp_softreset().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d25cee8..94bb767 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -998,8 +998,8 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return 0;
 }
 
-static int ahci_softreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline)
+static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
+			     int pmp, unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	const char *reason = NULL;
@@ -1030,7 +1030,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 		msecs = jiffies_to_msecs(deadline - now);
 
 	tf.ctl |= ATA_SRST;
-	if (ahci_exec_polled_cmd(ap, 0, &tf, 0,
+	if (ahci_exec_polled_cmd(ap, pmp, &tf, 0,
 				 AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY, msecs)) {
 		rc = -EIO;
 		reason = "1st FIS failed";
@@ -1042,7 +1042,7 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 
 	/* issue the second D2H Register FIS */
 	tf.ctl &= ~ATA_SRST;
-	ahci_exec_polled_cmd(ap, 0, &tf, 0, 0, 0);
+	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* spec mandates ">= 2ms" before checking status.
 	 * We wait 150ms, because that was the magic delay used for
@@ -1070,6 +1070,17 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 	return rc;
 }
 
+static int ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	int pmp = 0;
+
+	if (link->ap->flags & ATA_FLAG_PMP)
+		pmp = SATA_PMP_CTRL_PORT;
+
+	return ahci_do_softreset(link, class, pmp, deadline);
+}
+
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
-- 
1.5.0.3


