From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add MAXTOR 7V300F0/VA111900 to NCQ blacklist
Date: Mon, 29 Oct 2007 17:57:44 +0900
Message-ID: <20071029085744.GQ11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:50421 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbXJ2I6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 04:58:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1508377rvb
        for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 01:58:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, c-otto@gmx.de

MAXTOR 7V300F0/VA111900 does spurious NCQ completions.  Add it to
blacklist.  This problem is reported by Carsten Otto.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Carsten Otto <c-otto@gmx.de>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ee56e5..3e11f83 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4032,6 +4032,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
 	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
+	{ "Maxtor 7V300F0",	"VA111900",	ATA_HORKAGE_NONCQ, },
 
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
