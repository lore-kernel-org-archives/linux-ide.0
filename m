Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823CBC43334
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbiFNTwL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349115AbiFNTwH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 15:52:07 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9C35846
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 12:52:01 -0700 (PDT)
Received: from [192.168.1.103] (31.173.81.88) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 14 Jun
 2022 22:51:52 +0300
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: make transfer mode masks *unsigned int*
Organization: Open Mobile Platform
Message-ID: <e958e03f-0cb0-e457-33d3-6700d0eb709e@omp.ru>
Date:   Tue, 14 Jun 2022 22:51:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.81.88]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/14/2022 19:35:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171111 [Jun 14 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.88 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;31.173.81.88:7.4.1,7.7.3
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.88
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/14/2022 19:38:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/14/2022 2:31:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The packed transfer mode masks and also the {pio|mwdma|udma}_mask fields
of *struct*s ata_device and ata_port_info are declared as *unsigned long*
(which is a 64-bit type on 64-bit architectures) but actually the packed
masks occupy only 20 bits (7 PIO modes, 5 MWDMA modes, and 8 UDMA modes)
and the PIO/MWDMA/UDMA masks easily fit into just 8 bits each, so we can
safely use (always 32-bit) *unsigned int* variables instead.  This saves
745 bytes of object code in libata-core.o alone, not to mention LLDDs...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

 drivers/ata/libata-acpi.c      |    8 +++---
 drivers/ata/libata-core.c      |   38 +++++++++++++++----------------
 drivers/ata/pata_acpi.c        |    2 -
 drivers/ata/pata_ali.c         |    2 -
 drivers/ata/pata_amd.c         |   14 +++++------
 drivers/ata/pata_hpt366.c      |    2 -
 drivers/ata/pata_hpt37x.c      |    6 ++---
 drivers/ata/pata_hpt3x2n.c     |    2 -
 drivers/ata/pata_pdc2027x.c    |    4 +--
 drivers/ata/pata_serverworks.c |    4 +--
 drivers/ata/pata_sis.c         |    2 -
 drivers/ata/pata_via.c         |    2 -
 include/linux/libata.h         |   49 ++++++++++++++++++++---------------------
 13 files changed, 67 insertions(+), 68 deletions(-)

Index: libata/drivers/ata/libata-acpi.c
===================================================================
--- libata.orig/drivers/ata/libata-acpi.c
+++ libata/drivers/ata/libata-acpi.c
@@ -480,10 +480,10 @@ static int ata_dev_get_GTF(struct ata_de
  * RETURNS:
  * Determined xfermask.
  */
-unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
-				    const struct ata_acpi_gtm *gtm)
+unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
+				   const struct ata_acpi_gtm *gtm)
 {
-	unsigned long xfer_mask = 0;
+	unsigned int xfer_mask = 0;
 	unsigned int type;
 	int unit;
 	u8 mode;
@@ -525,7 +525,7 @@ int ata_acpi_cbl_80wire(struct ata_port
 	struct ata_device *dev;
 
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
-		unsigned long xfer_mask, udma_mask;
+		unsigned int xfer_mask, udma_mask;
 
 		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
 		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -93,7 +93,7 @@ struct ata_force_param {
 	const char	*name;
 	u8		cbl;
 	u8		spd_limit;
-	unsigned long	xfer_mask;
+	unsigned int	xfer_mask;
 	unsigned int	horkage_on;
 	unsigned int	horkage_off;
 	u16		lflags_on;
@@ -425,7 +425,7 @@ static void ata_force_xfermask(struct at
 
 	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
 		const struct ata_force_ent *fe = &ata_force_tbl[i];
-		unsigned long pio_mask, mwdma_mask, udma_mask;
+		unsigned int pio_mask, mwdma_mask, udma_mask;
 
 		if (fe->port != -1 && fe->port != dev->link->ap->print_id)
 			continue;
@@ -803,11 +803,11 @@ int ata_build_rw_tf(struct ata_taskfile
  *	RETURNS:
  *	Packed xfer_mask.
  */
-unsigned long ata_pack_xfermask(unsigned long pio_mask,
-				unsigned long mwdma_mask,
-				unsigned long udma_mask)
+unsigned int ata_pack_xfermask(unsigned int pio_mask,
+			       unsigned int mwdma_mask,
+			       unsigned int udma_mask)
 {
-	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
+	return	((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
 		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
 }
@@ -823,8 +823,8 @@ EXPORT_SYMBOL_GPL(ata_pack_xfermask);
  *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
  *	Any NULL destination masks will be ignored.
  */
-void ata_unpack_xfermask(unsigned long xfer_mask, unsigned long *pio_mask,
-			 unsigned long *mwdma_mask, unsigned long *udma_mask)
+void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
+			 unsigned int *mwdma_mask, unsigned int *udma_mask)
 {
 	if (pio_mask)
 		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
@@ -857,7 +857,7 @@ static const struct ata_xfer_ent {
  *	RETURNS:
  *	Matching XFER_* value, 0xff if no match found.
  */
-u8 ata_xfer_mask2mode(unsigned long xfer_mask)
+u8 ata_xfer_mask2mode(unsigned int xfer_mask)
 {
 	int highbit = fls(xfer_mask) - 1;
 	const struct ata_xfer_ent *ent;
@@ -881,7 +881,7 @@ EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
  *	RETURNS:
  *	Matching xfer_mask, 0 if no match found.
  */
-unsigned long ata_xfer_mode2mask(u8 xfer_mode)
+unsigned int ata_xfer_mode2mask(u8 xfer_mode)
 {
 	const struct ata_xfer_ent *ent;
 
@@ -930,7 +930,7 @@ EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
  *	Constant C string representing highest speed listed in
  *	@mode_mask, or the constant C string "<n/a>".
  */
-const char *ata_mode_string(unsigned long xfer_mask)
+const char *ata_mode_string(unsigned int xfer_mask)
 {
 	static const char * const xfer_mode_str[] = {
 		"PIO0",
@@ -1383,9 +1383,9 @@ static inline void ata_dump_id(struct at
  *	RETURNS:
  *	Computed xfermask
  */
-unsigned long ata_id_xfermask(const u16 *id)
+unsigned int ata_id_xfermask(const u16 *id)
 {
-	unsigned long pio_mask, mwdma_mask, udma_mask;
+	unsigned int pio_mask, mwdma_mask, udma_mask;
 
 	/* Usual case. Word 53 indicates word 64 is valid */
 	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
@@ -2534,7 +2534,7 @@ int ata_dev_configure(struct ata_device
 	struct ata_port *ap = dev->link->ap;
 	bool print_info = ata_dev_print_info(dev);
 	const u16 *id = dev->id;
-	unsigned long xfer_mask;
+	unsigned int xfer_mask;
 	unsigned int err_mask;
 	char revbuf[7];		/* XYZ-99\0 */
 	char fwrevbuf[ATA_ID_FW_REV_LEN+1];
@@ -3202,8 +3202,8 @@ u8 ata_timing_cycle2mode(unsigned int xf
 int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 {
 	char buf[32];
-	unsigned long orig_mask, xfer_mask;
-	unsigned long pio_mask, mwdma_mask, udma_mask;
+	unsigned int orig_mask, xfer_mask;
+	unsigned int pio_mask, mwdma_mask, udma_mask;
 	int quiet, highbit;
 
 	quiet = !!(sel & ATA_DNXFER_QUIET);
@@ -3381,7 +3381,7 @@ int ata_do_set_mode(struct ata_link *lin
 
 	/* step 1: calculate xfer_mask */
 	ata_for_each_dev(dev, link, ENABLED) {
-		unsigned long pio_mask, dma_mask;
+		unsigned int pio_mask, dma_mask;
 		unsigned int mode_mask;
 
 		mode_mask = ATA_DMA_MASK_ATA;
@@ -4217,7 +4217,7 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
 	struct ata_host *host = ap->host;
-	unsigned long xfer_mask;
+	unsigned int xfer_mask;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -5776,7 +5776,7 @@ int ata_host_register(struct ata_host *h
 	/* set cable, sata_spd_limit and report */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		unsigned long xfer_mask;
+		unsigned int xfer_mask;
 
 		/* set SATA cable type if still unset */
 		if (ap->cbl == ATA_CBL_NONE && (ap->flags & ATA_FLAG_SATA))
Index: libata/drivers/ata/pata_acpi.c
===================================================================
--- libata.orig/drivers/ata/pata_acpi.c
+++ libata/drivers/ata/pata_acpi.c
@@ -97,7 +97,7 @@ static unsigned long pacpi_discover_mode
  *	this case the list of discovered valid modes obtained by ACPI probing
  */
 
-static unsigned long pacpi_mode_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int pacpi_mode_filter(struct ata_device *adev, unsigned int mask)
 {
 	struct pata_acpi *acpi = adev->link->ap->private_data;
 	return mask & acpi->mask[adev->devno];
Index: libata/drivers/ata/pata_ali.c
===================================================================
--- libata.orig/drivers/ata/pata_ali.c
+++ libata/drivers/ata/pata_ali.c
@@ -115,7 +115,7 @@ static int ali_c2_cable_detect(struct at
  *	fix that later on. Also ensure we do not do UDMA on WDC drives
  */
 
-static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int ali_20_filter(struct ata_device *adev, unsigned int mask)
 {
 	char model_num[ATA_ID_PROD_LEN + 1];
 	/* No DMA on anything but a disk for now */
Index: libata/drivers/ata/pata_amd.c
===================================================================
--- libata.orig/drivers/ata/pata_amd.c
+++ libata/drivers/ata/pata_amd.c
@@ -264,8 +264,8 @@ static void amd133_set_dmamode(struct at
  * cached during driver attach and are consulted to select transfer
  * mode.
  */
-static unsigned long nv_mode_filter(struct ata_device *dev,
-				    unsigned long xfer_mask)
+static unsigned int nv_mode_filter(struct ata_device *dev,
+				   unsigned int xfer_mask)
 {
 	static const unsigned int udma_mask_map[] =
 		{ ATA_UDMA2, ATA_UDMA1, ATA_UDMA0, 0,
@@ -274,7 +274,7 @@ static unsigned long nv_mode_filter(stru
 	char acpi_str[32] = "";
 	u32 saved_udma, udma;
 	const struct ata_acpi_gtm *gtm;
-	unsigned long bios_limit = 0, acpi_limit = 0, limit;
+	unsigned int bios_limit = 0, acpi_limit = 0, limit;
 
 	/* find out what BIOS configured */
 	udma = saved_udma = (unsigned long)ap->host->private_data;
@@ -310,10 +310,10 @@ static unsigned long nv_mode_filter(stru
 	   cable detection result */
 	limit |= ata_pack_xfermask(ATA_PIO4, ATA_MWDMA2, ATA_UDMA2);
 
-	ata_port_dbg(ap, "nv_mode_filter: 0x%lx&0x%lx->0x%lx, "
-			"BIOS=0x%lx (0x%x) ACPI=0x%lx%s\n",
-			xfer_mask, limit, xfer_mask & limit, bios_limit,
-			saved_udma, acpi_limit, acpi_str);
+	ata_port_dbg(ap,
+		     "nv_mode_filter: 0x%x&0x%x->0x%x, BIOS=0x%x (0x%x) ACPI=0x%x%s\n",
+		     xfer_mask, limit, xfer_mask & limit, bios_limit,
+		     saved_udma, acpi_limit, acpi_str);
 
 	return xfer_mask & limit;
 }
Index: libata/drivers/ata/pata_hpt366.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt366.c
+++ libata/drivers/ata/pata_hpt366.c
@@ -194,7 +194,7 @@ static int hpt_dma_blacklisted(const str
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt366_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt366_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
Index: libata/drivers/ata/pata_hpt37x.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt37x.c
+++ libata/drivers/ata/pata_hpt37x.c
@@ -278,7 +278,7 @@ static const char * const bad_ata100_5[]
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt370_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
@@ -297,7 +297,7 @@ static unsigned long hpt370_filter(struc
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt370a_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt370a_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
@@ -314,7 +314,7 @@ static unsigned long hpt370a_filter(stru
  *	The Marvell bridge chips used on the HighPoint SATA cards do not seem
  *	to support the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes...
  */
-static unsigned long hpt372_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt372_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (ata_id_is_sata(adev->id))
 		mask &= ~((0xE << ATA_SHIFT_UDMA) | ATA_MASK_MWDMA);
Index: libata/drivers/ata/pata_hpt3x2n.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt3x2n.c
+++ libata/drivers/ata/pata_hpt3x2n.c
@@ -113,7 +113,7 @@ static u32 hpt3x2n_find_mode(struct ata_
  *	The Marvell bridge chips used on the HighPoint SATA cards do not seem
  *	to support the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes...
  */
-static unsigned long hpt372n_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int hpt372n_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (ata_id_is_sata(adev->id))
 		mask &= ~((0xE << ATA_SHIFT_UDMA) | ATA_MASK_MWDMA);
Index: libata/drivers/ata/pata_pdc2027x.c
===================================================================
--- libata.orig/drivers/ata/pata_pdc2027x.c
+++ libata/drivers/ata/pata_pdc2027x.c
@@ -57,7 +57,7 @@ static int pdc2027x_prereset(struct ata_
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
-static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask);
+static unsigned int pdc2027x_mode_filter(struct ata_device *adev, unsigned int mask);
 static int pdc2027x_cable_detect(struct ata_port *ap);
 static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed);
 
@@ -251,7 +251,7 @@ static int pdc2027x_prereset(struct ata_
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int pdc2027x_mode_filter(struct ata_device *adev, unsigned int mask)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	struct ata_device *pair = ata_dev_pair(adev);
Index: libata/drivers/ata/pata_serverworks.c
===================================================================
--- libata.orig/drivers/ata/pata_serverworks.c
+++ libata/drivers/ata/pata_serverworks.c
@@ -150,7 +150,7 @@ static u8 serverworks_is_csb(struct pci_
  *	bug we hit.
  */
 
-static unsigned long serverworks_osb4_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned int mask)
 {
 	if (adev->class == ATA_DEV_ATA)
 		mask &= ~ATA_MASK_UDMA;
@@ -166,7 +166,7 @@ static unsigned long serverworks_osb4_fi
  *	Check the blacklist and disable UDMA5 if matched
  */
 
-static unsigned long serverworks_csb_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
 {
 	const char *p;
 	char model_num[ATA_ID_PROD_LEN + 1];
Index: libata/drivers/ata/pata_sis.c
===================================================================
--- libata.orig/drivers/ata/pata_sis.c
+++ libata/drivers/ata/pata_sis.c
@@ -525,7 +525,7 @@ static void sis_133_set_dmamode (struct
  *	Block UDMA6 on devices that do not support it.
  */
 
-static unsigned long sis_133_mode_filter(struct ata_device *adev, unsigned long mask)
+static unsigned int sis_133_mode_filter(struct ata_device *adev, unsigned int mask)
 {
 	struct ata_port *ap = adev->link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
Index: libata/drivers/ata/pata_via.c
===================================================================
--- libata.orig/drivers/ata/pata_via.c
+++ libata/drivers/ata/pata_via.c
@@ -352,7 +352,7 @@ static void via_set_dmamode(struct ata_p
  *	one breed of Transcend SSD. Return the updated mask.
  */
 
-static unsigned long via_mode_filter(struct ata_device *dev, unsigned long mask)
+static unsigned int via_mode_filter(struct ata_device *dev, unsigned int mask)
 {
 	struct ata_host *host = dev->link->ap->host;
 	const struct via_isa_bridge *config = host->private_data;
Index: libata/include/linux/libata.h
===================================================================
--- libata.orig/include/linux/libata.h
+++ libata/include/linux/libata.h
@@ -275,7 +275,7 @@ enum {
 	PORT_DISABLED		= 2,
 
 	/* encoding various smaller bitmaps into a single
-	 * unsigned long bitmap
+	 * unsigned int bitmap
 	 */
 	ATA_NR_PIO_MODES	= 7,
 	ATA_NR_MWDMA_MODES	= 5,
@@ -426,12 +426,9 @@ enum {
 };
 
 enum ata_xfer_mask {
-	ATA_MASK_PIO		= ((1LU << ATA_NR_PIO_MODES) - 1)
-					<< ATA_SHIFT_PIO,
-	ATA_MASK_MWDMA		= ((1LU << ATA_NR_MWDMA_MODES) - 1)
-					<< ATA_SHIFT_MWDMA,
-	ATA_MASK_UDMA		= ((1LU << ATA_NR_UDMA_MODES) - 1)
-					<< ATA_SHIFT_UDMA,
+	ATA_MASK_PIO		= ((1U << ATA_NR_PIO_MODES) - 1) << ATA_SHIFT_PIO,
+	ATA_MASK_MWDMA		= ((1U << ATA_NR_MWDMA_MODES) - 1) << ATA_SHIFT_MWDMA,
+	ATA_MASK_UDMA		= ((1U << ATA_NR_UDMA_MODES) - 1) << ATA_SHIFT_UDMA,
 };
 
 enum hsm_task_states {
@@ -680,9 +677,9 @@ struct ata_device {
 	unsigned int		cdb_len;
 
 	/* per-dev xfer mask */
-	unsigned long		pio_mask;
-	unsigned long		mwdma_mask;
-	unsigned long		udma_mask;
+	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
+	unsigned int		udma_mask;
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
@@ -885,7 +882,7 @@ struct ata_port_operations {
 	 * Configuration and exception handling
 	 */
 	int  (*cable_detect)(struct ata_port *ap);
-	unsigned long (*mode_filter)(struct ata_device *dev, unsigned long xfer_mask);
+	unsigned int (*mode_filter)(struct ata_device *dev, unsigned int xfer_mask);
 	void (*set_piomode)(struct ata_port *ap, struct ata_device *dev);
 	void (*set_dmamode)(struct ata_port *ap, struct ata_device *dev);
 	int  (*set_mode)(struct ata_link *link, struct ata_device **r_failed_dev);
@@ -981,9 +978,9 @@ struct ata_port_operations {
 struct ata_port_info {
 	unsigned long		flags;
 	unsigned long		link_flags;
-	unsigned long		pio_mask;
-	unsigned long		mwdma_mask;
-	unsigned long		udma_mask;
+	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
+	unsigned int		udma_mask;
 	struct ata_port_operations *port_ops;
 	void 			*private_data;
 };
@@ -1102,16 +1099,18 @@ extern void ata_msleep(struct ata_port *
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
 			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
-extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
-			unsigned long mwdma_mask, unsigned long udma_mask);
-extern void ata_unpack_xfermask(unsigned long xfer_mask,
-			unsigned long *pio_mask, unsigned long *mwdma_mask,
-			unsigned long *udma_mask);
-extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
-extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
+extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
+				      unsigned int mwdma_mask,
+				      unsigned int udma_mask);
+extern void ata_unpack_xfermask(unsigned int xfer_mask,
+				unsigned int *pio_mask,
+				unsigned int *mwdma_mask,
+				unsigned int *udma_mask);
+extern u8 ata_xfer_mask2mode(unsigned int xfer_mask);
+extern unsigned int ata_xfer_mode2mask(u8 xfer_mode);
 extern int ata_xfer_mode2shift(u8 xfer_mode);
-extern const char *ata_mode_string(unsigned long xfer_mask);
-extern unsigned long ata_id_xfermask(const u16 *id);
+extern const char *ata_mode_string(unsigned int xfer_mask);
+extern unsigned int ata_id_xfermask(const u16 *id);
 extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -1283,8 +1282,8 @@ static inline const struct ata_acpi_gtm
 }
 int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
-unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
-				    const struct ata_acpi_gtm *gtm);
+unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
+				   const struct ata_acpi_gtm *gtm);
 int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm);
 #else
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
