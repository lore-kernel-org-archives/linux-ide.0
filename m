From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add HDT722516DLA380 to NCQ blacklist
Date: Thu, 4 Oct 2007 17:27:59 +0900
Message-ID: <20071004082759.GB12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:28666 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbXJDI2G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 04:28:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so119107wah
        for <linux-ide@vger.kernel.org>; Thu, 04 Oct 2007 01:28:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, elendil@planet.nl

HDT722516DLA380 does spurious completion of NCQ commands.  Blacklist
it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Frans Pop <elendil@planet.nl>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aecbdad..964a698 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3967,6 +3967,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Drives which do spurious command completion */
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
+	{ "HDT722516DLA380",	"V43OA96A",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
