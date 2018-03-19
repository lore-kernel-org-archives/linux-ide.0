From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Mon, 19 Mar 2018 16:33:59 +0100
Message-ID: <20180319153400.25694-2-hdegoede@redhat.com>
References: <20180319153400.25694-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319153400.25694-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-ide@vger.kernel.org

Commit b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB
drive"), introduced a ATA_HORKAGE_NOLPM quirk for Crucial BX100 500GB SSDs
but limited this to the MU02 firmware version, according to:
http://www.crucial.com/usa/en/support-ssd-firmware

MU02 is the last version, so there are no newer possibly fixed versions
and if the MU02 version has broken LPM then the MU01 almost certainly
also has broken LPM, so this commit changes the quirk to apply to all
firmware versions.

Fixes: b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB...")
Cc: stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 53400ce09818..bce9840526da 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4531,7 +4531,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.14.3
