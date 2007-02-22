From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH] libata: add NCQ blacklist entries from Silicon Image Windows
 driver
Date: Wed, 21 Feb 2007 23:48:57 -0600
Message-ID: <45DD2EC9.4050403@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52519 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXBVFyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 00:54:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>

This patch adds in some NCQ blacklist entries taken from the Silicon
Image Windows drivers' .inf files for the 3124 and 3132 controllers.
These entries were marked as ""DisableSataQueueing". Assume these are
in their blacklist for a reason and disable NCQ on these drives.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.21-rc1edit/drivers/ata/libata-core.c.prev	2007-02-21 22:23:05.000000000 -0600
+++ linux-2.6.21-rc1edit/drivers/ata/libata-core.c	2007-02-21 22:25:44.000000000 -0600
@@ -3269,6 +3269,13 @@ static const struct ata_blacklist_entry 
 
 	/* Devices with NCQ limits */
 
+	/* The following blacklist entries are taken from the Windows
+	   driver .inf files for the Silicon Image 3124 and 3132. */
+	{ "Maxtor 7B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ, },
+	{ "HTS541060G9SA00",	"MB3OC60D",	ATA_HORKAGE_NONCQ, },
+	{ "HTS541080G9SA00",	"MB4OC60D",	ATA_HORKAGE_NONCQ, },
+	{ "HTS541010G9SA00",	"MBZOC60D",	ATA_HORKAGE_NONCQ, },
+
 	/* End Marker */
 	{ }
 };

