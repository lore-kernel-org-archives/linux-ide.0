From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V7 7/7] ata: ahci_tegra: Add AHCI support for Tegra210
Date: Mon, 12 Feb 2018 22:56:46 +0530
Message-ID: <1518456406-21564-8-git-send-email-pchandru@nvidia.com>
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

Add support for the AHCI-compliant Serial ATA host
controller on the Tegra210 system-on-chip.

Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v7:
* Added commit message
---
 drivers/ata/ahci_tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index ffad5c61e991..4524755b9b23 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -466,11 +466,19 @@ static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
 	},
 };
 
+static const struct tegra_ahci_soc tegra210_ahci_soc_data = {
+	.quirks = NO_DEVSLP,
+};
+
 static const struct of_device_id tegra_ahci_of_match[] = {
 	{
 		.compatible = "nvidia,tegra124-ahci",
 		.data = &tegra124_ahci_soc_data
 	},
+	{
+		.compatible = "nvidia,tegra210-ahci",
+		.data = &tegra210_ahci_soc_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_ahci_of_match);
@@ -585,5 +593,5 @@ static struct platform_driver tegra_ahci_driver = {
 module_platform_driver(tegra_ahci_driver);
 
 MODULE_AUTHOR("Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
-MODULE_DESCRIPTION("Tegra124 AHCI SATA driver");
+MODULE_DESCRIPTION("Tegra AHCI SATA driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
