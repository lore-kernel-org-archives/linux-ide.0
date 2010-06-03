From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_via: explain the magic fix
Date: Thu, 03 Jun 2010 11:35:03 +0200
Message-ID: <4C077747.4050006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55542 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933332Ab0FCJfP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Jun 2010 05:35:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>

Add Joseph Chan's explanation of the problem and workaround to the
VT6421 magic fix.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/ata/sata_via.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 0ecd0f6..4730c42 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -578,10 +578,24 @@ static void svia_configure(struct pci_dev *pdev)

 	/*
 	 * vt6421 has problems talking to some drives.  The following
-	 * is the magic fix from Joseph Chan <JosephChan@via.com.tw>.
-	 * Please add proper documentation if possible.
+	 * is the fix from Joseph Chan <JosephChan@via.com.tw>.
+	 *
+	 * When host issues HOLD, device may send up to 20DW of data
+	 * before acknowledging it with HOLDA and the host should be
+	 * able to buffer them in FIFO.  Unfortunately, some WD drives
+	 * send upto 40DW before acknowledging HOLD and, in the
+	 * default configuration, this ends up overflowing vt6421's
+	 * FIFO, making the controller abort the transaction with
+	 * R_ERR.
+	 *
+	 * Rx52[2] is the internal 128DW FIFO Flow control watermark
+	 * adjusting mechanism enable bit and the default value 0
+	 * means host will issue HOLD to device when the left FIFO
+	 * size goes below 32DW.  Setting it to 1 makes the watermark
+	 * 64DW.
 	 *
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=15173
+	 * http://article.gmane.org/gmane.linux.ide/46352
 	 */
 	if (pdev->device == 0x3249) {
 		pci_read_config_byte(pdev, 0x52, &tmp8);
