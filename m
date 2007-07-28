From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: blacklist SAMSUNG HD401LJ / ZZ100-15 for NCQ
Date: Sat, 28 Jul 2007 16:25:25 +0900
Message-ID: <20070728072525.GE22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:49228 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbXG1HZi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 03:25:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1161429wah
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 00:25:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: stellplatz-nr.13a@datenparkplatz.de

SAMSUNG HD401LJ / ZZ100-15 does spurious completion of NCQ commands.
Disable NCQ.  Reported by Ulrich in bugzilla #8805.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ulrich <stellplatz-nr.13a@datenparkplatz.de>
---
And, finally one from samsung.  How come vendors got this right
previously but screw up on new ones?

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6001aae..60e78be 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3788,6 +3788,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
+	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
 
 	/* Devices with NCQ limits */
 
