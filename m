From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] libata: update spurious NCQ completion blacklist
Date: Fri, 28 Sep 2007 06:29:23 -0700
Message-ID: <46FD01B3.9030700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:65023 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbXI1NbU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 09:31:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2383728wxd
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 06:31:19 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

* The firmware version of ST3160812AS is "3.ADJ" no "3.AD".
* Add several entries from various sources.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fd4563d..7f424c4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3891,9 +3891,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
+	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
-	{ "ST3160812AS",	"3.AD",		ATA_HORKAGE_NONCQ, },
+	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
+	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
