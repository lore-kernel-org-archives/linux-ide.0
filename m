From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: more NONCQ devices
Date: Mon, 18 Jun 2007 14:38:41 +0900
Message-ID: <20070618053841.GP29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:48909 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbXFRFiq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 01:38:46 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1276110nzf
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 22:38:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

More for the NCQ blacklist.  One hitachi and one raptor.  Other
members of these families of drives are already on the list, so no
surprises.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 047eabd..3562812 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3802,6 +3802,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
 	/* Drives which do spurious command completion */
 	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
+	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
+	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
 
 	/* Devices with NCQ limits */
 
