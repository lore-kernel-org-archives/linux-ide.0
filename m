From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: add ST9120822AS 3.CLF to NONCQ blacklist
Date: Fri, 14 Sep 2007 21:33:23 +0900
Message-ID: <20070914123323.GA6631@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:30501 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbXINMdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2007 08:33:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so668834rvb
        for <linux-ide@vger.kernel.org>; Fri, 14 Sep 2007 05:33:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, anschneider@novell.com

ST9120822AS 3.CLF does spurious NCQ completions, add it to NONCQ
blacklist.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
It's likely that all the drives with 3.CLF firmware are bonkers
regarding this.  Maybe we should blacklist by firmware version only.

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c43de9a..e7d7184 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3793,6 +3793,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
+	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
 
