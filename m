From: Per Jessen <per@computer.org>
Subject: [PATCH] ahci: recognize Marvell 88se9125 PCIe SATA 6.0 Gb/s controller
Date: Tue, 08 Feb 2011 10:07:31 +0100
Message-ID: <4D5107D3.7030509@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inbound.spamchek.net ([88.198.198.123]:40846 "EHLO
	outbound.spamchek.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751253Ab1BHJO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 04:14:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff


Below is a minor patch for drivers/ata/ahci.c for recognising
Marvell 88SE9125 PCIe SATA 6.0 Gb/s controller as found on the
RocketRaid 62X controller series.  I have also submitted updates
to pci-ids.


Signed-off-by: Per Jessen <per@computer.org>


--- a/drivers/ata/ahci.c  2011-02-02 14:55:16.514999946 +0100
+++ b/drivers/ata/ahci.c  2011-02-01 14:01:00.380977830 +0100
@@ -380,6 +380,8 @@
         { PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },        /* 6121 */
         { PCI_DEVICE(0x1b4b, 0x9123),
           .driver_data = board_ahci_yes_fbs },                  /* 88se9128 */
+       { PCI_DEVICE(0x1b4b, 0x9125),
+          .driver_data = board_ahci_yes_fbs },                  /* 88se9125 */


         /* Promise */


