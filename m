From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ata: hpt366: fix incorrect mask when checking at cmd_high_time
Date: Tue, 12 Jul 2016 12:16:19 +0100
Message-ID: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50505 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbcGLLRC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 07:17:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel-tram@lists.ubuntu.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

According to the HPT366 data sheet, PCI config space dword 0x40-0x43
bits 11:8 specify the primary drive cmd_high_time, however,
currently just 3 bits of the 4 are being used because the mask
is 0x700 and not 0x0f00.  Fix the mask, allowing for the 40MHz clock
to be detected.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/pata_hpt366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index e5fb752..a219a50 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -368,7 +368,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* PCI clocking determines the ATA timing values to use */
 	/* info_hpt366 is safe against re-entry so we can scribble on it */
-	switch ((reg1 & 0x700) >> 8) {
+	switch ((reg1 & 0xf00) >> 8) {
 	case 9:
 		hpriv = &hpt366_40;
 		break;
-- 
2.8.1

