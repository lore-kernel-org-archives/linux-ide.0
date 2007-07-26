From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/4] libata: ACPI checks for 80wire cable
Date: Thu, 26 Jul 2007 18:38:06 +0100
Message-ID: <20070726183806.3c28d981@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46900 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759774AbXGZRbN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 13:31:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Testing this on the VIA boards fixes several problems with otherwise
undetectable SATA bridge chips

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_via.c linux-2.6.23rc1-mm1/drivers/ata/pata_via.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_via.c	2007-07-26 15:01:52.974743568 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/pata_via.c	2007-07-26 15:22:30.211654968 +0100
@@ -180,6 +180,9 @@
 	   two drives */
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
+	/* Check with ACPI so we can spot BIOS reported SATA bridges */
+	if (ata_acpi_cbl_80wire(ap))
+		return ATA_CBL_PATA80;
 	return ATA_CBL_PATA40;
 }
 
