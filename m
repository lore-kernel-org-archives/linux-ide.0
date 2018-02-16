From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Fri, 16 Feb 2018 10:48:20 +0100
Message-ID: <20180216094820.3587-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Various people have reported the Crucial MX100 512GB model not working
with LPM set to min_power. I've now received a report that it also does
not work with the new med_power_with_dipm level.

It does work with medium_power, but that has no measurable power-savings
and given the amount of people being bitten by the other levels not
working, this commit just disables LPM altogether.

Note all reporters of this have either the 512GB model (max capacity), or
are not specifying their SSD's size. So for now this quirk assumes this is
a problem with the 512GB model only.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=89261
Buglink: https://github.com/linrunner/TLP/issues/84
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libata-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c09122bf038..d8be0fe548f7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4530,6 +4530,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.14.3
