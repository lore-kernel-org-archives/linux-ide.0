From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22/-stable] libata: add FUJITSU MHV2080BH to NCQ blacklist
Date: Tue, 10 Jul 2007 16:16:18 +0900
Message-ID: <20070710071618.GB23568@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:39501 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbXGJHQa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 03:16:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1732655wah
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 00:16:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Serge van Thillo <nulleke@hotmail.com>, stable@kernel.org

Please warmly welcome the first member from FUJITSU to the prestigious
NCQ spurious completion club.

This is reported by Serge Van Thillo in bugzilla bug 8730.

  http://bugzilla.kernel.org/show_bug.cgi?id=8730

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Serge van Thillo <nulleke@hotmail.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5b25311..aad783b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3796,6 +3796,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 
 	/* Devices with NCQ limits */
 
