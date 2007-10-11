From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add ST9160821AS / 3.CCD to NCQ blacklist
Date: Thu, 11 Oct 2007 10:49:26 +0900
Message-ID: <20071011014926.GP12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:10312 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbXJKBtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 21:49:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so351522rvb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 18:49:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ST9160821AS / 3.CCD does spurious completions too.  Blacklist it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ce8ccb4..5402755 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3984,6 +3984,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.CCD",	ATA_HORKAGE_NONCQ, },
 	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
 	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
