From: Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] Prevent interface errors with Seagate FreeAgent GoFlex
Date: Thu,  3 May 2012 23:21:00 +0800
Message-ID: <1336058460-19924-1-git-send-email-daniel@quora.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45443 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab2ECPV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2012 11:21:28 -0400
Received: by pbbrp8 with SMTP id rp8so2613562pbb.19
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2012 08:21:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel J Blueman <daniel@quora.org>

When connected by the optional eSATAp cable, various interface errors
occur with my new external Seagate FreeAgent GoFlex (firmware 0110) until
the interface is forced to 1.5Gbps mode. Blacklist 3.0Gbps mode with it
to avoid the error messages, delays and dataloss potential.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28db50b..0781510 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4119,6 +4119,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* Devices which aren't very happy with higher link speeds */
 	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
+	{ "Seagate FreeAgent GoFlex",	NULL,	ATA_HORKAGE_1_5_GBPS, },
 
 	/*
 	 * Devices which choke on SETXFER.  Applies only if both the
-- 
1.7.9.5

