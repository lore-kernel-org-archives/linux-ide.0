From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata-core: blacklist HITACHI HDS drives using wildcard blacklist matching
Date: Fri, 28 Sep 2007 14:29:06 -0500
Message-ID: <20070928192906.GA28375@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbXI1TdI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 15:33:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, dmilburn@redhat.com

Blacklist HITACHI HDS7250SASUN500G and HITACHI HDS7225SBSUN250G
drives using wildcard matching.

Signed-off-by David Milburn <dmilburn@redhat.com>
---

 libata-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fd4563d..d6319ec 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3878,8 +3878,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* NCQ is broken */
 	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
-	{ "HITACHI HDS7250SASUN500G 0621KTAWSD", "K2AOAJ0AHITACHI",
-	  ATA_HORKAGE_NONCQ },
+	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
+	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
