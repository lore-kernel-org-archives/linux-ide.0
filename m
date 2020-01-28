Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C81C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB1424686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sh5PcppA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgA1Ned (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52342 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgA1NeV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133419euoutp02b581f101726ca5420c5015e35b211ae3~uEFEhpC_t2858228582euoutp02E
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133419euoutp02b581f101726ca5420c5015e35b211ae3~uEFEhpC_t2858228582euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218459;
        bh=WpsHicWI94p87coMzYSnYFtFCARkHKWCi7JZ46kLA9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sh5PcppA5Hy37R5qnoRIL+ZerCl/lPrxZaw2ZtU+DHsl4OB+rlLWlmqKWNKTxmfUw
         KUiTY8Slw9IaxuZ7HDmSQbRshfOmpM1GVuqJ1u2IDCe7xhc016j2KAz8Y4WAxnf+Ue
         rHqlsjnF9r9fv00E+kHyUgM4FH5m/ksai1qbFhnA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133419eucas1p2e3e53db27b652a58a528288bd2494d55~uEFEEFcxJ1867618676eucas1p2i;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.DA.61286.B58303E5; Tue, 28
        Jan 2020 13:34:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133419eucas1p14f7ed619db42aba72e83b7814f45a3bc~uEFDwMkT81372113721eucas1p1K;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133419eusmtrp2b6532c6678dc7fbfe353fcdee4bac300~uEFDvog9_0330103301eusmtrp29;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-90-5e30385b2027
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.82.07950.A58303E5; Tue, 28
        Jan 2020 13:34:19 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133418eusmtip2ae9dafbb54bbb7080dffc7f6e032afa6~uEFDa96ud0685506855eusmtip2c;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 25/28] ata: move ata_sas_*() to libata-scsi-sata.c
Date:   Tue, 28 Jan 2020 14:33:40 +0100
Message-Id: <20200128133343.29905-26-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7rRFgZxBh8XiVqsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+P3V/WCFy2MFS2TLjA3ML7N6WLk5JAQMJFY8Xg/SxcjF4eQwApGiXW7D0A5
        Xxgl/t1rYIVwPjNK9G14zwLTMmnqB2YQW0hgOaPEyd+2cB0HD9wCK2ITsJKY2L6KEcQWEVCQ
        6Pm9kg2kiFlgDaPEqsNNYAlhASeJq1/fg9ksAqoSS79eBrN5BewkJh1pZYPYJi+x9dsnoDM4
        ODiB4j17zSFKBCVOznwCtosZqKR562xmkPkSAu3sEo/27WWG6HWRWP3nJNTVwhKvjm9hh7Bl
        JP7vnM8E0bCOUeJvxwuo7u2MEssn/4PabC1x59wvNpDNzAKaEut36UOEHSV23uxgBAlLCPBJ
        3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl1GkeEkc3XGeawKg4C8k7s5C8Mwth
        7wJG5lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBCeb0v+OfdjB+vZR0iFGAg1GJh3eG
        ikGcEGtiWXFl7iFGCQ5mJRHeTiagEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tS
        s1NTC1KLYLJMHJxSDYxN7KvKL+WIGngLqF4rs1tQceZy0IOv/6expUtt6q9SqzCbbp3Swnlj
        Rc6cXxbz/FYe+svp7FMW08DBGWLV2SI8sV9K3d1W72YT57fvK+0L/i0PX/XZwGP9rVXrI08+
        PWv7xP102iamD2k79ZRnxqeYL/JpdzC+k/YxZMuugH9KT5U2t5tNY1ViKc5INNRiLipOBAAp
        D7/qLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd1oC4M4g4MHGS1W3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/H7q3rBixbG
        ipZJF5gbGN/mdDFyckgImEhMmvqBuYuRi0NIYCmjxLYXd4EcDqCEjMTx9WUQNcISf651sUHU
        fGKUOP7vNxtIgk3ASmJi+ypGEFtEQEGi5/dKsCJmgQ2MEq9ufmEBSQgLOElc/foerIhFQFVi
        6dfLYDavgJ3EpCOtbBAb5CW2fvvECrKYEyjes9ccJCwkYCux/sxTVohyQYmTM5+AjWQGKm/e
        Opt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGwbZjP7fsYOx6F3yI
        UYCDUYmH10HJIE6INbGsuDL3EKMEB7OSCG8nE1CINyWxsiq1KD++qDQntfgQoynQDxOZpUST
        84ExmlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXFFz9vWhdVX
        D++WkzloFXv9cvzTdIvAW/vfPMg/ONH1mvbGu++vCXO/6rEV4s5SO6nzO810Rlx9vdb+Ex1r
        Wmzeb5jXqmS+NuqclvGfL1OvVc6TVGC+837LwhMvVqvv2z27ijVtQYpeaeuFDxWf2SX69zJL
        3ZgmwLwyePZPhyreRj1uZob6RnElluKMREMt5qLiRACBqGplmQIAAA==
X-CMS-MailID: 20200128133419eucas1p14f7ed619db42aba72e83b7814f45a3bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133419eucas1p14f7ed619db42aba72e83b7814f45a3bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133419eucas1p14f7ed619db42aba72e83b7814f45a3bc
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133419eucas1p14f7ed619db42aba72e83b7814f45a3bc@eucas1p1.samsung.com>
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

* move ata_sas_*() to libata-scsi-sata.c:

* add static inlines for CONFIG_SATA_HOST=n case for
  ata_sas_{allocate,free}_tag()

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  19137      23    4096   23256    5ad8 drivers/ata/libata-scsi.o
after:
  18330      23    4096   22449    57b1 drivers/ata/libata-scsi.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi-sata.c | 213 +++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c      | 222 +--------------------------------
 drivers/ata/libata.h           |  13 ++
 include/linux/libata.h         |  24 ++--
 4 files changed, 242 insertions(+), 230 deletions(-)

diff --git a/drivers/ata/libata-scsi-sata.c b/drivers/ata/libata-scsi-sata.c
index da7d8344d003..bc60841c4045 100644
--- a/drivers/ata/libata-scsi-sata.c
+++ b/drivers/ata/libata-scsi-sata.c
@@ -7,10 +7,12 @@
  */
 
 #include <linux/kernel.h>
+#include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #include "libata.h"
+#include "libata-transport.h"
 
 static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_UNKNOWN]		= "max_performance",
@@ -308,3 +310,214 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
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
index 2c479e48c4c9..2bb87a3e7a62 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -171,8 +171,21 @@ extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, u64 lun);
+void ata_scsi_sdev_config(struct scsi_device *sdev);
+int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev);
+void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd);
+int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
+/* libata-scsi-sata.c */
+#ifdef CONFIG_SATA_HOST
 int ata_sas_allocate_tag(struct ata_port *ap);
 void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
+#else
+static inline int ata_sas_allocate_tag(struct ata_port *ap)
+{
+	return -EOPNOTSUPP;
+}
+static inline void ata_sas_free_tag(unsigned int tag, struct ata_port *ap) { }
+#endif
 
 
 /* libata-eh.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4b6ac3eda0c9..eb2797c27547 100644
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
@@ -1196,6 +1184,18 @@ extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
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
 extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
-- 
2.24.1

