From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH V6 6/7] ata: ahci_tegra: disable DIPM
Date: Tue, 9 Jan 2018 12:47:13 +0530
Message-ID: <1515482234-24716-7-git-send-email-pchandru@nvidia.com>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15364 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeAIHS0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2018 02:18:26 -0500
In-Reply-To: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org, cyndis@kapsi.fi
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Ramchandra <pchandru@nvidia.com>

From: Preetham Ramchandra <pchandru@nvidia.com>

tegra does not support DIPM and it should be disabled

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index a59a97b1b2e5..013880de6412 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -460,7 +460,7 @@ static struct ata_port_operations ahci_tegra_port_ops = {
 };
 
 static const struct ata_port_info ahci_tegra_port_info = {
-	.flags		= AHCI_FLAG_COMMON,
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_tegra_port_ops,
-- 
2.7.4

