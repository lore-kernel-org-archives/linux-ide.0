From: shyam_iyer@dell.com
Subject: [PROBLEM + PATCH] Sata port disabled by BIOS gets initialized by ata_piix drive
Date: Fri, 8 Jun 2007 09:46:08 -0400
Message-ID: <9493.1181310368198.JavaMail.root@wombat.diezmil.com>
Reply-To: shyam_iyer@dell.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wombat.diezmil.com ([209.190.27.106]:35528 "EHLO
	wombat.diezmil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968972AbXFHORQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 10:17:16 -0400
Received: from wombat.diezmil.com (wombat.diezmil.com [127.0.0.1])
	by wombat.diezmil.com (8.13.8/8.13.8) with ESMTP id l58Dk8Dj015499
	for <linux-ide@vger.kernel.org>; Fri, 8 Jun 2007 09:46:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Problem
Sata disks are connected to onboard sata ports of PowerEdge 1900 (ESB2 southbridge chipset). If one of the port is disabled in the bios then they get enabled again by the ata_piix driver because of a default port map being written to the Port control and status register(0x91-93). 
Instead the driver should preserve the bios setting by way of a fix like this.

Fix:
The BIOS configured PCS value must be anded logically with the default port map for the chipset. This way the BIOS information will not be lost by the reinitialization of the config space by the ata_piix driver. The below patch is against 2.6.21 kernel.

--- ata_piix.c.orig	2007-06-08 02:38:03.000000000 +0530
+++ ata_piix.c	2007-06-08 02:39:45.000000000 +0530
@@ -990,7 +990,7 @@ static void __devinit piix_init_pcs(stru
 
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
 
-	new_pcs = pcs | map_db->port_enable;
+	new_pcs = pcs & map_db->port_enable;
 
 	if (new_pcs != pcs) {
 		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);

Signed-off-by: Shyam Iyer <shyam_iyer@dell.com>



--
This message was sent on behalf of shyam_iyer@dell.com at openSubscriber.com
http://www.opensubscriber.com/messages/linux-ide@vger.kernel.org/topic.html
