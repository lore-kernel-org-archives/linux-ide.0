From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 1/2] libata-scsi: clean up inquiry / mode
 sense related functions
Date: Mon, 28 Apr 2008 17:16:52 +0900
Message-ID: <481587F4.6090006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:49407 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763335AbYD1IQ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 04:16:58 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3928810wff.4
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 01:16:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Petr Vandrovec <petr@vmware.com>

* make ata_scsiop_*() static
* make ata_scsi_set_sense() static and move it above its users
* make ata_scsi_rbuf_fill() static
* kill unused ata_scsi_badcmd()

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   89 ++++++++++------------------------------------
 drivers/ata/libata.h      |   28 --------------
 2 files changed, 21 insertions(+), 96 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -179,6 +179,13 @@ DEVICE_ATTR(link_power_management_policy
 		ata_scsi_lpm_show, ata_scsi_lpm_put);
 EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
 
+static void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq)
+{
+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+
+	scsi_build_sense_buffer(0, cmd->sense_buffer, sk, asc, ascq);
+}
+
 static void ata_scsi_invalid_field(struct scsi_cmnd *cmd,
 				   void (*done)(struct scsi_cmnd *))
 {
@@ -1696,10 +1703,9 @@ static inline void ata_scsi_rbuf_put(str
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
-			unsigned int (*actor) (struct ata_scsi_args *args,
-					       u8 *rbuf, unsigned int buflen))
+static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
+			unsigned int (*actor)(struct ata_scsi_args *args,
+					      u8 *rbuf, unsigned int buflen))
 {
 	u8 *rbuf;
 	unsigned int buflen, rc;
@@ -1748,9 +1754,8 @@ void ata_scsi_rbuf_fill(struct ata_scsi_
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
-			       unsigned int buflen)
+static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
+				       unsigned int buflen)
 {
 	u8 hdr[] = {
 		TYPE_DISK,
@@ -1804,9 +1809,8 @@ unsigned int ata_scsiop_inq_std(struct a
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen)
+static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf,
+				      unsigned int buflen)
 {
 	const u8 pages[] = {
 		0x00,	/* page 0x00, this page */
@@ -1832,9 +1836,8 @@ unsigned int ata_scsiop_inq_00(struct at
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen)
+static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf,
+				      unsigned int buflen)
 {
 	const u8 hdr[] = {
 		0,
@@ -1865,9 +1868,8 @@ unsigned int ata_scsiop_inq_80(struct at
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen)
+static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf,
+				      unsigned int buflen)
 {
 	int num;
 	const int sat_model_serial_desc_len = 68;
@@ -1915,9 +1917,8 @@ unsigned int ata_scsiop_inq_83(struct at
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
 static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen)
+				      unsigned int buflen)
 {
 	u8 pbuf[60];
 	struct ata_taskfile tf;
@@ -1972,9 +1973,8 @@ static unsigned int ata_scsiop_inq_89(st
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
-unsigned int ata_scsiop_noop(struct ata_scsi_args *args, u8 *rbuf,
-			    unsigned int buflen)
+static unsigned int ata_scsiop_noop(struct ata_scsi_args *args, u8 *rbuf,
+				    unsigned int buflen)
 {
 	VPRINTK("ENTER\n");
 	return 0;
@@ -2312,53 +2312,6 @@ unsigned int ata_scsiop_report_luns(stru
 	return 0;
 }
 
-/**
- *	ata_scsi_set_sense - Set SCSI sense data and status
- *	@cmd: SCSI request to be handled
- *	@sk: SCSI-defined sense key
- *	@asc: SCSI-defined additional sense code
- *	@ascq: SCSI-defined additional sense code qualifier
- *
- *	Helper function that builds a valid fixed format, current
- *	response code and the given sense key (sk), additional sense
- *	code (asc) and additional sense code qualifier (ascq) with
- *	a SCSI command status of %SAM_STAT_CHECK_CONDITION and
- *	DRIVER_SENSE set in the upper bits of scsi_cmnd::result .
- *
- *	LOCKING:
- *	Not required
- */
-
-void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq)
-{
-	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
-
-	scsi_build_sense_buffer(0, cmd->sense_buffer, sk, asc, ascq);
-}
-
-/**
- *	ata_scsi_badcmd - End a SCSI request with an error
- *	@cmd: SCSI request to be handled
- *	@done: SCSI command completion function
- *	@asc: SCSI-defined additional sense code
- *	@ascq: SCSI-defined additional sense code qualifier
- *
- *	Helper function that completes a SCSI command with
- *	%SAM_STAT_CHECK_CONDITION, with a sense key %ILLEGAL_REQUEST
- *	and the specified additional sense codes.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-void ata_scsi_badcmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *), u8 asc, u8 ascq)
-{
-	DPRINTK("ENTER\n");
-	ata_scsi_set_sense(cmd, ILLEGAL_REQUEST, asc, ascq);
-
-	done(cmd);
-}
-
 static void atapi_sense_complete(struct ata_queued_cmd *qc)
 {
 	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0)) {
Index: work/drivers/ata/libata.h
===================================================================
--- work.orig/drivers/ata/libata.h
+++ work/drivers/ata/libata.h
@@ -146,34 +146,6 @@ extern void ata_scsi_scan_host(struct at
 extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
-extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
-			       unsigned int buflen);
-
-extern unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen);
-
-extern unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen);
-extern unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf,
-			      unsigned int buflen);
-extern unsigned int ata_scsiop_noop(struct ata_scsi_args *args, u8 *rbuf,
-			    unsigned int buflen);
-extern unsigned int ata_scsiop_sync_cache(struct ata_scsi_args *args, u8 *rbuf,
-				  unsigned int buflen);
-extern unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf,
-				  unsigned int buflen);
-extern unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf,
-			        unsigned int buflen);
-extern unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf,
-				   unsigned int buflen);
-extern void ata_scsi_badcmd(struct scsi_cmnd *cmd,
-			    void (*done)(struct scsi_cmnd *),
-			    u8 asc, u8 ascq);
-extern void ata_scsi_set_sense(struct scsi_cmnd *cmd,
-			       u8 sk, u8 asc, u8 ascq);
-extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
-                        unsigned int (*actor) (struct ata_scsi_args *args,
-                                           u8 *rbuf, unsigned int buflen));
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
