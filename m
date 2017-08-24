From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/3] ata: constify ata_port_info
Date: Thu, 24 Aug 2017 15:20:01 +0530
Message-ID: <1503568201-9991-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33692 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdHXJu2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2017 05:50:28 -0400
In-Reply-To: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com, linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

ata_port_info are not supposed to change at runtime. All functions
working with ata_port_info provided by <linux/libata.h> work with
const ata_port_info. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/pdc_adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index f1e873a..77c21cb 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -162,7 +162,7 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	.port_stop		= adma_port_stop,
 };
 
-static struct ata_port_info adma_port_info[] = {
+static const struct ata_port_info adma_port_info[] = {
 	/* board_1841_idx */
 	{
 		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING,
-- 
1.9.1

