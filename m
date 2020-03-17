Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB7EC3F2CE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053EA20735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dAkGGVQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCQOoD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40514 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCQOn4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144354euoutp024ab2d545e3bff06ec69ee08bb247f3be~9HozQkM911582715827euoutp02K
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144354euoutp024ab2d545e3bff06ec69ee08bb247f3be~9HozQkM911582715827euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456234;
        bh=7AgD2WXsvbfyL8Iu4e31kYV7KwzJ7Muu+IpOZ0usqJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAkGGVQ53YKtGPwBKnupzLk4538RxZjpARJZ4MIrqg6IJm5eE+M0JOmeG0bIh+fyS
         wRas78TZjhztKLkvU4atnMD8FNh+/DIWnt908aqq+quURQnKRmrj90fAvv3A5ZbFkV
         jutDi1JyJwzWXdBqGvaVzrWaX6CtAZbqthyJXFoQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144353eucas1p127c3e22104dc18945b312acffa4e673e~9Hoy9T5wj1085610856eucas1p1U;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.F1.60679.922E07E5; Tue, 17
        Mar 2020 14:43:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144353eucas1p163ca190ee937e771b4a583408500070a~9HoyWJdtw1084410844eucas1p1Z;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144353eusmtrp2d087dc70199c4601417b9234258ea49a~9HoyVg4dh0146401464eusmtrp2X;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-58-5e70e229f2c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.33.07950.822E07E5; Tue, 17
        Mar 2020 14:43:52 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144352eusmtip1a8128b45c7d9828284b685bc99392a94~9Hox0fOy90973309733eusmtip1W;
        Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 24/27] ata: move ata_sas_*() to libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:30 +0100
Message-Id: <20200317144333.2904-25-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87qajwriDH7t1rBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBm73x1lKvjRwVhxZN8u9gbG//ldjBwc
        EgImEle2O3cxcnEICaxglFh3+BgrhPOFUWLOrU4WCOczo8SX9+vYYDpedhZAxJczSmw6+xao
        gxOi48DsUBCbTcBKYmL7KkYQW0RAQaLn90o2kAZmgfeMEism7WUBSQgLOEg8eH0TzGYRUJW4
        8vsJM4jNK2Ar8eXBFzYQW0JAXmLrt09gCziB4tcO/2ODqBGUODnzCVgvM1BN89bZzCALJARW
        sUsc+NLFAtHsInH7zWp2CFtY4tXxLVC2jMT/nfOZIBrWMUr87XgB1b2dUWL55H9Qq60l7pz7
        BfYzs4CmxPpd+hBhR4kz1w6yQ4KCT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6d
        K5khbA+JC4sXsk5gVJyF5J1ZSN6ZhbB3ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxN
        jMBEdPrf8S87GHf9STrEKMDBqMTDy7GhIE6INbGsuDL3EKMEB7OSCO/iwvw4Id6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhiljuX0aao0eTO+nGE5s3nf
        H/Z08wNdWcs4w0xn978yao7/n8YaltY67Svz91ni/2N5NOK3ZbKrzkxkCTDMtg3szu8X8W2o
        lYhaOTf0of+SG12podxGk34Hvy3+wu0vHNT4yuL51uV7XY9OWr95UeSEhCDmAt3lC2v/R62/
        P0PyismaK2/fLFZiKc5INNRiLipOBACyJ/S3QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7oajwriDLYft7RYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehm73x1lKvjRwVhxZN8u9gbG//ldjBwcEgImEi87C7oYuTiEBJYySiye
        /YUdIi4jcXx9WRcjJ5ApLPHnWhcbRM0nRokznVcZQRJsAlYSE9tXgdkiAgoSPb9XghUxC3xl
        lFg6qZsZJCEs4CDx4PVNFhCbRUBV4srvJ2BxXgFbiS8PvrBBbJCX2PrtEyuIzQkUv3b4H1hc
        SMBG4sWb/0wQ9YISJ2c+AZvDDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0u
        zUvXS87P3cQIjJhtx35u2cHY9S74EKMAB6MSDy/HhoI4IdbEsuLK3EOMEhzMSiK8iwvz44R4
        UxIrq1KL8uOLSnNSiw8xmgI9MZFZSjQ5HxjNeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGGfdYTnhseD2bKMd1e4v7qw415u3zU6mgsl+hfnFxy1P5h1b/CEy
        efPTU68WWWafXS66zdda/aPB9Hc3NpaxnZz/ydLItK5zduTX/RLRO98mCHbMyp2iK/za/MGb
        zKhOzVWTs3cf6rUNSHn2JzFlS9/2hzMKNF0ql7cX5XHKhVSzHa1lqw7f81KJpTgj0VCLuag4
        EQDSBG4KrgIAAA==
X-CMS-MailID: 20200317144353eucas1p163ca190ee937e771b4a583408500070a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144353eucas1p163ca190ee937e771b4a583408500070a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144353eucas1p163ca190ee937e771b4a583408500070a
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144353eucas1p163ca190ee937e771b4a583408500070a@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* un-inline:
  - ata_scsi_dump_cdb()
  - __ata_scsi_queuecmd()

* un-static:
  - ata_scsi_sdev_config()
  - ata_scsi_dev_config()
  - ata_scsi_dump_cdb()
  - __ata_scsi_queuecmd()

* move ata_sas_*() to libata-sata.c:

* add static inlines for CONFIG_SATA_HOST=n case for
  ata_sas_{allocate,free}_tag()

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  19137      23     576   19736    4d18 drivers/ata/libata-scsi.o
after:
  18330      23     576   18929    49f1 drivers/ata/libata-scsi.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-sata.c | 213 ++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c | 222 +-------------------------------------
 drivers/ata/libata.h      |  19 +++-
 include/linux/libata.h    |  26 ++---
 4 files changed, 246 insertions(+), 234 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c9760b52fb57..ad11a77a307c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -8,10 +8,12 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #include "libata.h"
+#include "libata-transport.h"
 
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
@@ -1059,3 +1061,214 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 	return __ata_change_queue_depth(ap, sdev, queue_depth);
 }
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
+
+/**
+ *	port_alloc - Allocate port for a SAS attached SATA device
+ *	@host: ATA host container for all SAS ports
+ *	@port_info: Information from low-level host driver
+ *	@shost: SCSI host that the scsi device is attached to
+ *
+ *	LOCKING:
+ *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	ata_port pointer on success / NULL on failure.
+ */
+
+struct ata_port *ata_sas_port_alloc(struct ata_host *host,
+				    struct ata_port_info *port_info,
+				    struct Scsi_Host *shost)
+{
+	struct ata_port *ap;
+
+	ap = ata_port_alloc(host);
+	if (!ap)
+		return NULL;
+
+	ap->port_no = 0;
+	ap->lock = &host->lock;
+	ap->pio_mask = port_info->pio_mask;
+	ap->mwdma_mask = port_info->mwdma_mask;
+	ap->udma_mask = port_info->udma_mask;
+	ap->flags |= port_info->flags;
+	ap->ops = port_info->port_ops;
+	ap->cbl = ATA_CBL_SATA;
+
+	return ap;
+}
+EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
+
+/**
+ *	ata_sas_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+int ata_sas_port_start(struct ata_port *ap)
+{
+	/*
+	 * the port is marked as frozen at allocation time, but if we don't
+	 * have new eh, we won't thaw it
+	 */
+	if (!ap->ops->error_handler)
+		ap->pflags &= ~ATA_PFLAG_FROZEN;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_sas_port_start);
+
+/**
+ *	ata_port_stop - Undo ata_sas_port_start()
+ *	@ap: Port to shut down
+ *
+ *	May be used as the port_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+void ata_sas_port_stop(struct ata_port *ap)
+{
+}
+EXPORT_SYMBOL_GPL(ata_sas_port_stop);
+
+/**
+ * ata_sas_async_probe - simply schedule probing and return
+ * @ap: Port to probe
+ *
+ * For batch scheduling of probe for sas attached ata devices, assumes
+ * the port has already been through ata_sas_port_init()
+ */
+void ata_sas_async_probe(struct ata_port *ap)
+{
+	__ata_port_probe(ap);
+}
+EXPORT_SYMBOL_GPL(ata_sas_async_probe);
+
+int ata_sas_sync_probe(struct ata_port *ap)
+{
+	return ata_port_probe(ap);
+}
+EXPORT_SYMBOL_GPL(ata_sas_sync_probe);
+
+
+/**
+ *	ata_sas_port_init - Initialize a SATA device
+ *	@ap: SATA port to initialize
+ *
+ *	LOCKING:
+ *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+int ata_sas_port_init(struct ata_port *ap)
+{
+	int rc = ap->ops->port_start(ap);
+
+	if (rc)
+		return rc;
+	ap->print_id = atomic_inc_return(&ata_print_id);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_sas_port_init);
+
+int ata_sas_tport_add(struct device *parent, struct ata_port *ap)
+{
+	return ata_tport_add(parent, ap);
+}
+EXPORT_SYMBOL_GPL(ata_sas_tport_add);
+
+void ata_sas_tport_delete(struct ata_port *ap)
+{
+	ata_tport_delete(ap);
+}
+EXPORT_SYMBOL_GPL(ata_sas_tport_delete);
+
+/**
+ *	ata_sas_port_destroy - Destroy a SATA port allocated by ata_sas_port_alloc
+ *	@ap: SATA port to destroy
+ *
+ */
+
+void ata_sas_port_destroy(struct ata_port *ap)
+{
+	if (ap->ops->port_stop)
+		ap->ops->port_stop(ap);
+	kfree(ap);
+}
+EXPORT_SYMBOL_GPL(ata_sas_port_destroy);
+
+/**
+ *	ata_sas_slave_configure - Default slave_config routine for libata devices
+ *	@sdev: SCSI device to configure
+ *	@ap: ATA port to which SCSI device is attached
+ *
+ *	RETURNS:
+ *	Zero.
+ */
+
+int ata_sas_slave_configure(struct scsi_device *sdev, struct ata_port *ap)
+{
+	ata_scsi_sdev_config(sdev);
+	ata_scsi_dev_config(sdev, ap->link.device);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_sas_slave_configure);
+
+/**
+ *	ata_sas_queuecmd - Issue SCSI cdb to libata-managed device
+ *	@cmd: SCSI command to be sent
+ *	@ap:	ATA port to which the command is being sent
+ *
+ *	RETURNS:
+ *	Return value from __ata_scsi_queuecmd() if @cmd can be queued,
+ *	0 otherwise.
+ */
+
+int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
+{
+	int rc = 0;
+
+	ata_scsi_dump_cdb(ap, cmd);
+
+	if (likely(ata_dev_enabled(ap->link.device)))
+		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
+	else {
+		cmd->result = (DID_BAD_TARGET << 16);
+		cmd->scsi_done(cmd);
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
+
+int ata_sas_allocate_tag(struct ata_port *ap)
+{
+	unsigned int max_queue = ap->host->n_tags;
+	unsigned int i, tag;
+
+	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
+		tag = tag < max_queue ? tag : 0;
+
+		/* the last tag is reserved for internal command. */
+		if (ata_tag_internal(tag))
+			continue;
+
+		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
+			ap->sas_last_tag = tag;
+			return tag;
+		}
+	}
+	return -1;
+}
+
+void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
+{
+	clear_bit(tag, &ap->sas_tag_allocated);
+}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1000f7b0098b..5215761306e0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -988,7 +988,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
 }
 
-static void ata_scsi_sdev_config(struct scsi_device *sdev)
+void ata_scsi_sdev_config(struct scsi_device *sdev)
 {
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
@@ -1028,8 +1028,7 @@ static int atapi_drain_needed(struct request *rq)
 	return atapi_cmd_type(scsi_req(rq)->cmd[0]) == ATAPI_MISC;
 }
 
-static int ata_scsi_dev_config(struct scsi_device *sdev,
-			       struct ata_device *dev)
+int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 {
 	struct request_queue *q = sdev->request_queue;
 
@@ -3993,8 +3992,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
  *	Prints the contents of a SCSI command via printk().
  */
 
-static inline void ata_scsi_dump_cdb(struct ata_port *ap,
-				     struct scsi_cmnd *cmd)
+void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd)
 {
 #ifdef ATA_VERBOSE_DEBUG
 	struct scsi_device *scsidev = cmd->device;
@@ -4006,8 +4004,7 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #endif
 }
 
-static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-				      struct ata_device *dev)
+int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
@@ -4648,214 +4645,3 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	spin_unlock_irqrestore(ap->lock, flags);
 	mutex_unlock(&ap->scsi_scan_mutex);
 }
-
-/**
- *	ata_sas_port_alloc - Allocate port for a SAS attached SATA device
- *	@host: ATA host container for all SAS ports
- *	@port_info: Information from low-level host driver
- *	@shost: SCSI host that the scsi device is attached to
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *
- *	RETURNS:
- *	ata_port pointer on success / NULL on failure.
- */
-
-struct ata_port *ata_sas_port_alloc(struct ata_host *host,
-				    struct ata_port_info *port_info,
-				    struct Scsi_Host *shost)
-{
-	struct ata_port *ap;
-
-	ap = ata_port_alloc(host);
-	if (!ap)
-		return NULL;
-
-	ap->port_no = 0;
-	ap->lock = &host->lock;
-	ap->pio_mask = port_info->pio_mask;
-	ap->mwdma_mask = port_info->mwdma_mask;
-	ap->udma_mask = port_info->udma_mask;
-	ap->flags |= port_info->flags;
-	ap->ops = port_info->port_ops;
-	ap->cbl = ATA_CBL_SATA;
-
-	return ap;
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
-
-/**
- *	ata_sas_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-int ata_sas_port_start(struct ata_port *ap)
-{
-	/*
-	 * the port is marked as frozen at allocation time, but if we don't
-	 * have new eh, we won't thaw it
-	 */
-	if (!ap->ops->error_handler)
-		ap->pflags &= ~ATA_PFLAG_FROZEN;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_start);
-
-/**
- *	ata_port_stop - Undo ata_sas_port_start()
- *	@ap: Port to shut down
- *
- *	May be used as the port_stop() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-void ata_sas_port_stop(struct ata_port *ap)
-{
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_stop);
-
-/**
- * ata_sas_async_probe - simply schedule probing and return
- * @ap: Port to probe
- *
- * For batch scheduling of probe for sas attached ata devices, assumes
- * the port has already been through ata_sas_port_init()
- */
-void ata_sas_async_probe(struct ata_port *ap)
-{
-	__ata_port_probe(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_async_probe);
-
-int ata_sas_sync_probe(struct ata_port *ap)
-{
-	return ata_port_probe(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_sync_probe);
-
-
-/**
- *	ata_sas_port_init - Initialize a SATA device
- *	@ap: SATA port to initialize
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *
- *	RETURNS:
- *	Zero on success, non-zero on error.
- */
-
-int ata_sas_port_init(struct ata_port *ap)
-{
-	int rc = ap->ops->port_start(ap);
-
-	if (rc)
-		return rc;
-	ap->print_id = atomic_inc_return(&ata_print_id);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_init);
-
-int ata_sas_tport_add(struct device *parent, struct ata_port *ap)
-{
-	return ata_tport_add(parent, ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_tport_add);
-
-void ata_sas_tport_delete(struct ata_port *ap)
-{
-	ata_tport_delete(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_tport_delete);
-
-/**
- *	ata_sas_port_destroy - Destroy a SATA port allocated by ata_sas_port_alloc
- *	@ap: SATA port to destroy
- *
- */
-
-void ata_sas_port_destroy(struct ata_port *ap)
-{
-	if (ap->ops->port_stop)
-		ap->ops->port_stop(ap);
-	kfree(ap);
-}
-EXPORT_SYMBOL_GPL(ata_sas_port_destroy);
-
-/**
- *	ata_sas_slave_configure - Default slave_config routine for libata devices
- *	@sdev: SCSI device to configure
- *	@ap: ATA port to which SCSI device is attached
- *
- *	RETURNS:
- *	Zero.
- */
-
-int ata_sas_slave_configure(struct scsi_device *sdev, struct ata_port *ap)
-{
-	ata_scsi_sdev_config(sdev);
-	ata_scsi_dev_config(sdev, ap->link.device);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_sas_slave_configure);
-
-/**
- *	ata_sas_queuecmd - Issue SCSI cdb to libata-managed device
- *	@cmd: SCSI command to be sent
- *	@ap:	ATA port to which the command is being sent
- *
- *	RETURNS:
- *	Return value from __ata_scsi_queuecmd() if @cmd can be queued,
- *	0 otherwise.
- */
-
-int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
-{
-	int rc = 0;
-
-	ata_scsi_dump_cdb(ap, cmd);
-
-	if (likely(ata_dev_enabled(ap->link.device)))
-		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
-	else {
-		cmd->result = (DID_BAD_TARGET << 16);
-		cmd->scsi_done(cmd);
-	}
-	return rc;
-}
-EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
-
-int ata_sas_allocate_tag(struct ata_port *ap)
-{
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
-
-	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
-		tag = tag < max_queue ? tag : 0;
-
-		/* the last tag is reserved for internal command. */
-		if (ata_tag_internal(tag))
-			continue;
-
-		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
-			ap->sas_last_tag = tag;
-			return tag;
-		}
-	}
-	return -1;
-}
-
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
-{
-	clear_bit(tag, &ap->sas_tag_allocated);
-}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ce3f3c039572..6c808cf39135 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -87,6 +87,18 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
+/* libata-sata.c */
+#ifdef CONFIG_SATA_HOST
+int ata_sas_allocate_tag(struct ata_port *ap);
+void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
+#else
+static inline int ata_sas_allocate_tag(struct ata_port *ap)
+{
+	return -EOPNOTSUPP;
+}
+static inline void ata_sas_free_tag(unsigned int tag, struct ata_port *ap) { }
+#endif
+
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
@@ -130,9 +142,10 @@ extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, u64 lun);
-int ata_sas_allocate_tag(struct ata_port *ap);
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
-
+void ata_scsi_sdev_config(struct scsi_device *sdev);
+int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev);
+void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd);
+int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
 
 /* libata-eh.c */
 extern unsigned long ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cc14030c139e..2d81ea2ccf12 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1087,19 +1087,6 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
 extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
-extern void ata_sas_port_destroy(struct ata_port *);
-extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
-					   struct ata_port_info *,
-					   struct Scsi_Host *);
-extern void ata_sas_async_probe(struct ata_port *ap);
-extern int ata_sas_sync_probe(struct ata_port *ap);
-extern int ata_sas_port_init(struct ata_port *);
-extern int ata_sas_port_start(struct ata_port *ap);
-extern int ata_sas_tport_add(struct device *parent, struct ata_port *ap);
-extern void ata_sas_tport_delete(struct ata_port *ap);
-extern void ata_sas_port_stop(struct ata_port *ap);
-extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
-extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
 extern bool ata_link_online(struct ata_link *link);
 extern bool ata_link_offline(struct ata_link *link);
 #ifdef CONFIG_PM
@@ -1237,6 +1224,19 @@ extern int sata_link_debounce(struct ata_link *link,
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
                             bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
+extern void ata_sas_port_destroy(struct ata_port *);
+extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
+					   struct ata_port_info *,
+					   struct Scsi_Host *);
+extern void ata_sas_async_probe(struct ata_port *ap);
+extern int ata_sas_sync_probe(struct ata_port *ap);
+extern int ata_sas_port_init(struct ata_port *);
+extern int ata_sas_port_start(struct ata_port *ap);
+extern int ata_sas_tport_add(struct device *parent, struct ata_port *ap);
+extern void ata_sas_tport_delete(struct ata_port *ap);
+extern void ata_sas_port_stop(struct ata_port *ap);
+extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
+extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
                          u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
-- 
2.24.1

