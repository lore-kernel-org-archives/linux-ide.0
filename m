From: Chuck Ebbert <cebbert@redhat.com>
Subject: [PATCH] libata: add another Maxtor drive with broken NCQ to the list
Date: Thu, 12 Jul 2007 14:37:19 -0400
Message-ID: <469674DF.9000804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455AbXGLShW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 14:37:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Add another Maxtor 6B200M0 drive with broken NCQ to the list.

Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.22.noarch.orig/drivers/ata/libata-core.c
+++ linux-2.6.22.noarch/drivers/ata/libata-core.c
@@ -3787,6 +3787,7 @@ static const struct ata_blacklist_entry 
 	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
 	/* NCQ is broken */
 	{ "Maxtor 6L250S0",     "BANC1G10",     ATA_HORKAGE_NONCQ },
+	{ "Maxtor 6B200M0",	"BANC1BM0",	ATA_HORKAGE_NONCQ },
 	{ "Maxtor 6B200M0",	"BANC1B10",	ATA_HORKAGE_NONCQ },
 	/* NCQ hard hangs device under heavier load, needs hard power cycle */
 	{ "Maxtor 6B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ },
