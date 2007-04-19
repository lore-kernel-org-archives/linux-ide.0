From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata oops fix
Date: Thu, 19 Apr 2007 19:23:25 -0400
Message-ID: <20070419232325.GA16191@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:43662 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbXDSXX0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Apr 2007 19:23:26 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/pata_sis.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Alan Cox (1):
      pata_sis: Fix oops on boot

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index f482078..8dc3bc4 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -878,6 +878,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ata_port_info *port;
 	struct pci_dev *host = NULL;
 	struct sis_chipset *chipset = NULL;
+	struct sis_chipset *sets;
 
 	static struct sis_chipset sis_chipsets[] = {
 
@@ -932,10 +933,11 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* We have to find the bridge first */
 
-	for (chipset = &sis_chipsets[0]; chipset->device; chipset++) {
-		host = pci_get_device(PCI_VENDOR_ID_SI, chipset->device, NULL);
+	for (sets = &sis_chipsets[0]; sets->device; sets++) {
+		host = pci_get_device(PCI_VENDOR_ID_SI, sets->device, NULL);
 		if (host != NULL) {
-			if (chipset->device == 0x630) {	/* SIS630 */
+			chipset = sets;			/* Match found */
+			if (sets->device == 0x630) {	/* SIS630 */
 				u8 host_rev;
 				pci_read_config_byte(host, PCI_REVISION_ID, &host_rev);
 				if (host_rev >= 0x30)	/* 630 ET */
@@ -946,7 +948,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* Look for concealed bridges */
-	if (host == NULL) {
+	if (chipset == NULL) {
 		/* Second check */
 		u32 idemisc;
 		u16 trueid;
