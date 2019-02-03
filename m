From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD
Date: Sun,  3 Feb 2019 10:02:07 +0100
Message-ID: <20190203090207.10930-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

We've received a bugreport that using LPM with a SAMSUNG
MZ7TE512HMHP-000L1 SSD leads to system instability, we already have
a quirk for the MZ7TD256HAFV-000L9, which is also a Samsun EVO 840 /
PM851 OEM model, so it seems some of these models have a LPM issue.

This commits adds a NOLPM quirk for the model string from the new
bugeport, to avoid the reported stability issues.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1571330
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b8c3f9e6af89..adf28788cab5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4554,6 +4554,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.20.1
