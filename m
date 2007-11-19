From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ali: Add Mitac 8317 and derivatives
Date: Mon, 19 Nov 2007 14:36:28 +0000
Message-ID: <20071119143628.022703e8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37818 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752829AbXKSOiX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:38:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_ali.c linux-2.6.24-rc2-mm1/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_ali.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/pata_ali.c	2007-11-16 18:12:21.000000000 +0000
@@ -63,6 +63,9 @@
 	/* Fujitsu P2000 */
 	if (pdev->subsystem_vendor == 0x10CF && pdev->subsystem_device == 0x10AF)
 	   	return 1;
+	/* Mitac 8317 (Winbook-A) and relatives */
+	if (pdev->subsystem_vendor == 0x1071  && pdev->subsystem_device == 0x8317)
+		return 1;
 	/* Systems by DMI */
 	if (dmi_check_system(cable_dmi_table))
 		return 1;
