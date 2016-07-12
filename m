From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ide: hpt366: fix incorrect mask when checking at cmd_high_time
Date: Tue, 12 Jul 2016 11:59:39 +0100
Message-ID: <1468321179-7647-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50235 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbcGLLAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 07:00:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S . Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

According to the HPT366 data sheet, PCI config space dword 0x40-0x43
bits 11:8 specify the primary drive cmd_high_time, however,
currently just 3 bits of the 4 are being used because the mask
is 0x07 and not 0x0f.  Fix the mask, allowing for the 40MHz clock
to be detected.

Also add in missing space between switch and parenthesis to clean
up a checkpatch warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ide/hpt366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index f94baad..f1dc6b6 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -1012,7 +1012,7 @@ static int init_chipset_hpt366(struct pci_dev *dev)
 		pci_read_config_dword(dev, 0x40, &itr1);
 
 		/* Detect PCI clock by looking at cmd_high_time. */
-		switch((itr1 >> 8) & 0x07) {
+		switch ((itr1 >> 8) & 0x0f) {
 			case 0x09:
 				pci_clk = 40;
 				break;
-- 
2.8.1

