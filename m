From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_via: apply magic FIFO fix to vt6420
 too
Date: Fri, 19 Nov 2010 15:29:19 +0100
Message-ID: <4CE689BF.40703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57246 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab0KSO3j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Nov 2010 09:29:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joseph Chan <JosephChan@via.com.tw>, q@maq.dk, stable <stable@kernel.org>

vt6420 has the same FIFO overflow problem as vt6421 when combined with
certain devices.  This patch applies the magic fix to vt6420 too.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Martin Qvist <q@maq.dk>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: stable@kernel.org
---
 drivers/ata/sata_via.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index c215899..8b677bb 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -538,7 +538,7 @@ static int vt8251_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	return 0;
 }

-static void svia_configure(struct pci_dev *pdev)
+static void svia_configure(struct pci_dev *pdev, int board_id)
 {
 	u8 tmp8;

@@ -577,7 +577,7 @@ static void svia_configure(struct pci_dev *pdev)
 	}

 	/*
-	 * vt6421 has problems talking to some drives.  The following
+	 * vt6420/1 has problems talking to some drives.  The following
 	 * is the fix from Joseph Chan <JosephChan@via.com.tw>.
 	 *
 	 * When host issues HOLD, device may send up to 20DW of data
@@ -596,8 +596,9 @@ static void svia_configure(struct pci_dev *pdev)
 	 *
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=15173
 	 * http://article.gmane.org/gmane.linux.ide/46352
+	 * http://thread.gmane.org/gmane.linux.kernel/1062139
 	 */
-	if (pdev->device == 0x3249) {
+	if (board_id == vt6420 || board_id == vt6421) {
 		pci_read_config_byte(pdev, 0x52, &tmp8);
 		tmp8 |= 1 << 2;
 		pci_write_config_byte(pdev, 0x52, tmp8);
@@ -652,7 +653,7 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;

-	svia_configure(pdev);
+	svia_configure(pdev, board_id);

 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
