From: suman-tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH] ata: ahci_platform: Add ACPI support for APM X-Gene AHCI controller v3 hardware.
Date: Wed, 15 Jun 2016 17:44:00 -0600
Message-ID: <1466034240-22694-1-git-send-email-stripathi@apm.com>
References: <stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, suman-tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch adds ACPI support for APM X-Gene AHCI controller in
ahci_platform driver for v3 hardware. APM X-Gene AHCI controller
v3 hardware is fully compliant with ahci_platform driver and requires
no workaround quirk.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/ata/ahci_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 62a04c8..3395baf 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -86,6 +86,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);

 static const struct acpi_device_id ahci_acpi_match[] = {
 	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
+	{ "APMC0D33", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
