From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] Add notation that the Asus W5F laptop has a short cable instead of 80-wire.
Date: Wed, 28 Mar 2007 18:02:07 -0700
Message-ID: <117513012716-git-send-email-robbat2@gentoo.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:60791 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934290AbXC2BLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 21:11:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The Asus W5F laptop uses a short cable instead of the 80-wire style, and thus
needs to be in the ich_laptop special cases for correct detection and support
of UDMA/100 for the hard drive. I noticed this because I have the W5F laptop,
and was tracing apparent slowness.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 drivers/ata/ata_piix.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b952c58..a2c5756 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -580,6 +580,7 @@ static const struct ich_laptop ich_laptop[] = {
 	/* devid, subvendor, subdev */
 	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
+	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
 	/* end marker */
 	{ 0, }
 };
-- 
1.5.0.5

