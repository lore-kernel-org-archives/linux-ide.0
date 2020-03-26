Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB0C2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319C22076A
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m6SgG2ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgCZP7U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52764 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgCZP6u (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155848euoutp026500b5fa6df3a100368582b489a0765c~-5dxv-Y820068800688euoutp02q
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155848euoutp026500b5fa6df3a100368582b489a0765c~-5dxv-Y820068800688euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238328;
        bh=mUdKzVw9E5Ypfhtc3A8SGx31D64x8DTDK1w4rz1Wye8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6SgG2ap1/gmstCNH3Fw+f0aizlDVWiFsvTLbPRxnrxCESEfecKTocJg94zD8KLTI
         2wEqbnk7j9Qa3QPruu6sRBl4JQ9cCODJhnNdTHzLO2gHm8ohiyupD/Rbiz4gB50PtZ
         F9pM60HqDcv/4veeXLWcuIHqTxigVtVs+RS7fKlA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155848eucas1p1bb026c23c4e1b3d99d1ce837d9006f5c~-5dxhGEaC2821828218eucas1p13;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 18.F7.60698.831DC7E5; Thu, 26
        Mar 2020 15:58:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155848eucas1p2f3c45c3f3a26da7950118a88a1a65502~-5dxLpeUs2646526465eucas1p2I;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155848eusmtrp167370cd85eb32cfc8b2584bfc82268a3~-5dxLDhhm2090020900eusmtrp1y;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-a2-5e7cd1387539
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.DA.07950.831DC7E5; Thu, 26
        Mar 2020 15:58:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155847eusmtip10f2c9b2f767b55e43bdc54a2ae9f7105~-5dwyMh4y1572315723eusmtip1u;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 24/27] ata: move ata_sas_*() to libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:19 +0100
Message-Id: <20200326155822.19400-25-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7oWF2viDB5dkbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnrP5xmLHjZwVixdEYnSwPj0oIuRk4O
        CQETiQNTDzB3MXJxCAmsYJTYe3cnC4TzhVFi/6PzUJnPjBJ/tz1ih2mZ9bWLGcQWEljOKNGx
        UATCBur4fCYSxGYTsJKY2L6KEcQWEVCQ6Pm9kg1kELPAe0aJFZP2soAkhAUcJB4/7GADsVkE
        VCUalpwGi/MK2EmsfLaBGWKZvMTWb59YQWxOoPjydfOZIWoEJU7OfAJWzwxU07x1NtilEgKr
        2CWufb/GCtHsIvHmwSUmCFtY4tXxLVAfyEicntzDAtGwDui1jhdQ3dsZJZZP/scGUWUtcefc
        LyCbA2iFpsT6XfoQYUeJL++vsoOEJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJDcs2sMGs
        7dq5EuovD4ne2yuZJjAqzkLyziwk78xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+
        7iZGYCo6/e/41x2M+/4kHWIU4GBU4uFtaKuJE2JNLCuuzD3EKMHBrCTC+zQSKMSbklhZlVqU
        H19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOj0Qdz+ZX9YbLaNcftdNh7
        Pn4JuX34Ns+MBRd0z1r9fG1yrz5VKvCfbfXibxIHa7U7lRaKzitaJqSfODM1ZEnQhhfc816v
        E11Z/P6zol+tf/O5ud6KVzu/eK0Rv2RU1LSdV2n7tca2V3HJIn3i/w8s9PQILDz+7kkbs69I
        4OyPL812KHGs8A9QYinOSDTUYi4qTgQA9JRqiUEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7oWF2viDGa1cVisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYz1H04zFrzsYKxYOqOTpYFxaUEXIyeHhICJxKyvXcxdjFwcQgJLGSU+
        zuxm7WLkAErISBxfXwZRIyzx51oXG0TNJ0aJuUeuMIMk2ASsJCa2r2IEsUUEFCR6fq8EK2IW
        +MoosXRSN1iRsICDxOOHHWwgNouAqkTDktMsIDavgJ3EymcbmCE2yEts/faJFcTmBIovXzcf
        LC4kYCux+MsHJoh6QYmTM5+A9TID1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQJjZtuxn1t2MHa9Cz7EKMDBqMTDq9FSEyfEmlhWXJl7iFGCg1lJhPdpJFCI
        NyWxsiq1KD++qDQntfgQoynQExOZpUST84HxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgXEim2rWihnG7AkL71RvcN9z3oUtO7/46hTX3wVH1kfuZp1lKTQv
        9/Of3yc69syf3ptQmsTSaVVmyPuoZ01x/KFFE5w6xfU/Jsw8q3NwrdidI6/z4kp7nWZ25d6y
        bua2Nln/pOPm1j37u0TF+6aEBTKuf3FC4OOGC6aBght6bK5c1Nsz1ajBMUuJpTgj0VCLuag4
        EQCo476arwIAAA==
X-CMS-MailID: 20200326155848eucas1p2f3c45c3f3a26da7950118a88a1a65502
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155848eucas1p2f3c45c3f3a26da7950118a88a1a65502
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155848eucas1p2f3c45c3f3a26da7950118a88a1a65502
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155848eucas1p2f3c45c3f3a26da7950118a88a1a65502@eucas1p2.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index a5dfcd9e09a1..36e588d88b95 100644
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
 
@@ -4005,8 +4004,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
  *	Prints the contents of a SCSI command via printk().
  */
 
-static inline void ata_scsi_dump_cdb(struct ata_port *ap,
-				     struct scsi_cmnd *cmd)
+void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd)
 {
 #ifdef ATA_VERBOSE_DEBUG
 	struct scsi_device *scsidev = cmd->device;
@@ -4018,8 +4016,7 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #endif
 }
 
-static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-				      struct ata_device *dev)
+int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
@@ -4662,214 +4659,3 @@ void ata_scsi_dev_rescan(struct work_struct *work)
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
index ae74fd048a32..da899f18a3e9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1094,18 +1094,6 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
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
@@ -1235,6 +1223,18 @@ extern int sata_link_debounce(struct ata_link *link,
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

