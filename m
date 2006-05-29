From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata-hp-prep: make probing related functions global
Date: Mon, 29 May 2006 15:25:58 +0900
Message-ID: <1148883958195-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:9699 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751256AbWE2G0a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:30 -0400
Received: by nz-out-0102.google.com with SMTP id s18so475446nze
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:29 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hotplug will be implemented in libata-eh.c.  Make ata_dev_read_id()
and ata_dev_configure() global.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 +++---
 drivers/scsi/libata.h      |    3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

a0fe7eb0b738cb74416f362a956e8593bfd3a0c0
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index aa1e0a1..009db45 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1167,8 +1167,8 @@ unsigned int ata_pio_need_iordy(const st
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-static int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-			   int post_reset, u16 *id)
+int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
+		    int post_reset, u16 *id)
 {
 	struct ata_port *ap = dev->ap;
 	unsigned int class = *p_class;
@@ -1292,7 +1292,7 @@ static void ata_dev_config_ncq(struct at
  *	RETURNS:
  *	0 on success, -errno otherwise
  */
-static int ata_dev_configure(struct ata_device *dev, int print_info)
+int ata_dev_configure(struct ata_device *dev, int print_info)
 {
 	struct ata_port *ap = dev->ap;
 	const u16 *id = dev->id;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index d4bb2e4..e3f7406 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,9 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
+			   int post_reset, u16 *id);
+extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
-- 
1.3.2


