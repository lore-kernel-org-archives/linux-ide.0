From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-git13] libata: add ST9160821AS 3.CLF to NONCQ blacklist
Date: Fri, 20 Jul 2007 12:49:38 +0900
Message-ID: <46A030D2.1070800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:5940 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbXGTDu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 23:50:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so864674wah
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 20:50:57 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, sam@freed.net

Yay, the first one from Seagate.  3.ALC firmware is okay.  This was
reported by Sam Freed on bugzilla bug 8759.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Sam Freed <sam@freed.net>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88e2dd0..e2ecb7a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3769,6 +3769,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 
 	/* Devices with NCQ limits */
 
