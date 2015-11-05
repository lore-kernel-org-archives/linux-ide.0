From: <Charles_Rose@Dell.com>
Subject: [PATCH] ahci: Add Device ID for Intel Sunrise Point PCH
Date: Thu, 5 Nov 2015 15:35:26 -0600
Message-ID: <1446759326-4167-1-git-send-email-charles_rose@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:40852 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026AbbKEVpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Nov 2015 16:45:09 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Charles_Rose@Dell.com, Nanda_Kishore_Chinna@Dell.com

This patch adds a new AHCI RAID SATA Device ID for the Intel Sunrise
Point PCH.

Signed-off-by: Charles Rose <charles_rose@dell.com>
Signed-off-by: Nanda Kishore Chinna <nanda_kishore_chinna@dell.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a466602..b44f2bb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -342,6 +342,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise Point-H AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
+	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 
-- 
2.5.0
