From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] libata: make some libata-core routines extern
Date: Sat, 1 Apr 2006 19:48:37 +0900
Message-ID: <11438885173883-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:54728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751511AbWDAKst (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:49 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210246nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:49 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make libata-core routines which will be used by EH implementation
extern.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   31 +++++++++++++------------------
 drivers/scsi/libata.h      |   14 ++++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

5349c724ad0a9c179ff3e56c235dfd4b20fa12d1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c893129..681ef82 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,10 +65,6 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev,
 					u16 heads,
 					u16 sectors);
-static int ata_down_sata_spd_limit(struct ata_port *ap, struct ata_device *dev);
-static int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
-				   int force_pio0);
-static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
 					 struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
@@ -412,7 +408,7 @@ static const char *sata_spd_string(unsig
 	return spd_str[spd - 1];
 }
 
-static void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
+void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ata_dev_enabled(dev)) {
 		printk(KERN_WARNING "ata%u: dev %u disabled\n",
@@ -979,10 +975,9 @@ void ata_qc_complete_internal(struct ata
  *	None.  Should be called with kernel context, might sleep.
  */
 
-static unsigned
-ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
-		  struct ata_taskfile *tf, const u8 *cdb,
-		  int dma_dir, void *buf, unsigned int buflen)
+unsigned ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+			   struct ata_taskfile *tf, const u8 *cdb,
+			   int dma_dir, void *buf, unsigned int buflen)
 {
 	u8 command = tf->command;
 	struct ata_queued_cmd *qc;
@@ -1650,7 +1645,7 @@ void ata_port_disable(struct ata_port *a
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-static int ata_down_sata_spd_limit(struct ata_port *ap, struct ata_device *dev)
+int ata_down_sata_spd_limit(struct ata_port *ap, struct ata_device *dev)
 {
 	u32 spd, mask;
 	int highbit;
@@ -1715,7 +1710,7 @@ static int __ata_set_sata_spd_needed(str
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-static int ata_set_sata_spd_needed(struct ata_port *ap, struct ata_device *dev)
+int ata_set_sata_spd_needed(struct ata_port *ap, struct ata_device *dev)
 {
 	u32 scontrol;
 
@@ -1742,7 +1737,7 @@ static int ata_set_sata_spd_needed(struc
  *	0 if spd doesn't need to be changed, 1 if spd has been
  *	changed.  -EOPNOTSUPP if SCR registers are inaccessible.
  */
-static int ata_set_sata_spd(struct ata_port *ap, struct ata_device *dev)
+int ata_set_sata_spd(struct ata_port *ap, struct ata_device *dev)
 {
 	u32 scontrol;
 
@@ -1924,8 +1919,8 @@ int ata_timing_compute(struct ata_device
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-static int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
-				   int force_pio0)
+int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
+			    int force_pio0)
 {
 	unsigned long xfer_mask;
 	int highbit;
@@ -2003,7 +1998,7 @@ static int ata_dev_set_mode(struct ata_p
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
+int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
 	struct ata_device *dev;
 	int i, rc = 0, used_dma = 0, found = 0;
@@ -2589,9 +2584,9 @@ int ata_std_probe_reset(struct ata_port 
 				     ata_std_postreset, classes);
 }
 
-static int ata_do_reset(struct ata_port *ap,
-			ata_reset_fn_t reset, ata_postreset_fn_t postreset,
-			int verbose, unsigned int *classes)
+int ata_do_reset(struct ata_port *ap,
+		 ata_reset_fn_t reset, ata_postreset_fn_t postreset,
+		 int verbose, unsigned int *classes)
 {
 	int i, rc;
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 75e9bd5..3bebca9 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -45,7 +45,21 @@ extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
+extern void ata_dev_disable(struct ata_port *ap, struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
+extern unsigned ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+				  struct ata_taskfile *tf, const u8 *cdb,
+				  int dma_dir, void *buf, unsigned int buflen);
+extern int ata_down_sata_spd_limit(struct ata_port *ap, struct ata_device *dev);
+extern int ata_set_sata_spd_needed(struct ata_port *ap, struct ata_device *dev);
+extern int ata_set_sata_spd(struct ata_port *ap, struct ata_device *dev);
+extern int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
+				   int force_pio0);
+extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
+extern int ata_do_reset(struct ata_port *ap,
+			ata_reset_fn_t reset,
+			ata_postreset_fn_t postreset,
+			int verbose, unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
-- 
1.2.4


