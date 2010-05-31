From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_via: magic vt6421 fix for transmission
 problems w/ WD drives
Date: Mon, 31 May 2010 16:26:48 +0200
Message-ID: <4C03C728.9080107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44698 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab0EaO1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 May 2010 10:27:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, JosephChan@via.com.tw
Cc: sjorrit@gmail.com, stable@kernel.org

vt6421 has problems talking to recent WD drives.  It causes a lot of
transmission errors while high bandwidth transfer as reported in the
following bugzilla entry.

  https://bugzilla.kernel.org/show_bug.cgi?id=15173

Joseph Chan provided the following fix.  I don't have any idea what it
does but I can verify the issue is gone with the patch applied.

Signed-off-by: Tejun Heo <tj@kernel.org>
Originally-from: Joseph Chan <JosephChan@via.com.tw>
Reported-by: Jorrit Tijben <sjorrit@gmail.com>
Cc: stable@kernel.org
---
Joseph, can you please add some documentation of what it does and why?

Thanks.

 drivers/ata/sata_via.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 101d8c2..0ecd0f6 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -575,6 +575,19 @@ static void svia_configure(struct pci_dev *pdev)
 		tmp8 |= NATIVE_MODE_ALL;
 		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
 	}
+
+	/*
+	 * vt6421 has problems talking to some drives.  The following
+	 * is the magic fix from Joseph Chan <JosephChan@via.com.tw>.
+	 * Please add proper documentation if possible.
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=15173
+	 */
+	if (pdev->device == 0x3249) {
+		pci_read_config_byte(pdev, 0x52, &tmp8);
+		tmp8 |= 1 << 2;
+		pci_write_config_byte(pdev, 0x52, tmp8);
+	}
 }

 static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
