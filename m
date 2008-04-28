From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 2/2 UPDATED] libata-scsi: improve rbuf handling
 for simulated commands
Date: Mon, 28 Apr 2008 17:48:51 +0900
Message-ID: <48158F73.7010104@gmail.com>
References: <481587F4.6090006@gmail.com>	<48158826.8070209@gmail.com> <20080428173834Z.tomof@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.241]:63038 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752990AbYD1Is7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 04:48:59 -0400
Received: by rv-out-0506.google.com with SMTP id k29so2859132rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 01:48:58 -0700 (PDT)
In-Reply-To: <20080428173834Z.tomof@acm.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, petr@vmware.com

Buffer length handling in simulated commands is error-prone and full
of bugs.  There are a number of places where necessary length checks
are missing and if the output buffer is passed in as sglist, nothing
works.

This patch adds a static buffer ata_scsi_rbuf which is sufficiently
large to handle the larges output from simulated commands (4k
currently), let all simulte functions write to the buffer and removes
all length checks as we know that there always is enough buffer space.
Copying in (for ATAPI inquiry fix up) and out are handled by
sg_copy_to/from_buffer() behind ata_scsi_rbuf_get/put() interface
which handles sglist properly.

This patch is inspired from buffer length check fix patch from Petr
Vandrovec.

Updated to use sg_copy_to/from_buffer() as suggested by FUJITA
Tomonori.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Petr Vandrovec <petr@vmware.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 drivers/ata/libata-scsi.c |  446 +++++++++++++++-------------------------------
 1 file changed, 155 insertions(+), 291 deletions(-)

Didn't know about those helpers.  Thanks a lot for point it out.

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -49,7 +49,11 @@
 
 #include "libata.h"
 
-#define SECTOR_SIZE	512
+#define SECTOR_SIZE		512
+#define ATA_SCSI_RBUF_SIZE	4096
+
+static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
+static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
@@ -1639,53 +1643,48 @@ defer:
 
 /**
  *	ata_scsi_rbuf_get - Map response buffer.
- *	@cmd: SCSI command containing buffer to be mapped.
- *	@buf_out: Pointer to mapped area.
+ *	@flags: unsigned long variable to store irq enable status
+ *	@copy_in: copy in from user buffer
  *
- *	Maps buffer contained within SCSI command @cmd.
+ *	Prepare buffer for simulated SCSI commands.
  *
  *	LOCKING:
- *	spin_lock_irqsave(host lock)
+ *	spin_lock_irqsave(ata_scsi_rbuf_lock) on success
  *
  *	RETURNS:
- *	Length of response buffer.
+ *	Pointer to response buffer.
  */
-
-static unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out)
+static void *ata_scsi_rbuf_get(struct scsi_cmnd *cmd, bool copy_in,
+			       unsigned long *flags)
 {
-	u8 *buf;
-	unsigned int buflen;
-
-	struct scatterlist *sg = scsi_sglist(cmd);
-
-	if (sg) {
-		buf = kmap_atomic(sg_page(sg), KM_IRQ0) + sg->offset;
-		buflen = sg->length;
-	} else {
-		buf = NULL;
-		buflen = 0;
-	}
+	spin_lock_irqsave(&ata_scsi_rbuf_lock, *flags);
 
-	*buf_out = buf;
-	return buflen;
+	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
+	if (copy_in)
+		sg_copy_to_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
+				  ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
+	return ata_scsi_rbuf;
 }
 
 /**
  *	ata_scsi_rbuf_put - Unmap response buffer.
  *	@cmd: SCSI command containing buffer to be unmapped.
- *	@buf: buffer to unmap
+ *	@copy_out: copy out result
+ *	@flags: @flags passed to ata_scsi_rbuf_get()
  *
- *	Unmaps response buffer contained within @cmd.
+ *	Returns rbuf buffer.  The result is copied to @cmd's buffer if
+ *	@copy_back is true.
  *
  *	LOCKING:
- *	spin_lock_irqsave(host lock)
+ *	Unlocks ata_scsi_rbuf_lock.
  */
-
-static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
+static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, bool copy_out,
+				     unsigned long *flags)
 {
-	struct scatterlist *sg = scsi_sglist(cmd);
-	if (sg)
-		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+	if (copy_out)
+		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
+				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
+	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, *flags);
 }
 
 /**
@@ -1704,22 +1703,16 @@ static inline void ata_scsi_rbuf_put(str
  *	spin_lock_irqsave(host lock)
  */
 static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
-			unsigned int (*actor)(struct ata_scsi_args *args,
-					      u8 *rbuf, unsigned int buflen))
+		unsigned int (*actor)(struct ata_scsi_args *args, u8 *rbuf))
 {
 	u8 *rbuf;
-	unsigned int buflen, rc;
+	unsigned int rc;
 	struct scsi_cmnd *cmd = args->cmd;
 	unsigned long flags;
 
-	local_irq_save(flags);
-
-	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
-	memset(rbuf, 0, buflen);
-	rc = actor(args, rbuf, buflen);
-	ata_scsi_rbuf_put(cmd, rbuf);
-
-	local_irq_restore(flags);
+	rbuf = ata_scsi_rbuf_get(cmd, false, &flags);
+	rc = actor(args, rbuf);
+	ata_scsi_rbuf_put(cmd, rc == 0, &flags);
 
 	if (rc == 0)
 		cmd->result = SAM_STAT_GOOD;
@@ -1727,26 +1720,9 @@ static void ata_scsi_rbuf_fill(struct at
 }
 
 /**
- *	ATA_SCSI_RBUF_SET - helper to set values in SCSI response buffer
- *	@idx: byte index into SCSI response buffer
- *	@val: value to set
- *
- *	To be used by SCSI command simulator functions.  This macros
- *	expects two local variables, u8 *rbuf and unsigned int buflen,
- *	are in scope.
- *
- *	LOCKING:
- *	None.
- */
-#define ATA_SCSI_RBUF_SET(idx, val) do { \
-		if ((idx) < buflen) rbuf[(idx)] = (u8)(val); \
-	} while (0)
-
-/**
  *	ata_scsiop_inq_std - Simulate INQUIRY command
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Returns standard device identification data associated
  *	with non-VPD INQUIRY command output.
@@ -1754,9 +1730,17 @@ static void ata_scsi_rbuf_fill(struct at
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
-				       unsigned int buflen)
+static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 {
+	const u8 versions[] = {
+		0x60,	/* SAM-3 (no version claimed) */
+
+		0x03,
+		0x20,	/* SBC-2 (no version claimed) */
+
+		0x02,
+		0x60	/* SPC-3 (no version claimed) */
+	};
 	u8 hdr[] = {
 		TYPE_DISK,
 		0,
@@ -1765,35 +1749,21 @@ static unsigned int ata_scsiop_inq_std(s
 		95 - 4
 	};
 
+	VPRINTK("ENTER\n");
+
 	/* set scsi removeable (RMB) bit per ata bit */
 	if (ata_id_removeable(args->id))
 		hdr[1] |= (1 << 7);
 
-	VPRINTK("ENTER\n");
-
 	memcpy(rbuf, hdr, sizeof(hdr));
+	memcpy(&rbuf[8], "ATA     ", 8);
+	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
+	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
 
-	if (buflen > 35) {
-		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
-		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
-		if (rbuf[32] == 0 || rbuf[32] == ' ')
-			memcpy(&rbuf[32], "n/a ", 4);
-	}
-
-	if (buflen > 63) {
-		const u8 versions[] = {
-			0x60,	/* SAM-3 (no version claimed) */
-
-			0x03,
-			0x20,	/* SBC-2 (no version claimed) */
-
-			0x02,
-			0x60	/* SPC-3 (no version claimed) */
-		};
+	if (rbuf[32] == 0 || rbuf[32] == ' ')
+		memcpy(&rbuf[32], "n/a ", 4);
 
-		memcpy(rbuf + 59, versions, sizeof(versions));
-	}
+	memcpy(rbuf + 59, versions, sizeof(versions));
 
 	return 0;
 }
@@ -1802,26 +1772,22 @@ static unsigned int ata_scsiop_inq_std(s
  *	ata_scsiop_inq_00 - Simulate INQUIRY VPD page 0, list of pages
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Returns list of inquiry VPD pages available.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf,
-				      unsigned int buflen)
+static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
 {
 	const u8 pages[] = {
 		0x00,	/* page 0x00, this page */
 		0x80,	/* page 0x80, unit serial no page */
 		0x83	/* page 0x83, device ident page */
 	};
-	rbuf[3] = sizeof(pages);	/* number of supported VPD pages */
-
-	if (buflen > 6)
-		memcpy(rbuf + 4, pages, sizeof(pages));
 
+	rbuf[3] = sizeof(pages);	/* number of supported VPD pages */
+	memcpy(rbuf + 4, pages, sizeof(pages));
 	return 0;
 }
 
@@ -1829,15 +1795,13 @@ static unsigned int ata_scsiop_inq_00(st
  *	ata_scsiop_inq_80 - Simulate INQUIRY VPD page 80, device serial number
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Returns ATA device serial number.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf,
-				      unsigned int buflen)
+static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf)
 {
 	const u8 hdr[] = {
 		0,
@@ -1845,12 +1809,10 @@ static unsigned int ata_scsiop_inq_80(st
 		0,
 		ATA_ID_SERNO_LEN,	/* page len */
 	};
-	memcpy(rbuf, hdr, sizeof(hdr));
-
-	if (buflen > (ATA_ID_SERNO_LEN + 4 - 1))
-		ata_id_string(args->id, (unsigned char *) &rbuf[4],
-			      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
 
+	memcpy(rbuf, hdr, sizeof(hdr));
+	ata_id_string(args->id, (unsigned char *) &rbuf[4],
+		      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
 	return 0;
 }
 
@@ -1858,7 +1820,6 @@ static unsigned int ata_scsiop_inq_80(st
  *	ata_scsiop_inq_83 - Simulate INQUIRY VPD page 83, device identity
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Yields two logical unit device identification designators:
  *	 - vendor specific ASCII containing the ATA serial number
@@ -1868,40 +1829,37 @@ static unsigned int ata_scsiop_inq_80(st
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf,
-				      unsigned int buflen)
+static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
 {
-	int num;
 	const int sat_model_serial_desc_len = 68;
+	int num;
 
 	rbuf[1] = 0x83;			/* this page code */
 	num = 4;
 
-	if (buflen > (ATA_ID_SERNO_LEN + num + 3)) {
-		/* piv=0, assoc=lu, code_set=ACSII, designator=vendor */
-		rbuf[num + 0] = 2;
-		rbuf[num + 3] = ATA_ID_SERNO_LEN;
-		num += 4;
-		ata_id_string(args->id, (unsigned char *) rbuf + num,
-			      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
-		num += ATA_ID_SERNO_LEN;
-	}
-	if (buflen > (sat_model_serial_desc_len + num + 3)) {
-		/* SAT defined lu model and serial numbers descriptor */
-		/* piv=0, assoc=lu, code_set=ACSII, designator=t10 vendor id */
-		rbuf[num + 0] = 2;
-		rbuf[num + 1] = 1;
-		rbuf[num + 3] = sat_model_serial_desc_len;
-		num += 4;
-		memcpy(rbuf + num, "ATA     ", 8);
-		num += 8;
-		ata_id_string(args->id, (unsigned char *) rbuf + num,
-			      ATA_ID_PROD, ATA_ID_PROD_LEN);
-		num += ATA_ID_PROD_LEN;
-		ata_id_string(args->id, (unsigned char *) rbuf + num,
-			      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
-		num += ATA_ID_SERNO_LEN;
-	}
+	/* piv=0, assoc=lu, code_set=ACSII, designator=vendor */
+	rbuf[num + 0] = 2;
+	rbuf[num + 3] = ATA_ID_SERNO_LEN;
+	num += 4;
+	ata_id_string(args->id, (unsigned char *) rbuf + num,
+		      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
+	num += ATA_ID_SERNO_LEN;
+
+	/* SAT defined lu model and serial numbers descriptor */
+	/* piv=0, assoc=lu, code_set=ACSII, designator=t10 vendor id */
+	rbuf[num + 0] = 2;
+	rbuf[num + 1] = 1;
+	rbuf[num + 3] = sat_model_serial_desc_len;
+	num += 4;
+	memcpy(rbuf + num, "ATA     ", 8);
+	num += 8;
+	ata_id_string(args->id, (unsigned char *) rbuf + num, ATA_ID_PROD,
+		      ATA_ID_PROD_LEN);
+	num += ATA_ID_PROD_LEN;
+	ata_id_string(args->id, (unsigned char *) rbuf + num, ATA_ID_SERNO,
+		      ATA_ID_SERNO_LEN);
+	num += ATA_ID_SERNO_LEN;
+
 	rbuf[3] = num - 4;    /* page len (assume less than 256 bytes) */
 	return 0;
 }
@@ -1910,34 +1868,26 @@ static unsigned int ata_scsiop_inq_83(st
  *	ata_scsiop_inq_89 - Simulate INQUIRY VPD page 89, ATA info
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Yields SAT-specified ATA VPD page.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf,
-				      unsigned int buflen)
+static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 {
-	u8 pbuf[60];
 	struct ata_taskfile tf;
-	unsigned int i;
-
-	if (!buflen)
-		return 0;
 
-	memset(&pbuf, 0, sizeof(pbuf));
 	memset(&tf, 0, sizeof(tf));
 
-	pbuf[1] = 0x89;			/* our page code */
-	pbuf[2] = (0x238 >> 8);		/* page size fixed at 238h */
-	pbuf[3] = (0x238 & 0xff);
-
-	memcpy(&pbuf[8], "linux   ", 8);
-	memcpy(&pbuf[16], "libata          ", 16);
-	memcpy(&pbuf[32], DRV_VERSION, 4);
-	ata_id_string(args->id, &pbuf[32], ATA_ID_FW_REV, 4);
+	rbuf[1] = 0x89;			/* our page code */
+	rbuf[2] = (0x238 >> 8);		/* page size fixed at 238h */
+	rbuf[3] = (0x238 & 0xff);
+
+	memcpy(&rbuf[8], "linux   ", 8);
+	memcpy(&rbuf[16], "libata          ", 16);
+	memcpy(&rbuf[32], DRV_VERSION, 4);
+	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
 
 	/* we don't store the ATA device signature, so we fake it */
 
@@ -1945,19 +1895,12 @@ static unsigned int ata_scsiop_inq_89(st
 	tf.lbal = 0x1;
 	tf.nsect = 0x1;
 
-	ata_tf_to_fis(&tf, 0, 1, &pbuf[36]);	/* TODO: PMP? */
-	pbuf[36] = 0x34;		/* force D2H Reg FIS (34h) */
+	ata_tf_to_fis(&tf, 0, 1, &rbuf[36]);	/* TODO: PMP? */
+	rbuf[36] = 0x34;		/* force D2H Reg FIS (34h) */
 
-	pbuf[56] = ATA_CMD_ID_ATA;
+	rbuf[56] = ATA_CMD_ID_ATA;
 
-	i = min(buflen, 60U);
-	memcpy(rbuf, &pbuf[0], i);
-	buflen -= i;
-
-	if (!buflen)
-		return 0;
-
-	memcpy(&rbuf[60], &args->id[0], min(buflen, 512U));
+	memcpy(&rbuf[60], &args->id[0], 512);
 	return 0;
 }
 
@@ -1965,7 +1908,6 @@ static unsigned int ata_scsiop_inq_89(st
  *	ata_scsiop_noop - Command handler that simply returns success.
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	No operation.  Simply returns success to caller, to indicate
  *	that the caller should successfully complete this SCSI command.
@@ -1973,46 +1915,16 @@ static unsigned int ata_scsiop_inq_89(st
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_noop(struct ata_scsi_args *args, u8 *rbuf,
-				    unsigned int buflen)
+static unsigned int ata_scsiop_noop(struct ata_scsi_args *args, u8 *rbuf)
 {
 	VPRINTK("ENTER\n");
 	return 0;
 }
 
 /**
- *	ata_msense_push - Push data onto MODE SENSE data output buffer
- *	@ptr_io: (input/output) Location to store more output data
- *	@last: End of output data buffer
- *	@buf: Pointer to BLOB being added to output buffer
- *	@buflen: Length of BLOB
- *
- *	Store MODE SENSE data on an output buffer.
- *
- *	LOCKING:
- *	None.
- */
-
-static void ata_msense_push(u8 **ptr_io, const u8 *last,
-			    const u8 *buf, unsigned int buflen)
-{
-	u8 *ptr = *ptr_io;
-
-	if ((ptr + buflen - 1) > last)
-		return;
-
-	memcpy(ptr, buf, buflen);
-
-	ptr += buflen;
-
-	*ptr_io = ptr;
-}
-
-/**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
  *	@id: device IDENTIFY data
- *	@ptr_io: (input/output) Location to store more output data
- *	@last: End of output data buffer
+ *	@buf: output buffer
  *
  *	Generate a caching info page, which conditionally indicates
  *	write caching to the SCSI layer, depending on device
@@ -2021,58 +1933,43 @@ static void ata_msense_push(u8 **ptr_io,
  *	LOCKING:
  *	None.
  */
-
-static unsigned int ata_msense_caching(u16 *id, u8 **ptr_io,
-				       const u8 *last)
+static unsigned int ata_msense_caching(u16 *id, u8 *buf)
 {
-	u8 page[CACHE_MPAGE_LEN];
-
-	memcpy(page, def_cache_mpage, sizeof(page));
+	memcpy(buf, def_cache_mpage, sizeof(def_cache_mpage));
 	if (ata_id_wcache_enabled(id))
-		page[2] |= (1 << 2);	/* write cache enable */
+		buf[2] |= (1 << 2);	/* write cache enable */
 	if (!ata_id_rahead_enabled(id))
-		page[12] |= (1 << 5);	/* disable read ahead */
-
-	ata_msense_push(ptr_io, last, page, sizeof(page));
-	return sizeof(page);
+		buf[12] |= (1 << 5);	/* disable read ahead */
+	return sizeof(def_cache_mpage);
 }
 
 /**
  *	ata_msense_ctl_mode - Simulate MODE SENSE control mode page
- *	@dev: Device associated with this MODE SENSE command
- *	@ptr_io: (input/output) Location to store more output data
- *	@last: End of output data buffer
+ *	@buf: output buffer
  *
  *	Generate a generic MODE SENSE control mode page.
  *
  *	LOCKING:
  *	None.
  */
-
-static unsigned int ata_msense_ctl_mode(u8 **ptr_io, const u8 *last)
+static unsigned int ata_msense_ctl_mode(u8 *buf)
 {
-	ata_msense_push(ptr_io, last, def_control_mpage,
-			sizeof(def_control_mpage));
+	memcpy(buf, def_control_mpage, sizeof(def_control_mpage));
 	return sizeof(def_control_mpage);
 }
 
 /**
  *	ata_msense_rw_recovery - Simulate MODE SENSE r/w error recovery page
- *	@dev: Device associated with this MODE SENSE command
- *	@ptr_io: (input/output) Location to store more output data
- *	@last: End of output data buffer
+ *	@bufp: output buffer
  *
  *	Generate a generic MODE SENSE r/w error recovery page.
  *
  *	LOCKING:
  *	None.
  */
-
-static unsigned int ata_msense_rw_recovery(u8 **ptr_io, const u8 *last)
+static unsigned int ata_msense_rw_recovery(u8 *buf)
 {
-
-	ata_msense_push(ptr_io, last, def_rw_recovery_mpage,
-			sizeof(def_rw_recovery_mpage));
+	memcpy(buf, def_rw_recovery_mpage, sizeof(def_rw_recovery_mpage));
 	return sizeof(def_rw_recovery_mpage);
 }
 
@@ -2104,7 +2001,6 @@ static int ata_dev_supports_fua(u16 *id)
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Simulate MODE SENSE commands. Assume this is invoked for direct
  *	access devices (e.g. disks) only. There should be no block
@@ -2113,19 +2009,17 @@ static int ata_dev_supports_fua(u16 *id)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf,
-				  unsigned int buflen)
+static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 {
 	struct ata_device *dev = args->dev;
-	u8 *scsicmd = args->cmd->cmnd, *p, *last;
+	u8 *scsicmd = args->cmd->cmnd, *p = rbuf;
 	const u8 sat_blk_desc[] = {
 		0, 0, 0, 0,	/* number of blocks: sat unspecified */
 		0,
 		0, 0x2, 0x0	/* block length: 512 bytes */
 	};
 	u8 pg, spg;
-	unsigned int ebd, page_control, six_byte, output_len, alloc_len, minlen;
+	unsigned int ebd, page_control, six_byte;
 	u8 dpofua;
 
 	VPRINTK("ENTER\n");
@@ -2148,17 +2042,10 @@ unsigned int ata_scsiop_mode_sense(struc
 		goto invalid_fld;
 	}
 
-	if (six_byte) {
-		output_len = 4 + (ebd ? 8 : 0);
-		alloc_len = scsicmd[4];
-	} else {
-		output_len = 8 + (ebd ? 8 : 0);
-		alloc_len = (scsicmd[7] << 8) + scsicmd[8];
-	}
-	minlen = (alloc_len < buflen) ? alloc_len : buflen;
-
-	p = rbuf + output_len;
-	last = rbuf + minlen - 1;
+	if (six_byte)
+		p += 4 + (ebd ? 8 : 0);
+	else
+		p += 8 + (ebd ? 8 : 0);
 
 	pg = scsicmd[2] & 0x3f;
 	spg = scsicmd[3];
@@ -2171,61 +2058,48 @@ unsigned int ata_scsiop_mode_sense(struc
 
 	switch(pg) {
 	case RW_RECOVERY_MPAGE:
-		output_len += ata_msense_rw_recovery(&p, last);
+		p += ata_msense_rw_recovery(p);
 		break;
 
 	case CACHE_MPAGE:
-		output_len += ata_msense_caching(args->id, &p, last);
+		p += ata_msense_caching(args->id, p);
 		break;
 
-	case CONTROL_MPAGE: {
-		output_len += ata_msense_ctl_mode(&p, last);
+	case CONTROL_MPAGE:
+		p += ata_msense_ctl_mode(p);
 		break;
-		}
 
 	case ALL_MPAGES:
-		output_len += ata_msense_rw_recovery(&p, last);
-		output_len += ata_msense_caching(args->id, &p, last);
-		output_len += ata_msense_ctl_mode(&p, last);
+		p += ata_msense_rw_recovery(p);
+		p += ata_msense_caching(args->id, p);
+		p += ata_msense_ctl_mode(p);
 		break;
 
 	default:		/* invalid page code */
 		goto invalid_fld;
 	}
 
-	if (minlen < 1)
-		return 0;
-
 	dpofua = 0;
 	if (ata_dev_supports_fua(args->id) && (dev->flags & ATA_DFLAG_LBA48) &&
 	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
 		dpofua = 1 << 4;
 
 	if (six_byte) {
-		output_len--;
-		rbuf[0] = output_len;
-		if (minlen > 2)
-			rbuf[2] |= dpofua;
+		rbuf[0] = p - rbuf - 1;
+		rbuf[2] |= dpofua;
 		if (ebd) {
-			if (minlen > 3)
-				rbuf[3] = sizeof(sat_blk_desc);
-			if (minlen > 11)
-				memcpy(rbuf + 4, sat_blk_desc,
-				       sizeof(sat_blk_desc));
+			rbuf[3] = sizeof(sat_blk_desc);
+			memcpy(rbuf + 4, sat_blk_desc, sizeof(sat_blk_desc));
 		}
 	} else {
-		output_len -= 2;
+		unsigned int output_len = p - rbuf - 2;
+
 		rbuf[0] = output_len >> 8;
-		if (minlen > 1)
-			rbuf[1] = output_len;
-		if (minlen > 3)
-			rbuf[3] |= dpofua;
+		rbuf[1] = output_len;
+		rbuf[3] |= dpofua;
 		if (ebd) {
-			if (minlen > 7)
-				rbuf[7] = sizeof(sat_blk_desc);
-			if (minlen > 15)
-				memcpy(rbuf + 8, sat_blk_desc,
-				       sizeof(sat_blk_desc));
+			rbuf[7] = sizeof(sat_blk_desc);
+			memcpy(rbuf + 8, sat_blk_desc, sizeof(sat_blk_desc));
 		}
 	}
 	return 0;
@@ -2245,15 +2119,13 @@ saving_not_supp:
  *	ata_scsiop_read_cap - Simulate READ CAPACITY[ 16] commands
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Simulate READ CAPACITY commands.
  *
  *	LOCKING:
  *	None.
  */
-unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf,
-				 unsigned int buflen)
+static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 {
 	u64 last_lba = args->dev->n_sectors - 1; /* LBA of the last block */
 
@@ -2264,28 +2136,28 @@ unsigned int ata_scsiop_read_cap(struct 
 			last_lba = 0xffffffff;
 
 		/* sector count, 32-bit */
-		ATA_SCSI_RBUF_SET(0, last_lba >> (8 * 3));
-		ATA_SCSI_RBUF_SET(1, last_lba >> (8 * 2));
-		ATA_SCSI_RBUF_SET(2, last_lba >> (8 * 1));
-		ATA_SCSI_RBUF_SET(3, last_lba);
+		rbuf[0] = last_lba >> (8 * 3);
+		rbuf[1] = last_lba >> (8 * 2);
+		rbuf[2] = last_lba >> (8 * 1);
+		rbuf[3] = last_lba;
 
 		/* sector size */
-		ATA_SCSI_RBUF_SET(6, ATA_SECT_SIZE >> 8);
-		ATA_SCSI_RBUF_SET(7, ATA_SECT_SIZE & 0xff);
+		rbuf[6] = ATA_SECT_SIZE >> 8;
+		rbuf[7] = ATA_SECT_SIZE & 0xff;
 	} else {
 		/* sector count, 64-bit */
-		ATA_SCSI_RBUF_SET(0, last_lba >> (8 * 7));
-		ATA_SCSI_RBUF_SET(1, last_lba >> (8 * 6));
-		ATA_SCSI_RBUF_SET(2, last_lba >> (8 * 5));
-		ATA_SCSI_RBUF_SET(3, last_lba >> (8 * 4));
-		ATA_SCSI_RBUF_SET(4, last_lba >> (8 * 3));
-		ATA_SCSI_RBUF_SET(5, last_lba >> (8 * 2));
-		ATA_SCSI_RBUF_SET(6, last_lba >> (8 * 1));
-		ATA_SCSI_RBUF_SET(7, last_lba);
+		rbuf[0] = last_lba >> (8 * 7);
+		rbuf[1] = last_lba >> (8 * 6);
+		rbuf[2] = last_lba >> (8 * 5);
+		rbuf[3] = last_lba >> (8 * 4);
+		rbuf[4] = last_lba >> (8 * 3);
+		rbuf[5] = last_lba >> (8 * 2);
+		rbuf[6] = last_lba >> (8 * 1);
+		rbuf[7] = last_lba;
 
 		/* sector size */
-		ATA_SCSI_RBUF_SET(10, ATA_SECT_SIZE >> 8);
-		ATA_SCSI_RBUF_SET(11, ATA_SECT_SIZE & 0xff);
+		rbuf[10] = ATA_SECT_SIZE >> 8;
+		rbuf[11] = ATA_SECT_SIZE & 0xff;
 	}
 
 	return 0;
@@ -2295,16 +2167,13 @@ unsigned int ata_scsiop_read_cap(struct 
  *	ata_scsiop_report_luns - Simulate REPORT LUNS command
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *	@buflen: Response buffer length.
  *
  *	Simulate REPORT LUNS command.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf,
-				   unsigned int buflen)
+static unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf)
 {
 	VPRINTK("ENTER\n");
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
@@ -2438,13 +2307,10 @@ static void atapi_qc_complete(struct ata
 		u8 *scsicmd = cmd->cmnd;
 
 		if ((scsicmd[0] == INQUIRY) && ((scsicmd[1] & 0x03) == 0)) {
-			u8 *buf = NULL;
-			unsigned int buflen;
 			unsigned long flags;
+			u8 *buf;
 
-			local_irq_save(flags);
-
-			buflen = ata_scsi_rbuf_get(cmd, &buf);
+			buf = ata_scsi_rbuf_get(cmd, true, &flags);
 
 	/* ATAPI devices typically report zero for their SCSI version,
 	 * and sometimes deviate from the spec WRT response data
@@ -2459,9 +2325,7 @@ static void atapi_qc_complete(struct ata
 				buf[3] = 0x32;
 			}
 
-			ata_scsi_rbuf_put(cmd, buf);
-
-			local_irq_restore(flags);
+			ata_scsi_rbuf_put(cmd, true, &flags);
 		}
 
 		cmd->result = SAM_STAT_GOOD;
