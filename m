Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA4C3F68F
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBE221775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o4AxNiGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBGO2e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49631 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgBGO2E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:04 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142803euoutp02948e1fe00dba74cf14d662e993becf0f~xJQ1Q5Lnc2598725987euoutp02P
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142803euoutp02948e1fe00dba74cf14d662e993becf0f~xJQ1Q5Lnc2598725987euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085683;
        bh=cPVvW1M3zaJwYlacqSSXs95FFUUHCM/32ZaFys8F8wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4AxNiGoKNer5iiLHKju90jdqNvpPOYG4mNcv/NwUugvxw11AAagk7qM0z22ngAhR
         RHQUVwf6463XATp5L0AFUAPPBrWOSpl590WS068AjP8FBgguV7bmcKP2zIowb80GoE
         wXO/JWzOnZrw0GhGeU4mFfPIazbwp5qGRIQM68L8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142803eucas1p1c777980a739413e741bbb87300254575~xJQ1BlZlg2844428444eucas1p1v;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.D8.60698.2F37D3E5; Fri,  7
        Feb 2020 14:28:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142802eucas1p29a42ddad0e551a2f2f4e20626d929261~xJQ0rjC2p2441424414eucas1p2i;
        Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142802eusmtrp2b24c9b212d3ae505dccb1435b7cd1a2d~xJQ0rATdn1102911029eusmtrp2L;
        Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-d4-5e3d73f2ff88
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.D5.07950.2F37D3E5; Fri,  7
        Feb 2020 14:28:02 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142802eusmtip27840aca750453b560cc03f5470381db7~xJQ0OIFOX3155831558eusmtip2R;
        Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 23/26] ata: move ata_sas_*() to libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:31 +0100
Message-Id: <20200207142734.8431-24-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7qfi23jDLbpWay+289msXHGelaL
        Z7f2MlmsXH2UyeLYjkdMFpd3zWGzWP5kLbPF3Nbp7A4cHjtn3WX3uHy21OPQ4Q5Gj5Ot31g8
        dt9sYPPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujHvH5zEV7OlgrPj1/S5LA+P//C5GTg4J
        AROJ6ffXMXUxcnEICaxglPi++AEzhPOFUWLBjhtsEM5nRomLr88yw7T8nXEQqmU5o8SX7VNY
        4Vq2ndnIDlLFJmAlMbF9FSOILSKgINHzeyXYKGaB94wSKybtZQFJCAs4SHxc2wk0loODRUBV
        ovuwEkiYV8BW4ue/Y4wQ2+Qltn77xApicwLFP075ywZRIyhxcuYTsDHMQDXNW2eD3S0hsIpd
        4u7O/+wQzS4SvbM+sELYwhKvjm+BistI/N85nwmiYR2jxN+OF1Dd2xkllk/+xwZRZS1x59wv
        NpDrmAU0Jdbv0ocIO0osnTyXESQsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZt
        186V0FD0kOif8YF9AqPiLCTvzELyziyEvQsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefn
        bmIEpqLT/45/3cG470/SIUYBDkYlHt4ER5s4IdbEsuLK3EOMEhzMSiK8faq2cUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwZgrztX/J7VHK5Px/af3t
        +huapqEyD71Yv/6eKFWodLAk9KNZMENTiq2ksOvvvGe9J68UdfVK6xl9X/lkSdad7Gzr16dn
        9Cy+n7zpcwOL4/UJLNvrcqx+fGsWf93DmtJ6cMPbh7mK2Yr7nGV/fHc27i76w5h0J+nLm4uK
        HIxp2S0VNT/kfu1XYinOSDTUYi4qTgQAjvh+7EEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7qfim3jDA69VLdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehn3js9jKtjTwVjx6/tdlgbG//ldjJwcEgImEn9nHGQCsYUEljJKbH1R
        2MXIARSXkTi+vgyiRFjiz7Uuti5GLqCST4wSH89vYwFJsAlYSUxsX8UIYosIKEj0/F4JVsQs
        8JVRYumkbmaQhLCAg8THtZ3MIENZBFQlug8rgYR5BWwlfv47xgixQF5i67dPrCA2J1D845S/
        bBD32Eh8fz+JHaJeUOLkzCdge5mB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5
        xaV56XrJ+bmbGIHxsu3Yzy07GLveBR9iFOBgVOLhTXC0iRNiTSwrrsw9xCjBwawkwtunahsn
        xJuSWFmVWpQfX1Sak1p8iNEU6IeJzFKiyfnAWM4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQ
        nliSmp2aWpBaBNPHxMEp1cC4/CTHygqfc70BoUtm8oofm8b2akN22//UR8K7PIRlc3LVb/Pf
        4TVinPkwcIlkj5sdc7OQ7sNru6uTQx7wlugfCrFr6FXhn3GhaWHHt6U7LmZdj50mOvMn726f
        Wzv3fpq45Oynbtf/h/t/JLcF12wvao27Pfn56Q9HdWVOnpzycvIH8U/TJSfcUGIpzkg01GIu
        Kk4EAAzpbR+tAgAA
X-CMS-MailID: 20200207142802eucas1p29a42ddad0e551a2f2f4e20626d929261
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142802eucas1p29a42ddad0e551a2f2f4e20626d929261
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142802eucas1p29a42ddad0e551a2f2f4e20626d929261
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142802eucas1p29a42ddad0e551a2f2f4e20626d929261@eucas1p2.samsung.com>
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
  19137      23    4096   23256    5ad8 drivers/ata/libata-scsi.o
after:
  18330      23    4096   22449    57b1 drivers/ata/libata-scsi.o

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
index 82c398c93379..50a929adcbd6 100644
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
index 039a2f63e603..33225cb2c6cc 100644
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

