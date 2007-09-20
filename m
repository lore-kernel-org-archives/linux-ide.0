From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_acpi: Use ata_sff_port_start
Date: Thu, 20 Sep 2007 15:04:15 +0100
Message-ID: <20070920150415.542a3f49@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56579 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753366AbXITN5f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 09:57:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Purely a stylistic issue currently but best done while I notice it.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_acpi.c linux-2.6.23rc6-mm1/drivers/ata/pata_acpi.c
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_acpi.c	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/pata_acpi.c	2007-09-18 16:18:12.000000000 +0100
@@ -270,7 +270,7 @@
 	acpi->mask[0] = pacpi_discover_modes(ap, &ap->device[0]);
 	acpi->mask[1] = pacpi_discover_modes(ap, &ap->device[1]);
 
-	ret = ata_port_start(ap);
+	ret = ata_sff_port_start(ap);
 	if (ret < 0)
 		return ret;
 
