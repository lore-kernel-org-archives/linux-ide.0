From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/4] libata: ACPI checks for 80wire cable
Date: Thu, 26 Jul 2007 18:37:28 +0100
Message-ID: <20070726183728.429122ba@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46897 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761783AbXGZRai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 13:30:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

We can make use of this on the pata_amd driver as many Nvidia devices
don't have reliable cable detect.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_amd.c linux-2.6.23rc1-mm1/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_amd.c	2007-07-26 15:01:52.909753448 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/pata_amd.c	2007-07-26 15:18:24.934942696 +0100
@@ -268,6 +268,9 @@
  	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
  	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		cbl = ATA_CBL_PATA80;
+	/* And a triple check across suspend/resume with ACPI around */
+	if (ata_acpi_cbl_80wire(ap))
+		cbl = ATA_CBL_PATA80;
 	return cbl;
 }
 
