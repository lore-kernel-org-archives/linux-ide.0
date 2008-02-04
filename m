From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata-core: unblacklist HITACHI drives
Date: Mon, 4 Feb 2008 12:24:21 -0600
Message-ID: <20080204182421.GA22434@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbYBDSb4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Feb 2008 13:31:56 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

The HITACHI HDS7250SASUN500G and HITACHI HDS7225SBSUN250 drives
do not need to be blacklisted, the NCQ problem has been resolved
with the "sata_nv: fix for completion handling" patch.

Signed-off-by David Milburn <dmilburn@redhat.com>
---

 libata-core.c |    2 --
 1 files changed, 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bdbd55a..ba5406e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4154,8 +4154,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* NCQ is broken */
 	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
-	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
-	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
 	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },
 
