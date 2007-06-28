From: Chuck Ebbert <cebbert@redhat.com>
Subject: ATA: add a PCI ID for Intel Santa Rosa PATA controller
Date: Thu, 28 Jun 2007 15:16:01 -0400
Message-ID: <468408F1.3080307@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020207050608070508060401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:47252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763995AbXF1TQM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 15:16:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jason Gaston <jason.d.gaston@intel.com>

This is a multi-part message in MIME format.
--------------020207050608070508060401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Christian Lamparter <chunkeey@web.de>

ATA: add a PCI ID for Intel Santa Rosa PATA controller.

Signed-off-by: Christian Lamparter <chunkeey@web.de>
---

[against 2.6.22-rc6; patch also attached, use the attachment]

 drivers/ata/ata_piix.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9c07b88..b210726 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -200,6 +200,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
        /* ICH7/7-R (i945, i975) UDMA 100*/
        { 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
        { 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+       /* ICH8 Mobile PATA Controller */
+       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },

        /* NOTE: The following PCI ids must be kept in sync with the
         * list in drivers/pci/quirks.c.

--------------020207050608070508060401
Content-Type: text/plain;
 name="ich8m-add-pciid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ich8m-add-pciid.patch"

From: Christian Lamparter <chunkeey@web.de>

ATA: add a PCI ID for Intel Santa Rosa PATA controller.

Signed-off-by: Christian Lamparter <chunkeey@web.de>
---
 drivers/ata/ata_piix.c |    2 ++
 1 file changed, 2 insertions(+) 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9c07b88..b210726 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -200,6 +200,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* ICH7/7-R (i945, i975) UDMA 100*/
 	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* ICH8 Mobile PATA Controller */
+	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.

--------------020207050608070508060401--
