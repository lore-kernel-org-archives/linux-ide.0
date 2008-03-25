From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/27] ahci: use ata_wait_after_reset() instead of ata_sff_wait_ready()
Date: Tue, 25 Mar 2008 22:16:52 +0900
Message-ID: <12064510271243-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:63042 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbYCYNRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755542rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:44 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Implement ahci_check_ready() and replace ata_sff_wait_after_reset()
with ata_wait_after_reset().  As ahci was faking TF access, this
change doesn't result in any functional difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 45a67a9..7e251a2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1256,6 +1256,16 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return 0;
 }
 
+static int ahci_check_ready(struct ata_link *link)
+{
+	void __iomem *mmio = link->ap->ioaddr.cmd_addr;
+	u8 status = readl(mmio + PORT_TFDATA) & 0xFF;
+
+	if (!(status & ATA_BUSY))
+		return 1;
+	return 0;
+}
+
 static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 			     int pmp, unsigned long deadline)
 {
@@ -1303,7 +1313,7 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* wait for link to become ready */
-	rc = ata_sff_wait_after_reset(link, 1, deadline);
+	rc = ata_wait_after_reset(link, deadline, ahci_check_ready);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		reason = "device not ready";
@@ -1426,7 +1436,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	 * have to be reset again.  For most cases, this should
 	 * suffice while making probing snappish enough.
 	 */
-	rc = ata_sff_wait_after_reset(link, 1, jiffies + 2 * HZ);
+	rc = ata_wait_after_reset(link, jiffies + 2 * HZ, ahci_check_ready);
 	if (rc)
 		ahci_kick_engine(ap, 0);
 
-- 
1.5.2.4

