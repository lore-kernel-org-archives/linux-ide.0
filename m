From: Per Jessen <per@computer.org>
Subject: [PATCH] ahci: recognize Marvell 88se9125 PCIe SATA 6.0 Gb/s controller
Date: Tue, 08 Feb 2011 13:54:32 +0100
Message-ID: <4D513D08.2040705@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inbound.spamchek.net ([88.198.198.123]:39953 "EHLO
	outbound.spamchek.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752775Ab1BHMyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 07:54:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>

From: Per Jessen <per@computer.org>

Recognize Marvell 88SE9125 PCIe SATA 6.0 Gb/s controller.

Signed-off-by: Per Jessen <per@computer.org>

---

The Marvell 88SE9125 PCIe SATA 6.0 Gb/s controller may be found
on e.g. the RocketRaid 62X controllers shipped with WDC 3Tb drives.
I have also submitted an update for pci-ids.


--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -380,6 +380,8 @@
	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
	{ PCI_DEVICE(0x1b4b, 0x9123),
	   .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
+	{ PCI_DEVICE(0x1b4b, 0x9125),
+	   .driver_data = board_ahci_yes_fbs },			/* 88se9125 */


	/* Promise */
