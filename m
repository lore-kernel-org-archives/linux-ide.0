From: Florian Attenberger <valdyn@gmail.com>
Subject: [PATCH 2.6.22-rc6] add PCI-ID for Adaptec 1430SA 4-Port SATA
	Controller
Date: Sat, 30 Jun 2007 16:44:36 +0200
Message-ID: <20070630144436.GA13479@master.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:11937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226AbXF3Ool (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 10:44:41 -0400
Received: by ug-out-1314.google.com with SMTP id j3so987263ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 07:44:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

added this pci id to support my:
lspci:
01:00.0 RAID bus controller: Adaptec Unknown device 0243 (rev 02)
lspci -n:
01:00.0 0104: 9005:0243 (rev 02)

seems to work fine.

florian attenberger


--- 2.6.22-rc6/drivers/ata/sata_mv.c	2007-06-30 16:21:47.462020256 +0200
+++ 2.6.22-rc6.mine/drivers/ata/sata_mv.c	2007-06-30 16:25:25.999165444 +0200
@@ -582,6 +582,9 @@ static const struct pci_device_id mv_pci
 
 	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
 
+	/* Adaptec 1430SA */
+	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
+
 	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
 
 	/* add Marvell 7042 support */
