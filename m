From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add HTS542525K9SA00 to NCQ blacklist
Date: Tue, 23 Oct 2007 19:07:49 +0900
Message-ID: <20071023100749.GD18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:51207 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbXJWKIA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 06:08:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1438822rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 03:07:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Luca Tettamanti <kronos.it@gmail.com>

Another one doing spurious NCQ completions.  Blacklist it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 908613d..be872fa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3981,6 +3981,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
 	{ "HDT722516DLA380",	"V43OA96A",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
+	{ "Hitachi HTS542525K9SA00", "BBFOC31P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
