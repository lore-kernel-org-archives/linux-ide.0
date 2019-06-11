From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] libata: Extend quirks for the ST1000LM024 drives with NOLPM quirk
Date: Tue, 11 Jun 2019 16:32:59 +0200
Message-ID: <20190611143259.28647-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

We've received a bugreport that using LPM with ST1000LM024 drives leads
to system lockups. So it seems that these models are buggy in more then
1 way. Add NOLPM quirk to the existing quirks entry for BROKEN_FPDMA_AA.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1571330
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aaa57e0c809d..4a2dff303865 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4460,9 +4460,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
-	/* drives which fail FPDMA_AA activation (some may freeze afterwards) */
-	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
-	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
+	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
+	   the ST disks also have LPM issues */
+	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
+						ATA_HORKAGE_NOLPM, },
+	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
+						ATA_HORKAGE_NOLPM, },
 	{ "VB0250EAVER",	"HPG7",		ATA_HORKAGE_BROKEN_FPDMA_AA },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
-- 
2.21.0
