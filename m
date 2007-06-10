From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata: force PIO on IOMEGA ZIP 250 ATAPI
Date: Sun, 10 Jun 2007 14:52:36 +0900
Message-ID: <20070610055236.GI29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:34012 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbXFJFwm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 01:52:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1650291wah
        for <linux-ide@vger.kernel.org>; Sat, 09 Jun 2007 22:52:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, calvin.walton@gmail.com, alan@lxorguk.ukuu.org.uk

IOMEGA ZIP 250 ATAPI claims MWDMA0 support but fails SETXFERMODE if
asked to configure itself to MWDMA0.  Force PIO.

This fixes bugzilla bug#8497.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Calvin Walton <calvin.walton@gmail.com>
---
There was another proposed patch which lowers transfer mode if device
rejects transfer mode but I'm not sure whether that's the right thing
to do.  Such behavior change might affect other devices, so I'm opting
for blacklisting for now.

Thanks.

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4733f00..6312a21 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3769,6 +3769,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
+	{ "IOMEGA  ZIP 250       ATAPI", NULL,	ATA_HORKAGE_NODMA },
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 |
