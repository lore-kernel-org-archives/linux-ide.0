From: <JosephChan@via.com.tw>
Subject: [Patch 1/1 v2] sata_via.c: Remove redundant device ID for VT8261
Date: Fri, 16 Oct 2009 13:31:51 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A1D1C72@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exchtp08.via.com.tw ([61.66.243.7]:53677 "EHLO
	exchtp08.via.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZJPFca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Oct 2009 01:32:30 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, stable@kernel.org
Cc: alan@lxorguk.ukuu.org.uk, tj@kernel.org, jeff@garzik.org, JosephChan@via.com.tw

Just remove redundant device ID for VT8261.
The device ID 0x9000 and 0x9040 are redundant (for VT8261).
The 0x9040 is reserved for other usage.

Signed-off-by: Joseph Chan <josephchan@via.com.tw>

--- a/drivers/ata/sata_via.c	2009-10-15 21:38:14.000000000 +0800
+++ b/drivers/ata/sata_via.c	2009-10-15 21:38:28.000000000 +0800
@@ -93,7 +93,6 @@
 	{ PCI_VDEVICE(VIA, 0x7372), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x5287), vt8251 }, /* 2 sata chnls (Master/Slave) */
 	{ PCI_VDEVICE(VIA, 0x9000), vt8251 },
-	{ PCI_VDEVICE(VIA, 0x9040), vt8251 },
 
 	{ }	/* terminate list */
 };
