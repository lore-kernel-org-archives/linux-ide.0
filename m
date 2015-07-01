From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH] libata: add ATA_HORKAGE_BROKEN_FPDMA_AA quirk for HP 250GB SATA disk VB0250EAVER
Date: Wed,  1 Jul 2015 13:48:30 +0300
Message-ID: <1435747710-3270-1-git-send-email-mamlinav@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35261 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbbGAKtz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2015 06:49:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>

Enabling AA on HP 250GB SATA disk VB0250EAVER causes errors:

[    3.788362] ata3.00: failed to enable AA (error_mask=0x1)
[    3.789243] ata3.00: failed to enable AA (error_mask=0x1)

Add the ATA_HORKAGE_BROKEN_FPDMA_AA for this specific harddisk.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f6cb1f1..3314116 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4178,6 +4178,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
 	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
 
+	/* HP 250GB SATA disk VB0250EAVER seem to have FPMDA_AA issues */
+	{ "VB0250EAVER",	"HPG7",		ATA_HORKAGE_BROKEN_FPDMA_AA },
+
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
-- 
2.3.6

