From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/15] libata: make some libata-core routines extern
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <114397151320-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:48058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbWDBJwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:06 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447005nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:06 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make libata-core routines which will be used by EH implementation
extern.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   29 ++++++++++++-----------------
 drivers/scsi/libata.h      |   13 +++++++++++++
 2 files changed, 25 insertions(+), 17 deletions(-)

86167e3b2891b6ab3b751571f108632da3fc0d7b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 44bdfa6..b6368ee 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,10 +65,6 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev,
 					u16 heads,
 					u16 sectors);
-static int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
-				   int force_pio0);
-static int ata_down_sata_spd_limit(struct ata_port *ap);
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
@@ -1649,7 +1644,7 @@ void ata_port_disable(struct ata_port *a
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-static int ata_down_sata_spd_limit(struct ata_port *ap)
+int ata_down_sata_spd_limit(struct ata_port *ap)
 {
 	u32 spd, mask;
 	int highbit;
@@ -1709,7 +1704,7 @@ static int __ata_set_sata_spd_needed(str
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-static int ata_set_sata_spd_needed(struct ata_port *ap)
+int ata_set_sata_spd_needed(struct ata_port *ap)
 {
 	u32 scontrol;
 
@@ -1913,8 +1908,8 @@ int ata_timing_compute(struct ata_device
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
@@ -1992,7 +1987,7 @@ static int ata_dev_set_mode(struct ata_p
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
+int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
 	struct ata_device *dev;
 	int i, rc = 0, used_dma = 0, found = 0;
@@ -2585,9 +2580,9 @@ int ata_std_probe_reset(struct ata_port 
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
index 75e9bd5..31efc2e 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -45,7 +45,20 @@ extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
+extern void ata_dev_disable(struct ata_port *ap, struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
+extern unsigned ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+				  struct ata_taskfile *tf, const u8 *cdb,
+				  int dma_dir, void *buf, unsigned int buflen);
+extern int ata_down_sata_spd_limit(struct ata_port *ap);
+extern int ata_set_sata_spd_needed(struct ata_port *ap);
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


