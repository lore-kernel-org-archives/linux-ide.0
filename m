From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/3] ata: ftide010: constify ata_port_info
Date: Thu, 24 Aug 2017 15:19:59 +0530
Message-ID: <1503568201-9991-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com, linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

ata_port_info are not supposed to change at runtime. All functions
working with ata_port_info provided by <linux/libata.h> work with
const ata_port_info. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/pata_ftide010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 5d4b72e..6c04495 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -256,7 +256,7 @@ static unsigned int ftide010_qc_issue(struct ata_queued_cmd *qc)
 	.qc_issue	= ftide010_qc_issue,
 };
 
-static struct ata_port_info ftide010_port_info[] = {
+static const struct ata_port_info ftide010_port_info[] = {
 	{
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.mwdma_mask	= ATA_MWDMA2,
-- 
1.9.1
