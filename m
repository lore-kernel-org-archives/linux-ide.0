From: Suman Tripathi <stripathi@amperecomputing.com>
Subject: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Date: Mon, 27 Aug 2018 11:47:53 -0700
Message-ID: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: patches@amperecomputing.com, Suman Tripathi <stripathi@amperecomputing.com>, Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
List-Id: linux-ide@vger.kernel.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
 drivers/ata/ahci_platform.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..0d0233e 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -26,7 +26,7 @@

 #define DRV_NAME "ahci"

-static const struct ata_port_info ahci_port_info = {
+static struct ata_port_info ahci_port_info = {
 	.flags		= AHCI_FLAG_COMMON,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
@@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	struct acpi_device_info *info;
+	acpi_status status;
 	int rc;

 	hpriv = ahci_platform_get_resources(pdev);
@@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

+	status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
+	if (ACPI_SUCCESS(status)) {
+		if (info->valid & ACPI_VALID_HID) {
+			if (!strcmp("APMC0D33", info->hardware_id.string))
+				ahci_port_info.flags |= ATA_FLAG_NO_LPM;
+		}
+		ACPI_FREE(info);
+	}
+
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
 				     &ahci_platform_sht);
 	if (rc)
--
1.8.3.1
