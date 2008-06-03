From: maximilian attems <max@stro.at>
Subject: [PATCH] ata acer short cable quirks
Date: Tue,  3 Jun 2008 18:59:02 +0200
Message-ID: <1212512342-13374-1-git-send-email-max@stro.at>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:41054 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbYFCROz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 13:14:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, maximilian attems <max@stro.at>

From: Colin Ian King <colin.king@canonical.com>

Add ICH6 on ACER Aspire 1694WLMi to list of laptops that use short cables
rather than 80 wire

OriginalAuthor: Tiago Sousa 
OriginalLocation: http://launchpadlibrarian.net/11627664/new.ich_laptop.short.cables.diff
Bug: #187121


Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: maximilian attems <max@stro.at>
---
 drivers/ata/ata_piix.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a9027b8..e02b5e0 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -573,6 +573,8 @@ static const struct ich_laptop ich_laptop[] = {
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
 	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
+	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
+	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */
 	{ 0x2653, 0x1043, 0x82D8 },	/* ICH6M on Asus Eee 701 */
 	/* end marker */
 	{ 0, }
-- 
1.5.5.1

