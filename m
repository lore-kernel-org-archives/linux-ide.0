From: Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH] ata_piix: Add Fujitsu-Siemens Lifebook S6120 to short cable IDs
Date: Mon, 18 Sep 2017 23:00:08 +0300
Message-ID: <20170918200008.16139-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdIRUAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 18 Sep 2017 16:00:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Fujitsu-Siemens Lifebook S6120 misdetects the cable type for some
drives. The problematic one in this case is an mSATA SSD hooked up via a
mSATA->PATA bridge. With regular hard disks the detection seems to work
correctly.

Strangely an older Lifebook model (S6020) detects the cable as 80c
with the mSATA SSD, even if using the exact same flex cable.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/ata/ata_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 8401c3b5be92..b702c20fbc2b 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -492,6 +492,7 @@ static const struct ich_laptop ich_laptop[] = {
 	{ 0x27DF, 0x152D, 0x0778 },	/* ICH7 on unknown Intel */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
 	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
+	{ 0x24CA, 0x10CF, 0x11AB },	/* ICH4M on Fujitsu-Siemens Lifebook S6120 */
 	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */
 	{ 0x2653, 0x1043, 0x82D8 },	/* ICH6M on Asus Eee 701 */
 	{ 0x27df, 0x104d, 0x900e },	/* ICH7 on Sony TZ-90 */
-- 
2.13.5

