From: akpm@linux-foundation.org
Subject: [patch 14/25] libata: ACPI checks for 80wire cable: use in pata_amd
Date: Fri, 10 Aug 2007 13:59:42 -0700
Message-ID: <200708102059.l7AKxh6v008608@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38559 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764886AbXHJVQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

We can make use of this on the pata_amd driver as many Nvidia devices don't
have reliable cable detect.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_amd.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/ata/pata_amd.c~libata-acpi-checks-for-80wire-cable-use-in-pata_amd drivers/ata/pata_amd.c
--- a/drivers/ata/pata_amd.c~libata-acpi-checks-for-80wire-cable-use-in-pata_amd
+++ a/drivers/ata/pata_amd.c
@@ -268,6 +268,9 @@ static int nv_cable_detect(struct ata_po
  	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
  	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		cbl = ATA_CBL_PATA80;
+	/* And a triple check across suspend/resume with ACPI around */
+	if (ata_acpi_cbl_80wire(ap))
+		cbl = ATA_CBL_PATA80;
 	return cbl;
 }
 
_
