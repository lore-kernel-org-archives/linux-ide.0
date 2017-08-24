From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/3] ata: pdc2027x: constify ata_port_info
Date: Thu, 24 Aug 2017 15:20:00 +0530
Message-ID: <1503568201-9991-3-git-send-email-arvind.yadav.cs@gmail.com>
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
 drivers/ata/pata_pdc2027x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 82bfd51..62ae69a 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -154,7 +154,7 @@ enum {
 	.set_mode		= pdc2027x_set_mode,
 };
 
-static struct ata_port_info pdc2027x_port_info[] = {
+static const struct ata_port_info pdc2027x_port_info[] = {
 	/* PDC_UDMA_100 */
 	{
 		.flags		= ATA_FLAG_SLAVE_POSS,
-- 
1.9.1
