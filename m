From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata: export xfermode / PATA timing related functions
Date: Tue, 27 Nov 2007 19:43:39 +0900
Message-ID: <11961602301216-git-send-email-htejun@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:40853 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXK0Kn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:43:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so840800rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:43:58 -0800 (PST)
In-Reply-To: <11961602293422-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Export the following xfermode related functions.

* ata_pack_xfermask()
* ata_unpack_xfermask()
* ata_xfer_mask2mode()
* ata_xfer_mode2mask()
* ata_xfer_mode2shift()
* ata_mode_string()
* ata_id_xfermask()
* ata_timing_find_mode()

These functions will be used later by LLD updates.  While at it,
change unsigned short @speed to u8 @xfer_mode in
ata_timing_find_mode() for consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   33 +++++++++++++++++++--------------
 include/linux/libata.h    |   10 ++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fe453c7..6077dc1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -453,9 +453,8 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
  *	RETURNS:
  *	Packed xfer_mask.
  */
-static unsigned int ata_pack_xfermask(unsigned int pio_mask,
-				      unsigned int mwdma_mask,
-				      unsigned int udma_mask)
+unsigned int ata_pack_xfermask(unsigned int pio_mask,
+			       unsigned int mwdma_mask, unsigned int udma_mask)
 {
 	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
@@ -472,10 +471,8 @@ static unsigned int ata_pack_xfermask(unsigned int pio_mask,
  *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
  *	Any NULL distination masks will be ignored.
  */
-static void ata_unpack_xfermask(unsigned int xfer_mask,
-				unsigned int *pio_mask,
-				unsigned int *mwdma_mask,
-				unsigned int *udma_mask)
+void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
+			 unsigned int *mwdma_mask, unsigned int *udma_mask)
 {
 	if (pio_mask)
 		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
@@ -508,7 +505,7 @@ static const struct ata_xfer_ent {
  *	RETURNS:
  *	Matching XFER_* value, 0 if no match found.
  */
-static u8 ata_xfer_mask2mode(unsigned int xfer_mask)
+u8 ata_xfer_mask2mode(unsigned int xfer_mask)
 {
 	int highbit = fls(xfer_mask) - 1;
 	const struct ata_xfer_ent *ent;
@@ -531,7 +528,7 @@ static u8 ata_xfer_mask2mode(unsigned int xfer_mask)
  *	RETURNS:
  *	Matching xfer_mask, 0 if no match found.
  */
-static unsigned int ata_xfer_mode2mask(u8 xfer_mode)
+unsigned int ata_xfer_mode2mask(u8 xfer_mode)
 {
 	const struct ata_xfer_ent *ent;
 
@@ -553,7 +550,7 @@ static unsigned int ata_xfer_mode2mask(u8 xfer_mode)
  *	RETURNS:
  *	Matching xfer_shift, -1 if no match found.
  */
-static int ata_xfer_mode2shift(unsigned int xfer_mode)
+int ata_xfer_mode2shift(unsigned int xfer_mode)
 {
 	const struct ata_xfer_ent *ent;
 
@@ -577,7 +574,7 @@ static int ata_xfer_mode2shift(unsigned int xfer_mode)
  *	Constant C string representing highest speed listed in
  *	@mode_mask, or the constant C string "<n/a>".
  */
-static const char *ata_mode_string(unsigned int xfer_mask)
+const char *ata_mode_string(unsigned int xfer_mask)
 {
 	static const char * const xfer_mode_str[] = {
 		"PIO0",
@@ -1466,7 +1463,7 @@ static inline void ata_dump_id(const u16 *id)
  *	RETURNS:
  *	Computed xfermask
  */
-static unsigned int ata_id_xfermask(const u16 *id)
+unsigned int ata_id_xfermask(const u16 *id)
 {
 	unsigned int pio_mask, mwdma_mask, udma_mask;
 
@@ -2853,11 +2850,11 @@ void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
 	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
 
-static const struct ata_timing *ata_timing_find_mode(unsigned short speed)
+const struct ata_timing *ata_timing_find_mode(u8 xfer_mode)
 {
 	const struct ata_timing *t;
 
-	for (t = ata_timing; t->mode != speed; t++)
+	for (t = ata_timing; t->mode != xfer_mode; t++)
 		if (t->mode == 0xFF)
 			return NULL;
 	return t;
@@ -7557,6 +7554,13 @@ EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(sata_print_link_status);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
+EXPORT_SYMBOL_GPL(ata_pack_xfermask);
+EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
+EXPORT_SYMBOL_GPL(ata_xfer_mask2mode);
+EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
+EXPORT_SYMBOL_GPL(ata_xfer_mode2shift);
+EXPORT_SYMBOL_GPL(ata_mode_string);
+EXPORT_SYMBOL_GPL(ata_id_xfermask);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
@@ -7622,6 +7626,7 @@ EXPORT_SYMBOL_GPL(ata_id_to_dma_mode);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
+EXPORT_SYMBOL_GPL(ata_timing_find_mode);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
 EXPORT_SYMBOL_GPL(ata_timing_merge);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a1b47d8..12d62df 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -848,6 +848,15 @@ extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
+			unsigned int mwdma_mask, unsigned int udma_mask);
+extern void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
+			unsigned int *mwdma_mask, unsigned int *udma_mask);
+extern u8 ata_xfer_mask2mode(unsigned int xfer_mask);
+extern unsigned int ata_xfer_mode2mask(u8 xfer_mode);
+extern int ata_xfer_mode2shift(unsigned int xfer_mode);
+extern const char *ata_mode_string(unsigned int xfer_mask);
+extern unsigned int ata_id_xfermask(const u16 *id);
 extern void ata_noop_dev_select(struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select(struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
@@ -917,6 +926,7 @@ extern int ata_cable_unknown(struct ata_port *ap);
  */
 
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
+extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
 extern int ata_timing_compute(struct ata_device *, unsigned short,
 			      struct ata_timing *, int, int);
 extern void ata_timing_merge(const struct ata_timing *,
-- 
1.5.2.4

