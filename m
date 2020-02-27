Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0686C35E1C
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CAC2469C
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O8qLtn00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgB0SXD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39703 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbgB0SWw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182251euoutp0146fb36b165bdf273a25775b89d24d85a~3VXi3_ziH1058810588euoutp01J
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182251euoutp0146fb36b165bdf273a25775b89d24d85a~3VXi3_ziH1058810588euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827771;
        bh=oekqajbjZk0ccGtNojRkwQZhaFJW+Dtult/vDSHixuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8qLtn00kN0sQQ1dtYYmFLPAR1vb87sK+Oq3wg5PPmD7qEGx/8MQOMVVDTKx2SUfk
         0GynmMVZCdR9FPxGfdUINMZghl/z148KpAoiKca932B7oyC81slqw29ziV104rOpdy
         c8HydDaL4NYnSWo0p1rSEBdriH6gFvTIAzGryH4g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182250eucas1p280ccc620234e6506fec29baa51215ea5~3VXilCWyd3195631956eucas1p2H;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 59.5F.60679.AF8085E5; Thu, 27
        Feb 2020 18:22:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182250eucas1p1885e8264beb19b9d6eba638748fd1ff0~3VXiRvsG01933419334eucas1p1u;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182250eusmtrp2532f5257d16421aed10ef3dfdd342135~3VXiRKI4_1813218132eusmtrp2x;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-be-5e5808fa41bd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.C1.08375.AF8085E5; Thu, 27
        Feb 2020 18:22:50 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182249eusmtip2731882a7f131b82deb964892692835f8~3VXh0zi2f0595905959eusmtip2p;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 24/27] ata: move ata_sas_*() to libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:23 +0100
Message-Id: <20200227182226.19188-25-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87q/OCLiDD5uV7FYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnLZzSxF+zpYKxYPq+ZpYHxb34XIyeH
        hICJxI9P2xi7GLk4hARWMErc2/mLBSQhJPCFUeLVBy6IxGdGiZtrrzPCdEw8OoMNIrGcUeJG
        Syc7hAPUcXHFFFaQKjYBK4mJ7avAOkQEFCR6fq8E62AWeM8osWLSXrAdwgIOEhuWnwazWQRU
        JQ49fMkOYvMK2Elcf94LtU5eYuu3T2BDOYHiN/q2s0HUCEqcnPkErJcZqKZ562xmkAUSAqvY
        JXo/XmSBaHaRuL2kFcoWlnh1fAs7hC0j8X/nfCaIhnWMEn87XkB1b2eUWD75HxtElbXEnXO/
        gGwOoBWaEut36UOEHSWuHH7DDhKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SQ2LNvABrO2
        a+dKZgjbQ6Jx7T3mCYyKs5C8MwvJO7MQ9i5gZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yf
        u4kRmIxO/zv+ZQfjrj9JhxgFOBiVeHgX7AiPE2JNLCuuzD3EKMHBrCTCu/FraJwQb0piZVVq
        UX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjOsrzpy/8Xh9ysW8tY8f
        i58pTMtbv+rdV5sT0hduWthqv/uYbLjEYVVJ4SHPGX92n+AWr9tq9s26X/LHspM+9+f+SLp+
        wm4Ki9970/Lun1YzZe7uF0oxqQnj7ri5durhpfPmLXuQW826fGFtz87rmxl2PW1LtalWOlfk
        veG34jeGnbqa+io1ejOVWIozEg21mIuKEwGXmmjlQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7q/OCLiDHrfCFusvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzlM5rYC/Z0MFYsn9fM0sD4N7+LkZNDQsBEYuLRGWxdjFwcQgJLGSUW
        vJjC2sXIAZSQkTi+vgyiRljiz7UuqJpPjBKrVp1lBUmwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsICDxIblp1lAbBYBVYlDD1+yg9i8AnYS15/3MkJskJfY+u0T2FBOoPiNvu1s
        ILaQgK1EV8dTRoh6QYmTM5+AzWEGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgTGzLZjPzfvYLy0MfgQowAHoxIP74Id4XFCrIllxZW5hxglOJiVRHg3fg2N
        E+JNSaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YDznlcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpgVAqonyj+drv1fFPbc49Ziv/Z8rzznv8klW1aZst6u0/ba9fw
        a25aMH1edn/HhecC7jUFF/vqD8+7Z2Gb/lvq8+PdRZIHcrKq53zbwpwzz3PWibC/kV1tGZ7y
        N+IV2BY4BkyeMffQJQNW7ejm2xzO/Hm204xurz+lpd182amkiCme40OKaSOfEktxRqKhFnNR
        cSIA4Zilo68CAAA=
X-CMS-MailID: 20200227182250eucas1p1885e8264beb19b9d6eba638748fd1ff0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182250eucas1p1885e8264beb19b9d6eba638748fd1ff0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182250eucas1p1885e8264beb19b9d6eba638748fd1ff0
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182250eucas1p1885e8264beb19b9d6eba638748fd1ff0@eucas1p1.samsung.com>
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
 include/linux/libata.h    |  24 ++---
 4 files changed, 245 insertions(+), 233 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 341699f5af20..2d934ccfc930 100644
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
@@ -1062,3 +1064,214 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
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
index 6d295d0396d0..08d40dce7200 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -987,7 +987,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
 }
 
-static void ata_scsi_sdev_config(struct scsi_device *sdev)
+void ata_scsi_sdev_config(struct scsi_device *sdev)
 {
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
@@ -1027,8 +1027,7 @@ static int atapi_drain_needed(struct request *rq)
 	return atapi_cmd_type(scsi_req(rq)->cmd[0]) == ATAPI_MISC;
 }
 
-static int ata_scsi_dev_config(struct scsi_device *sdev,
-			       struct ata_device *dev)
+int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 {
 	struct request_queue *q = sdev->request_queue;
 
@@ -4004,8 +4003,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
  *	Prints the contents of a SCSI command via printk().
  */
 
-static inline void ata_scsi_dump_cdb(struct ata_port *ap,
-				     struct scsi_cmnd *cmd)
+void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd)
 {
 #ifdef ATA_VERBOSE_DEBUG
 	struct scsi_device *scsidev = cmd->device;
@@ -4017,8 +4015,7 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #endif
 }
 
-static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-				      struct ata_device *dev)
+int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
@@ -4635,214 +4632,3 @@ void ata_scsi_dev_rescan(struct work_struct *work)
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
index 08c4c365fd98..550adfa05cc1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1096,18 +1096,6 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
 extern int ata_scsi_queuecmd(struct Scsi_Host *h, struct scsi_cmnd *cmd);
 extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
-extern void ata_sas_port_destroy(struct ata_port *);
-extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
-					   struct ata_port_info *, struct Scsi_Host *);
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
@@ -1237,6 +1225,18 @@ extern int sata_link_debounce(struct ata_link *link,
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
+extern void ata_sas_port_destroy(struct ata_port *);
+extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
+					   struct ata_port_info *, struct Scsi_Host *);
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

