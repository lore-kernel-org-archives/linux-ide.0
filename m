From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: (2 of 2) Jmicron driver plumbing and quirk
Date: Mon, 10 Jul 2006 18:06:26 +0100
Message-ID: <1152551186.27368.164.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35038 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422692AbWGJQtB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 12:49:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

At set up time we need to switch the chip to multifunction mode so that
our PCI layer handles the transition correctly. In multi-function mode
it provides an AHCI controller for SATA and an SFF type controller for
PATA ports. In "as booted" mode it provides the ports folded onto a
single SFF type function. The jmicron driver supports both modes while
the quirk is set up to always force it into multi-function mode as per
recommendations of chip vendor. The exception is the 368 which is PATA
only and has no AHCI port. That is not handled by the quirk but is
picked up directly by the Jmicron driver.

Signed-off-by: Alan Cox <alan@redhat.com>

 # On branch refs/heads/alan

---

 drivers/pci/quirks.c  |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/Kconfig  |    8 ++++++++
 drivers/scsi/Makefile |    1 +
 3 files changed, 58 insertions(+), 0 deletions(-)

76ebb7caa7039c3145b521f71d50ec47697b6dca
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d1d7333..924b252 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1174,6 +1174,55 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
 
+#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
+
+/*
+ *	If we are using libata we can drive this chip proeprly but must
+ *	do this early on to make the additional device appear during
+ *	the PCI scanning.
+ */
+ 
+static void __devinit quirk_jmicron_dualfn(struct pci_dev *pdev)
+{
+	u32 conf;
+	u8 hdr;
+
+	/* Only poke fn 0 */	
+	if (PCI_FUNC(pdev->devfn))
+		return;
+		
+	switch(pdev->device) {
+		case PCI_DEVICE_ID_JMICRON_JMB365:
+		case PCI_DEVICE_ID_JMICRON_JMB366:
+			/* Redirect IDE second PATA port to the right spot */
+			pci_read_config_dword(pdev, 0x80, &conf);
+			conf |= (1 << 24);
+			/* Fall through */
+			pci_write_config_dword(pdev, 0x80, conf);
+		case PCI_DEVICE_ID_JMICRON_JMB361:
+		case PCI_DEVICE_ID_JMICRON_JMB363:
+			pci_read_config_dword(pdev, 0x40, &conf);
+			/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
+			/* Set the class codes correctly and then direct IDE 0 */
+			conf &= ~0x000F0200;	/* Clear bit 9 and 16-19 */
+			conf |=  0x00C20002;	/* Set bit 1, 17, 22, 23 */
+			pci_write_config_dword(pdev, 0x40, conf);
+			
+			/* Reconfigure so that the PCI scanner discovers the
+			   device is now multifunction */
+			   
+			pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
+			pdev->hdr_type = hdr & 0x7f;
+			pdev->multifunction = !!(hdr & 0x80);
+			
+			break;
+	}
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
+
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 static void __init quirk_alder_ioapic(struct pci_dev *pdev)
 {
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a6d3808..2bebb4a 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -641,6 +641,14 @@ config SCSI_PATA_IT821X
 
 	  If unsure, say N.
 
+config SCSI_ATA_JMICRON
+	tristate "JMicron non-AHCI support (Experimental)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Jmicron ATA controllers
+	  ports running in non-AHCI mode. Where possible you should
+	  set the configuration for AHCI to get better performance
+
 config SCSI_PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 56f6c7c..56bccbc 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_SCSI_PATA_HPT3X3)	+= libata
 obj-$(CONFIG_SCSI_PATA_ISAPNP)	+= libata.o pata_isapnp.o
 obj-$(CONFIG_SCSI_PATA_IT8172)	+= libata.o pata_it8172.o
 obj-$(CONFIG_SCSI_PATA_IT821X)	+= libata.o pata_it821x.o
+obj-$(CONFIG_SCSI_ATA_JMICRON)	+= libata.o ata_jmicron.o
 obj-$(CONFIG_SCSI_PATA_NETCELL)	+= libata.o pata_netcell.o
 obj-$(CONFIG_SCSI_PATA_NS87410)	+= libata.o pata_ns87410.o
 obj-$(CONFIG_SCSI_PATA_OPTI)	+= libata.o pata_opti.o
-- 
1.2.GIT


