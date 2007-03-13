From: Jamie Clark <jamie@metaparadigm.com>
Subject: [PATCH] sata_sil24: Add Adaptec 1220SA PCI ID
Date: Tue, 13 Mar 2007 12:48:00 +0800
Message-ID: <45F62D00.9060902@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moof.zeroth.org ([203.117.131.35]:52228 "EHLO moof.zeroth.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbXCME4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Mar 2007 00:56:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com

Add Adaptec 1220SA (SIL3132) to devices claimed by sata_sil24
Patch generated against 2.6.20.2

Signed-off-by: Jamie Clark <jclark@metaparadigm.com>

--- drivers/ata/sata_sil24.c.orig	2007-03-10 02:58:04.000000000 +0800
+++ drivers/ata/sata_sil24.c	2007-03-12 20:41:02.000000000 +0800
@@ -352,6 +352,7 @@
 	{ PCI_VDEVICE(CMD, 0x3124), BID_SIL3124 },
 	{ PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
 	{ PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
 	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
 	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
 


