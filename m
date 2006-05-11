From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/14] libata-hp-prep: make probing related functions global
Date: Fri, 12 May 2006 00:11:59 +0900
Message-ID: <11473603193866-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:58102 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751849AbWEKPMO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:14 -0400
Received: by py-out-1112.google.com with SMTP id f28so279580pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:13 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hotplug will be implemented in libata-eh.c.  Make ata_dev_read_id()
and ata_dev_configure() global.

---

 drivers/scsi/libata-core.c |    6 +++---
 drivers/scsi/libata.h      |    3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

8d89cdee6d673f4e1915b3ec587dafec44456942
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1f587aa..1861373 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1164,8 +1164,8 @@ unsigned int ata_pio_need_iordy(const st
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
@@ -1289,7 +1289,7 @@ static void ata_dev_config_ncq(struct at
  *	RETURNS:
  *	0 on success, -errno otherwise
  */
-static int ata_dev_configure(struct ata_device *dev, int print_info)
+int ata_dev_configure(struct ata_device *dev, int print_info)
 {
 	struct ata_port *ap = dev->ap;
 	const u16 *id = dev->id;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index ff50442..24dd534 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,9 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
+			   int post_reset, u16 *id);
+extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern int ata_down_sata_spd_limit(struct ata_port *ap);
 extern int ata_set_sata_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
-- 
1.2.4


