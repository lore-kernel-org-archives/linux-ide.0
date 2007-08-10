From: akpm@linux-foundation.org
Subject: [patch 15/25] libata: ACPI checks for 80wire cable: use in pata_via
Date: Fri, 10 Aug 2007 13:59:43 -0700
Message-ID: <200708102059.l7AKxhso008611@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43523 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761200AbXHJVQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Testing this on the VIA boards fixes several problems with otherwise
undetectable SATA bridge chips

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_via.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/ata/pata_via.c~libata-acpi-checks-for-80wire-cable-use-in-pata_via drivers/ata/pata_via.c
--- a/drivers/ata/pata_via.c~libata-acpi-checks-for-80wire-cable-use-in-pata_via
+++ a/drivers/ata/pata_via.c
@@ -180,6 +180,9 @@ static int via_cable_detect(struct ata_p
 	   two drives */
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
+	/* Check with ACPI so we can spot BIOS reported SATA bridges */
+	if (ata_acpi_cbl_80wire(ap))
+		return ATA_CBL_PATA80;
 	return ATA_CBL_PATA40;
 }
 
_
