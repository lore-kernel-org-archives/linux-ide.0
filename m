From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
Date: Mon, 19 Mar 2018 16:34:00 +0100
Message-ID: <20180319153400.25694-3-hdegoede@redhat.com>
References: <20180319153400.25694-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319153400.25694-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

When commit 9c7be59fc519af ("libata: Apply NOLPM quirk to Crucial MX100
512GB SSDs") was added it inherited the ATA_HORKAGE_NO_NCQ_TRIM quirk
from the existing "Crucial_CT*MX100*" entry, but that entry sets model_rev
to "MU01", where as the entry adding the NOLPM quirk sets it to NULL.

This means that after this commit we no apply the NO_NCQ_TRIM quirk to
all "Crucial_CT512MX100*" SSDs even if they have the fixed "MU02"
firmware. This commit splits the "Crucial_CT512MX100*" quirk into 2
quirks, one for the "MU01" firmware and one for all other firmware
versions, so that we once again only apply the NO_NCQ_TRIM quirk to the
"MU01" firmware version.

Fixes: 9c7be59fc519af ("libata: Apply NOLPM quirk to ... MX100 512GB SSDs")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bce9840526da..7431ccd03316 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4533,10 +4533,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Crucial BX100 SSD 500GB has broken LPM support */
 	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
-	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
-	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
+	/* 512GB MX100 with newer firmware has only LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
 
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
 	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.14.3
