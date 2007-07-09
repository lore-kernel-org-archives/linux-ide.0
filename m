From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Mon, 9 Jul 2007 14:38:41 +0100
Message-ID: <20070709143841.133abb71@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38561 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753645AbXGINce (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 09:32:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

Underneath all the HPT packaging, PCI identifiers, binary driver modules
and stuff you find that ...

Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/ata/sata_mv.c~	2007-07-09 13:19:57.003052904 +0100
+++ drivers/ata/sata_mv.c	2007-07-09 13:19:57.004052752 +0100
@@ -573,6 +573,9 @@
 	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
 	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
 	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
+	/* RocketRAID 1740/174x have different identifiers */
+	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
+	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
 
 	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
 	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
