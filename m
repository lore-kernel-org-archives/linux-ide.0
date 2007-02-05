From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream 1/2] libata: export several functions
Date: Mon, 5 Feb 2007 17:05:18 +0900
Message-ID: <20070205080518.GI1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:38508 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbXBEIFX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 03:05:23 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1534330wxd
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 00:05:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Export ata_pack_xfermask(), ata_unpack_xfermask() and
ata_mode_string().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   16 ++++++++--------
 include/linux/libata.h    |    5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -424,9 +424,8 @@ int ata_build_rw_tf(struct ata_taskfile 
  *	RETURNS:
  *	Packed xfer_mask.
  */
-static unsigned int ata_pack_xfermask(unsigned int pio_mask,
-				      unsigned int mwdma_mask,
-				      unsigned int udma_mask)
+unsigned int ata_pack_xfermask(unsigned int pio_mask, unsigned int mwdma_mask,
+			       unsigned int udma_mask)
 {
 	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
@@ -443,10 +442,8 @@ static unsigned int ata_pack_xfermask(un
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
@@ -548,7 +545,7 @@ static int ata_xfer_mode2shift(unsigned 
  *	Constant C string representing highest speed listed in
  *	@mode_mask, or the constant C string "<n/a>".
  */
-static const char *ata_mode_string(unsigned int xfer_mask)
+const char *ata_mode_string(unsigned int xfer_mask)
 {
 	static const char * const xfer_mode_str[] = {
 		"PIO0",
@@ -6323,6 +6320,9 @@ EXPORT_SYMBOL_GPL(ata_noop_dev_select);
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
+EXPORT_SYMBOL_GPL(ata_pack_xfermask);
+EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
+EXPORT_SYMBOL_GPL(ata_mode_string);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_altstatus);
 EXPORT_SYMBOL_GPL(ata_exec_command);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -761,6 +761,11 @@ extern void ata_tf_load(struct ata_port 
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
+			unsigned int mwdma_mask, unsigned int udma_mask);
+extern void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
+			unsigned int *mwdma_mask, unsigned int *udma_mask);
+extern const char *ata_mode_string(unsigned int xfer_mask);
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
