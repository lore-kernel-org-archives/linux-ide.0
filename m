From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: cable logic
Date: Tue, 8 Apr 2008 16:37:50 +0100
Message-ID: <20080408163750.32efc439@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51160 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753234AbYDHPlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 11:41:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

The cable detect isolation patch inadvertently removed 40 wire short
cable handling. Put it back

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 11:34:51.000000000 +0100
+++ linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 12:01:30.000000000 +0100
@@ -4559,6 +4564,10 @@
 	/* If the controller thinks we are 80 wire, we are */
 	if (ap->cbl == ATA_CBL_PATA80 || ap->cbl == ATA_CBL_SATA)
 		return 0;
+	/* If the system is known to be 40 wire short cable (eg laptop),
+	   then we allow 80 wire modes even if the drive isn't sure */
+	if (ap->cbl == ATA_CBL_PATA40_SHORT)
+		return 0;
 	/* If the controller doesn't know we scan
 
 	   - Note: We look for all 40 wire detects at this point.
