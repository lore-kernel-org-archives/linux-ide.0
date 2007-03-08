From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Re-fix comments on cable type
Date: Thu, 8 Mar 2007 23:19:19 +0000
Message-ID: <20070308231919.1e2b06e0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55747 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030787AbXCHWPK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:15:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:02:52.000000000 +0000
@@ -1784,10 +1798,10 @@
 }
 
 /**
- *	ata_cable_40wire	-	return 40pin cable type
+ *	ata_cable_40wire	-	return 40 wire cable type
  *	@ap: port
  *
- *	Helper method for drivers which want to hardwire 40 pin cable
+ *	Helper method for drivers which want to hardwire 40 wire cable
  *	detection.
  */
 
@@ -1797,10 +1811,10 @@
 }
 
 /**
- *	ata_cable_80wire	-	return 40pin cable type
+ *	ata_cable_80wire	-	return 80 wire cable type
  *	@ap: port
  *
- *	Helper method for drivers which want to hardwire 80 pin cable
+ *	Helper method for drivers which want to hardwire 80 wire cable
  *	detection.
  */
 
