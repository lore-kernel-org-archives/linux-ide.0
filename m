From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_amd: Note in the module description it handles Nvidia
Date: Fri, 8 Feb 2008 15:22:39 +0000
Message-ID: <20080208152239.0fc11e85@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41500 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754460AbYBHP3j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 10:29:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

This has confused a few people so fix it

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/pata_amd.c linux-2.6.24-mm1/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.24-mm1/drivers/ata/pata_amd.c	2008-02-06 14:14:39.000000000 +0000
+++ linux-2.6.24-mm1/drivers/ata/pata_amd.c	2008-02-06 14:31:35.000000000 +0000
@@ -772,7 +772,7 @@
 }
 
 MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("low-level driver for AMD PATA IDE");
+MODULE_DESCRIPTION("low-level driver for AMD and Nvidia PATA IDE");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, amd);
 MODULE_VERSION(DRV_VERSION);
