From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/15] libata: make two functions global
Date: Sat, 24 Jun 2006 20:30:19 +0900
Message-ID: <11511486193686-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60455 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S933041AbWFXLaN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:13 -0400
Received: by py-out-1112.google.com with SMTP id t32so931832pyc
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:13 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_do_simple_cmd() and ata_flush_cache() global.  These will be
used from libata-eh.c.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 ++--
 drivers/scsi/libata.h      |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

e2e9ba22088d9511fb376e5e397f0515537ac5ab
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4a44e75..60e80e3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1145,7 +1145,7 @@ unsigned ata_exec_internal(struct ata_de
  *	RETURNS:
  *	Zero on success, AC_ERR_* mask on failure
  */
-static unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
+unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
 {
 	struct ata_taskfile tf;
 
@@ -4973,7 +4973,7 @@ int ata_port_offline(struct ata_port *ap
 	return 0;
 }
 
-static int ata_flush_cache(struct ata_device *dev)
+int ata_flush_cache(struct ata_device *dev)
 {
 	unsigned int err_mask;
 	u8 cmd;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index bdd4888..16ce23a 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,7 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
@@ -64,6 +65,7 @@ extern int ata_check_atapi_dma(struct at
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern int ata_flush_cache(struct ata_device *dev);
 extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
-- 
1.3.2


