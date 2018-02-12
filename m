From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V7 6/7] ata: ahci_tegra: disable DIPM
Date: Mon, 12 Feb 2018 22:56:45 +0530
Message-ID: <1518456406-21564-7-git-send-email-pchandru@nvidia.com>
References: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518456406-21564-1-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

tegra does not support DIPM and it should be disabled

Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 62f2afb54789..ffad5c61e991 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -447,7 +447,7 @@ static struct ata_port_operations ahci_tegra_port_ops = {
 };
 
 static const struct ata_port_info ahci_tegra_port_info = {
-	.flags		= AHCI_FLAG_COMMON,
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_tegra_port_ops,
-- 
2.7.4
