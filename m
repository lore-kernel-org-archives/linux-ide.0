From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata: xfer_mask is unsigned int not unsigned long
Date: Tue,  6 Nov 2007 14:39:03 +0900
Message-ID: <11943275501285-git-send-email-htejun@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:7430 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbXKFFjQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 00:39:16 -0500
In-Reply-To: <1194327550227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

xfer_mask is unsigned int not unsigned long.  Change ->mode_filter to
take and return unsigned int.

While at it, rename @adev of ata_pci_default_filter() to @dev for
consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c       |    5 +++--
 drivers/ata/pata_acpi.c        |    2 +-
 drivers/ata/pata_ali.c         |    2 +-
 drivers/ata/pata_hpt366.c      |    2 +-
 drivers/ata/pata_hpt37x.c      |    4 ++--
 drivers/ata/pata_pdc2027x.c    |    4 ++--
 drivers/ata/pata_scc.c         |    2 +-
 drivers/ata/pata_serverworks.c |    4 ++--
 include/linux/libata.h         |    5 +++--
 9 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 48acc09..2f2ca3d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -877,12 +877,13 @@ int ata_pci_clear_simplex(struct pci_dev *pdev)
 	return 0;
 }
 
-unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
+unsigned int ata_pci_default_filter(struct ata_device *dev,
+				    unsigned int xfer_mask)
 {
 	/* Filter out DMA modes if the device has been configured by
 	   the BIOS as PIO only */
 
-	if (adev->link->ap->ioaddr.bmdma_addr == NULL)
+	if (dev->link->ap->ioaddr.bmdma_addr == NULL)
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	return xfer_mask;
 }
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index e4542ab..2323646 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -164,7 +164,7 @@ static unsigned long pacpi_discover_modes(struct ata_port *ap, struct ata_device
  *	this case the list of discovered valid modes obtained by ACPI probing
  */
 
-static unsigned long pacpi_mode_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int pacpi_mode_filter(struct ata_device *adev, unsigned int mask)
 {
 	struct pata_acpi *acpi = adev->link->ap->private_data;
 	return ata_pci_default_filter(adev, mask & acpi->mask[adev->devno]);
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 364534e..aae8a44 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -105,7 +105,7 @@ static int ali_c2_cable_detect(struct ata_port *ap)
  *	fix that later on. Also ensure we do not do UDMA on WDC drives
  */
 
-static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int ali_20_filter(struct ata_device *adev, unsigned int mask)
 {
 	char model_num[ATA_ID_PROD_LEN + 1];
 	/* No DMA on anything but a disk for now */
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 0713872..1f277d5 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -174,7 +174,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, cons
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt366_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt366_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 3816b86..37f327e 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -275,7 +275,7 @@ static const char *bad_ata100_5[] = {
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt370_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
@@ -293,7 +293,7 @@ static unsigned long hpt370_filter(struct ata_device *adev, unsigned long mask)
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt370a_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt370a_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 2622577..dd20239 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -67,7 +67,7 @@ static void pdc2027x_error_handler(struct ata_port *ap);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
-static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask);
+static unsigned int pdc2027x_mode_filter(struct ata_device *adev, unsigned int mask);
 static int pdc2027x_cable_detect(struct ata_port *ap);
 static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed);
 
@@ -336,7 +336,7 @@ static void pdc2027x_error_handler(struct ata_port *ap)
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int pdc2027x_mode_filter(struct ata_device *adev, unsigned int mask)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	struct ata_device *pair = ata_dev_pair(adev);
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index ea2ef9f..0edcdf7 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -258,7 +258,7 @@ static void scc_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 		 JCTSStbl[offset][idx] << 16 | JCENVTtbl[offset][idx]);
 }
 
-unsigned long scc_mode_filter(struct ata_device *adev, unsigned long mask)
+unsigned int scc_mode_filter(struct ata_device *adev, unsigned int mask)
 {
 	/* errata A308 workaround: limit ATAPI UDMA mode to UDMA4 */
 	if (adev->class == ATA_DEV_ATAPI &&
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 8bed888..708c789 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -195,7 +195,7 @@ static u8 serverworks_is_csb(struct pci_dev *pdev)
  *	bug we hit.
  */
 
-static unsigned long serverworks_osb4_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA)
 		mask &= ~ATA_MASK_UDMA;
@@ -211,7 +211,7 @@ static unsigned long serverworks_osb4_filter(struct ata_device *adev, unsigned l
  *	Check the blacklist and disable UDMA5 if matched
  */
 
-static unsigned long serverworks_csb_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
 {
 	const char *p;
 	char model_num[ATA_ID_PROD_LEN + 1];
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f84106a..80c711a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -668,7 +668,7 @@ struct ata_port_operations {
 
 	void (*set_piomode) (struct ata_port *, struct ata_device *);
 	void (*set_dmamode) (struct ata_port *, struct ata_device *);
-	unsigned long (*mode_filter) (struct ata_device *, unsigned long);
+	unsigned int (*mode_filter) (struct ata_device *, unsigned int);
 
 	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
@@ -989,7 +989,8 @@ extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
 				    const struct ata_port_info * const * ppi,
 				    struct ata_host **r_host);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
+extern unsigned int ata_pci_default_filter(struct ata_device *dev,
+					   unsigned int xfer_mask);
 #endif /* CONFIG_PCI */
 
 /*
-- 
1.5.2.4

