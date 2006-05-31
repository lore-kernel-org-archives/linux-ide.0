From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata-hp-prep: make probing related functions global
Date: Wed, 31 May 2006 20:05:42 +0900
Message-ID: <11490735421120-git-send-email-htejun@gmail.com>
References: <1149073540186-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:49050 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964971AbWEaLFy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:05:54 -0400
Received: by nz-out-0102.google.com with SMTP id s18so5533nze
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:05:54 -0700 (PDT)
In-Reply-To: <1149073540186-git-send-email-htejun@gmail.com>
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

a9beec95352ff675f27d74c3cb97dc258d022497
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 04921cf..a9f79b4 100644
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
index 4458fd9..2d704be 100644
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


