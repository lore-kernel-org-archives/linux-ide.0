From: maximilian attems <max@stro.at>
Subject: [PATCH] ata: blacklist FUJITSU MHW2160BH PL
Date: Tue,  3 Jun 2008 18:53:25 +0200
Message-ID: <1212512005-13284-1-git-send-email-max@stro.at>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:41042 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYFCROv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 13:14:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Chuck Short <zulcss@ubuntu.com>, Tim Gardner <tim.gardner@canonical.com>, maximilian attems <max@stro.at>

From: Chuck Short <zulcss@ubuntu.com>

OriginalAuthor: Chuck Short <zulcss@ubuntu.com>
Bug: #175834

Signed-off-by: Chuck Short <zulcss@ubuntu.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: maximilian attems <max@stro.at>
---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c89f20..8f76885 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3924,6 +3924,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
+	{ "FUJITSU MHW2160BH PL", "0084001E",   ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
-- 
1.5.5.1

