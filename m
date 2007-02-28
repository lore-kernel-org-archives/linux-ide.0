From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: blacklist FUJITSU MHT2060BH for NCQ
Date: Wed, 28 Feb 2007 15:21:23 +0900
Message-ID: <20070228062123.GJ20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:64897 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbXB1GVZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 01:21:25 -0500
Received: by py-out-1112.google.com with SMTP id a29so26835pyi
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 22:21:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: maccetta@laurelnetworks.com

Blacklist FUJITSU MHT2060BH for NCQ.  On this drive, NCQ works iff
queue depth is equal to or less than 4.  Just turn it off.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mike Accetta <maccetta@laurelnetworks.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bdde327..69665c8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3346,6 +3346,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices where NCQ should be avoided */
 	/* NCQ is slow */
         { "WDC WD740ADFD-00",   NULL,		ATA_HORKAGE_NONCQ },
+	/* http://thread.gmane.org/gmane.linux.ide/14907 */
+	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
 
 	/* Devices with NCQ limits */
 
