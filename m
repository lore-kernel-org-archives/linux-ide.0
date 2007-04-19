From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sis: Fix oops on boot
Date: Thu, 19 Apr 2007 11:09:52 +0100
Message-ID: <20070419110952.13470b08@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57735 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161479AbXDSKGr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Apr 2007 06:06:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

A small number of SiS setups require special handling (not many judging
by how long this dumb bug survived). A couple of Fedora 7 devel testers
hit an Oops on pata_sis loading which is caused by terminal confusion
between chipset as 'the chipset we have found' and chipset as 'array
iterator'

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.21-rc6-mm1/drivers/ata/pata_sis.c	2007-04-12 14:15:03.000000000 +0100
+++ linux-2.6.21-rc6-mm1/drivers/ata/pata_sis.c	2007-04-19 10:42:36.966672184 +0100
@@ -831,6 +831,7 @@
 	struct ata_port_info *port;
 	struct pci_dev *host = NULL;
 	struct sis_chipset *chipset = NULL;
+	struct sis_chipset *sets;
 
 	static struct sis_chipset sis_chipsets[] = {
 
@@ -885,10 +886,11 @@
 
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
@@ -899,7 +901,7 @@
 	}
 
 	/* Look for concealed bridges */
-	if (host == NULL) {
+	if (chipset == NULL) {
 		/* Second check */
 		u32 idemisc;
 		u16 trueid;
