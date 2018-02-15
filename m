From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] libata: disable LPM for Crucial BX100 SSD drives
Date: Fri, 16 Feb 2018 03:00:23 +0800
Message-ID: <20180215190023.25575-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-ide@vger.kernel.org

After Laptop Mode Tools starts to use min_power for LPM, a user found
out Crucial BX100 SSD can't get mounted.

Crucial BX100 SSD drives don't work well with min_power. This also
happens to med_power_with_dipm.

So let's disable LPM for Crucial BX100 SSD drives.

BugLink: https://bugs.launchpad.net/bugs/1726930
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/ata/libata-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c09122bf038..577cf820eed4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4592,6 +4592,14 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 
+	/*
+	 * Crucial BX100 SSD has broken min_power and med_power_with_dipm
+	 * support.
+	 *
+	 * https://bugs.launchpad.net/bugs/1726930
+	 */
+	{ "CT*BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
+
 	/* End Marker */
 	{ }
 };
-- 
2.15.1
