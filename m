From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata-core: blacklist drives from using NCQ
Date: Mon, 17 Dec 2007 16:17:59 -0600
Message-ID: <20071217221759.GA17766@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342AbXLQWYC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 17:24:02 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Blacklist "HITACHI HDS7225SCSUN250G*" and "SEAGATE STN7225SASUN250G*"
drives from using NCQ.

Signed-off-by David Milburn <dmilburn@redhat.com>
---

 libata-core.c |    2 ++
 1 files changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 597e07c..c117afa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4149,6 +4149,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
+	{ "HITACHI HDS7225SCSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
+	{ "SEAGATE STN7225SASUN250G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132


