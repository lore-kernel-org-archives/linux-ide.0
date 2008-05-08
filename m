From: maximilian attems <max@stro.at>
Subject: [PATCH] AHCI: add Dell PowerEdge SC430 pci id
Date: Thu,  8 May 2008 22:40:28 +0200
Message-ID: <1210279228-14521-1-git-send-email-max@stro.at>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:45160 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759266AbYEHUlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 16:41:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, maximilian attems <max@stro.at>

ATA chipset on Dell PowerEdge SC430 is identified as:
00:1f.2 IDE interface [0101]: Intel Corporation 82801GB/GR/GH (ICH7
Family) Serial ATA Storage Controller IDE [8086:27c0] (rev 01)

Kernel load the ahci driver with NCQ support after I added it's
device IDs into ahci.c.

Original patch from Andrew Lee <andrew@linux.org.tw>,
forward ported from http://bugs.debian.org/403189

Cc: Andrew Lee <andrew@linux.org.tw>,
Signed-off-by: maximilian attems <max@stro.at>
---
 drivers/ata/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 97f83fb..15657c9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -390,6 +390,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Intel */
 	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
 	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
+	{ PCI_VDEVICE(INTEL, 0x27c0), board_ahci }, /* ICH7 */
 	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
 	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
 	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
-- 
1.5.5.1

