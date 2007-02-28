From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: [PATCH]Support for Marvell 7042 Chip
Date: Wed, 28 Feb 2007 10:53:22 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90106ADB2B9@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:1647 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbXB1QHk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 11:07:40 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jeff@garzik.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Added Support for Marvell 7042 Chip - 7042 has same 
capabilities & behavior as 6042.

Patch based upon stable Linux 2.6.20.1 Kernel Tree...

Signed-off-by: Thomas A. Morrison <tmorrison@empirix.com>

----

--- drivers/ata/sata_mv.c.orig	2007-02-20 01:34:32.000000000 -0500
+++ drivers/ata/sata_mv.c	2007-02-28 10:22:03.000000000 -0500
@@ -546,6 +546,9 @@ static const struct pci_device_id mv_pci
 
 	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
 
+	/* add Marvell 7042 support */
+	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
+
 	{ }			/* terminate list */
 };

