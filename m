From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] pata_it821x: Fix RAID type display
Date: Mon, 4 Jul 2011 15:33:24 +0200
Message-ID: <20110704153324.70a64e7c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:25362 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab1GDNdf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2011 09:33:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

The missing comma causes the wrong RAID type to be displayed.
Introduced by commit 963e4975c6f93c148ca809d986d412201df9af89 three
years ago, odd that nobody noticed before.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/pata_it821x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.0-rc5.orig/drivers/ata/pata_it821x.c	2011-05-20 10:42:40.000000000 +0200
+++ linux-3.0-rc5/drivers/ata/pata_it821x.c	2011-07-04 15:05:14.000000000 +0200
@@ -610,7 +610,7 @@ static void it821x_display_disk(int n, u
 	char *cbl = "(40 wire cable)";
 
 	static const char *types[5] = {
-		"RAID0", "RAID1" "RAID 0+1", "JBOD", "DISK"
+		"RAID0", "RAID1", "RAID 0+1", "JBOD", "DISK"
 	};
 
 	if (buf[52] > 4)	/* No Disk */


-- 
Jean Delvare
