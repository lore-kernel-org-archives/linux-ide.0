From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH -stable] libata: sync NCQ blacklist with upstream
Date: Thu, 11 Oct 2007 10:55:15 +0900
Message-ID: <20071011015515.GQ12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:41957 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbXJKBzW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 21:55:22 -0400
Received: by wa-out-1112.google.com with SMTP id v27so441760wah
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 18:55:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

Synchronize NCQ blacklist with the current upstream.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: tree0/drivers/ata/libata-core.c
===================================================================
--- tree0.orig/drivers/ata/libata-core.c
+++ tree0/drivers/ata/libata-core.c
@@ -3793,11 +3793,17 @@ static const struct ata_blacklist_entry 
 	/* Drives which do spurious command completion */
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
+	{ "HDT722516DLA380",	"V43OA96A",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
+	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
-	{ "ST3160812AS",	"3.AD",		ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.CCD",	ATA_HORKAGE_NONCQ, },
+	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
+	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
