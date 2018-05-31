From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
Date: Thu, 31 May 2018 13:21:07 +0200
Message-ID: <20180531112107.13778-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>, Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
List-Id: linux-ide@vger.kernel.org

Commit 184add2ca23c ("libata: Apply NOLPM quirk for SanDisk
SD7UB3Q*G1001 SSDs") disabled LPM for SanDisk SD7UB3Q*G1001 SSDs.

This has lead to several reports of users of that SSD where LPM
was working fine and who know have a significantly increased idle
power consumption on their laptops.

Likely there is another problem on the T450s from the original
reporter which gets exposed by the uncore reaching deeper sleep
states (higher PC-states) due to LPM being enabled. The problem as
reported, a hardfreeze about once a day, already did not sound like
it would be caused by LPM and the reports of the SSD working fine
confirm this. The original reporter is ok with dropping the quirk.

A X250 user has reported the same hard freeze problem and for him
the problem went away after unrelated updates, I suspect some GPU
driver stack changes fixed things.

TL;DR: The original reporters problem were triggered by LPM but not
an LPM issue, so drop the quirk for the SSD in question.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1583207
Cc: stable@vger.kernel.org
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rebase on 4.17-rc7
---
 drivers/ata/libata-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 346b163f6e89..9bfd2f7e4542 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4557,9 +4557,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 
-	/* Sandisk devices which are known to not handle LPM well */
-	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
-
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.17.0
