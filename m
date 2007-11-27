From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata: xfer_mask is unsigned long not unsigned int
Date: Tue, 27 Nov 2007 19:43:42 +0900
Message-ID: <11961602302673-git-send-email-htejun@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:40853 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbXK0KoB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:44:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so840800rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:44:01 -0800 (PST)
In-Reply-To: <11961602293422-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Jeff says xfer_mask is unsigned long not unsigned int.  Convert all
xfermask fields and handling functions to deal with unsigned longs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   29 ++++++++++++++-------------
 include/linux/libata.h    |   46 ++++++++++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88ed491..53caad7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -453,8 +453,9 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
  *	RETURNS:
  *	Packed xfer_mask.
  */
-unsigned int ata_pack_xfermask(unsigned int pio_mask,
-			       unsigned int mwdma_mask, unsigned int udma_mask)
+unsigned long ata_pack_xfermask(unsigned long pio_mask,
+				unsigned long mwdma_mask,
+				unsigned long udma_mask)
 {
 	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
@@ -471,8 +472,8 @@ unsigned int ata_pack_xfermask(unsigned int pio_mask,
  *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
  *	Any NULL distination masks will be ignored.
  */
-void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
-			 unsigned int *mwdma_mask, unsigned int *udma_mask)
+void ata_unpack_xfermask(unsigned long xfer_mask, unsigned long *pio_mask,
+			 unsigned long *mwdma_mask, unsigned long *udma_mask)
 {
 	if (pio_mask)
 		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
@@ -505,7 +506,7 @@ static const struct ata_xfer_ent {
  *	RETURNS:
  *	Matching XFER_* value, 0xff if no match found.
  */
-u8 ata_xfer_mask2mode(unsigned int xfer_mask)
+u8 ata_xfer_mask2mode(unsigned long xfer_mask)
 {
 	int highbit = fls(xfer_mask) - 1;
 	const struct ata_xfer_ent *ent;
@@ -528,7 +529,7 @@ u8 ata_xfer_mask2mode(unsigned int xfer_mask)
  *	RETURNS:
  *	Matching xfer_mask, 0 if no match found.
  */
-unsigned int ata_xfer_mode2mask(u8 xfer_mode)
+unsigned long ata_xfer_mode2mask(u8 xfer_mode)
 {
 	const struct ata_xfer_ent *ent;
 
@@ -551,7 +552,7 @@ unsigned int ata_xfer_mode2mask(u8 xfer_mode)
  *	RETURNS:
  *	Matching xfer_shift, -1 if no match found.
  */
-int ata_xfer_mode2shift(unsigned int xfer_mode)
+int ata_xfer_mode2shift(unsigned long xfer_mode)
 {
 	const struct ata_xfer_ent *ent;
 
@@ -575,7 +576,7 @@ int ata_xfer_mode2shift(unsigned int xfer_mode)
  *	Constant C string representing highest speed listed in
  *	@mode_mask, or the constant C string "<n/a>".
  */
-const char *ata_mode_string(unsigned int xfer_mask)
+const char *ata_mode_string(unsigned long xfer_mask)
 {
 	static const char * const xfer_mode_str[] = {
 		"PIO0",
@@ -1422,9 +1423,9 @@ static inline void ata_dump_id(const u16 *id)
  *	RETURNS:
  *	Computed xfermask
  */
-unsigned int ata_id_xfermask(const u16 *id)
+unsigned long ata_id_xfermask(const u16 *id)
 {
-	unsigned int pio_mask, mwdma_mask, udma_mask;
+	unsigned long pio_mask, mwdma_mask, udma_mask;
 
 	/* Usual case. Word 53 indicates word 64 is valid */
 	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
@@ -2048,7 +2049,7 @@ int ata_dev_configure(struct ata_device *dev)
 	struct ata_eh_context *ehc = &dev->link->eh_context;
 	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
 	const u16 *id = dev->id;
-	unsigned int xfer_mask;
+	unsigned long xfer_mask;
 	char revbuf[7];		/* XYZ-99\0 */
 	char fwrevbuf[ATA_ID_FW_REV_LEN+1];
 	char modelbuf[ATA_ID_PROD_LEN+1];
@@ -2905,8 +2906,8 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 {
 	char buf[32];
-	unsigned int orig_mask, xfer_mask;
-	unsigned int pio_mask, mwdma_mask, udma_mask;
+	unsigned long orig_mask, xfer_mask;
+	unsigned long pio_mask, mwdma_mask, udma_mask;
 	int quiet, highbit;
 
 	quiet = !!(sel & ATA_DNXFER_QUIET);
@@ -3050,7 +3051,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 
 	/* step 1: calculate xfer_mask */
 	ata_link_for_each_dev(dev, link) {
-		unsigned int pio_mask, dma_mask;
+		unsigned long pio_mask, dma_mask;
 		unsigned int mode_mask;
 
 		if (!ata_dev_enabled(dev))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 006183e..f01722e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -265,7 +265,7 @@ enum {
 	PORT_DISABLED		= 2,
 
 	/* encoding various smaller bitmaps into a single
-	 * unsigned int bitmap
+	 * unsigned long bitmap
 	 */
 	ATA_NR_PIO_MODES	= 7,
 	ATA_NR_MWDMA_MODES	= 5,
@@ -275,13 +275,6 @@ enum {
 	ATA_SHIFT_MWDMA		= ATA_SHIFT_PIO + ATA_NR_PIO_MODES,
 	ATA_SHIFT_UDMA		= ATA_SHIFT_MWDMA + ATA_NR_MWDMA_MODES,
 
-	ATA_MASK_PIO		= ((1 << ATA_NR_PIO_MODES) - 1)
-					<< ATA_SHIFT_PIO,
-	ATA_MASK_MWDMA		= ((1 << ATA_NR_MWDMA_MODES) - 1)
-					<< ATA_SHIFT_MWDMA,
-	ATA_MASK_UDMA		= ((1 << ATA_NR_UDMA_MODES) - 1)
-					<< ATA_SHIFT_UDMA,
-
 	/* size of buffer to pad xfers ending on unaligned boundaries */
 	ATA_DMA_PAD_SZ		= 4,
 	ATA_DMA_PAD_BUF_SZ	= ATA_DMA_PAD_SZ * ATA_MAX_QUEUE,
@@ -353,6 +346,15 @@ enum {
 	ATA_DMA_MASK_CFA	= (1 << 2),	/* DMA on CF Card */
 };
 
+enum ata_xfer_mask {
+	ATA_MASK_PIO		= ((1LU << ATA_NR_PIO_MODES) - 1)
+					<< ATA_SHIFT_PIO,
+	ATA_MASK_MWDMA		= ((1LU << ATA_NR_MWDMA_MODES) - 1)
+					<< ATA_SHIFT_MWDMA,
+	ATA_MASK_UDMA		= ((1LU << ATA_NR_UDMA_MODES) - 1)
+					<< ATA_SHIFT_UDMA,
+};
+
 enum hsm_task_states {
 	HSM_ST_IDLE,		/* no command on going */
 	HSM_ST_FIRST,		/* (waiting the device to)
@@ -523,9 +525,9 @@ struct ata_device {
 	unsigned int		cdb_len;
 
 	/* per-dev xfer mask */
-	unsigned int		pio_mask;
-	unsigned int		mwdma_mask;
-	unsigned int		udma_mask;
+	unsigned long		pio_mask;
+	unsigned long		mwdma_mask;
+	unsigned long		udma_mask;
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
@@ -851,15 +853,16 @@ extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
-extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
-			unsigned int mwdma_mask, unsigned int udma_mask);
-extern void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
-			unsigned int *mwdma_mask, unsigned int *udma_mask);
-extern u8 ata_xfer_mask2mode(unsigned int xfer_mask);
-extern unsigned int ata_xfer_mode2mask(u8 xfer_mode);
-extern int ata_xfer_mode2shift(unsigned int xfer_mode);
-extern const char *ata_mode_string(unsigned int xfer_mask);
-extern unsigned int ata_id_xfermask(const u16 *id);
+extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
+			unsigned long mwdma_mask, unsigned long udma_mask);
+extern void ata_unpack_xfermask(unsigned long xfer_mask,
+			unsigned long *pio_mask, unsigned long *mwdma_mask,
+			unsigned long *udma_mask);
+extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
+extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
+extern int ata_xfer_mode2shift(unsigned long xfer_mode);
+extern const char *ata_mode_string(unsigned long xfer_mask);
+extern unsigned long ata_id_xfermask(const u16 *id);
 extern void ata_noop_dev_select(struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select(struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
@@ -988,7 +991,8 @@ extern int ata_pci_prepare_sff_host(struct pci_dev *pdev,
 				    const struct ata_port_info * const * ppi,
 				    struct ata_host **r_host);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
+extern unsigned long ata_pci_default_filter(struct ata_device *dev,
+					    unsigned long xfer_mask);
 #endif /* CONFIG_PCI */
 
 /*
-- 
1.5.2.4

