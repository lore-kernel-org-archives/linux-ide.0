From: Feng Kan <fkan@apm.com>
Subject: [PATCH RESEND] sata: xgene: add ACPI support for APM X-Gene SATA ports
Date: Wed, 18 Mar 2015 17:03:55 -0700
Message-ID: <1426723435-22378-1-git-send-email-fkan@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: patches@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tj@kernel.org
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-ide@vger.kernel.org

This adds ACPI support for the APM X-Gene SATA ports. When the system
boots using ACPI table, the SATA ports are able to configure using the
values supplied by the ACPI table rather than the DTS.

Signed-off-by: Feng Kan <fkan@apm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/ata/ahci_xgene.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 2e8bb60..2b78510 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -22,6 +22,7 @@
  * NOTE: PM support is not currently available.
  *
  */
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/ahci_platform.h>
@@ -718,6 +719,14 @@ disable_resources:
 	return rc;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_ahci_acpi_match[] = {
+	{ "APMC0D0D", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, xgene_ahci_acpi_match);
+#endif
+
 static const struct of_device_id xgene_ahci_of_match[] = {
 	{.compatible = "apm,xgene-ahci"},
 	{},
@@ -730,6 +739,7 @@ static struct platform_driver xgene_ahci_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = xgene_ahci_of_match,
+		.acpi_match_table = ACPI_PTR(xgene_ahci_acpi_match),
 	},
 };
 
-- 
1.9.1

