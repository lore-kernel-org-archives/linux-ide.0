Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00BBC35DF9
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D417246AD
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OtMtwCx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgB0SXY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39769 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731002AbgB0SWu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:50 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182249euoutp0144e85fbbaf125d74204eb7e26bab613a~3VXhwZqxG1368713687euoutp01Z
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182249euoutp0144e85fbbaf125d74204eb7e26bab613a~3VXhwZqxG1368713687euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827769;
        bh=xl4NuS0WvtwJ4asa0rRMbFJsgfM9u4nsZ8hije3TDXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtMtwCx3RCSKSSnGB0F511QseyYKmdlshBXWWSIGFaIEd5G5teFwzl7SC/bMuYjgP
         WlcDWyE10AOj/PsiJSAf4quMWQ9BsDa1vCDClFKos22R3NTrPhXsmt1v9jspUPL273
         dP8s4NJBYGqmxJN3dRcX+3E1dGysE5+9zdKXHvTU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182249eucas1p2380667ebce493122bd94390c7da941ec~3VXhQRojP3197531975eucas1p2H;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.5F.60679.9F8085E5; Thu, 27
        Feb 2020 18:22:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182248eucas1p12149429eae76c2a869d7323ab9abff1e~3VXg_nvfG1935019350eucas1p1v;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182248eusmtrp1a7506e45da7a653833fd0ba28587d2cd~3VXg9_HH90110301103eusmtrp1g;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-bc-5e5808f9a5fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.61.07950.8F8085E5; Thu, 27
        Feb 2020 18:22:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182248eusmtip21a35ebe080d4e64bfc668f9b38b53da6~3VXge2zk22149421494eusmtip2L;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 21/27] ata: move ata_qc_complete_multiple() to
 libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:20 +0100
Message-Id: <20200227182226.19188-22-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87o/OSLiDD5/47ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBl39txnKWjWr9i5vZe9gXGKWhcjJ4eE
        gInE7yPvGbsYuTiEBFYwSmz/+RnK+cIosfNtHwuE8xkos+0SK0zL51lP2CESyxkl2s99ZAZJ
        gLX07/AEsdkErCQmtq9iBLFFBBQken6vZANpYBZ4zyixYtJeoLEcHMICgRInW7VAalgEVCUO
        r1/BBmLzCthJ7J6ziBFimbzE1m+fwBZzAsVv9G2HqhGUODnzCQuIzQxU07x1NjNE/Sp2iafP
        RUHGSwi4SHw/KgkRFpZ4dXwLO4QtI3F6cg/YYxIC6xgl/na8YIZwtjNKLJ/8jw2iylrizrlf
        bCCDmAU0Jdbv0ocIO0rM+budBWI+n8SNt4IQJ/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07
        V0Jd6SExb901xgmMirOQPDMLyTOzEPYuYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJ
        EZiETv87/mUH464/SYcYBTgYlXh4F+wIjxNiTSwrrsw9xCjBwawkwrvxa2icEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYx8eyfMsrYt2pVffX+CoVFN
        UvAcYYadhoofD/yX4PzuMqPskTXTh/8va3LkTSfpT1W0iWCpXX2E88IqmadvdoqtXd3ha/Qy
        yFH9p9f9qb71fwRfX/PNXCKx49CRWxOztgi9u2ZQcrXP2rV38dPV8Q6Vs96d+RP5Zv2ioqvL
        kiytTzRHzZOoPntLiaU4I9FQi7moOBEAe0ArYT4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7o/OCLiDG7cMLVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehl39txnKWjWr9i5vZe9gXGKWhcjJ4eEgInE51lP2LsYuTiEBJYyStx8
        eYKxi5EDKCEjcXx9GUSNsMSfa11sEDWfGCVmrT3MBpJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYQF/iX/P9rKD2CwCqhKH168Aa+YVsJPYPWcRI8QGeYmt3z6xgticQPEbfdvB
        aoQEbCW6Op4yQtQLSpyc+YQFxGYGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfm
        Fpfmpesl5+duYgRGzLZjP7fsYOx6F3yIUYCDUYmH12NbeJwQa2JZcWXuIUYJDmYlEd6NX0Pj
        hHhTEiurUovy44tKc1KLDzGaAj0xkVlKNDkfGM15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoYDRZGSSl3B7RMMDg1+71V/lQNw5IQ/5vH023X8uv3s3zOKMvI
        DG5dsiu+6vzd9ngH7UbBg6GTD8iczG9uCNiTl60etfmuVfWN5q6PrH0yfl0ps637ilbqn54t
        fkbv7pTAW/c7o1XaQ5r+Oaxs9q6fVRT85O9OQWeLoqCUwElBXE/FVjPda1FiKc5INNRiLipO
        BADOOkMergIAAA==
X-CMS-MailID: 20200227182248eucas1p12149429eae76c2a869d7323ab9abff1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182248eucas1p12149429eae76c2a869d7323ab9abff1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182248eucas1p12149429eae76c2a869d7323ab9abff1e
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182248eucas1p12149429eae76c2a869d7323ab9abff1e@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_qc_complete_multiple() to libata-sata.c

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32559     572      40   33171    8193 drivers/ata/libata-core.o
after:
  32162     572      40   32774    8006 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 59 ---------------------------------------
 drivers/ata/libata-sata.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  2 +-
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 19624d056d92..2ef0960b2154 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4749,65 +4749,6 @@ u64 ata_qc_get_active(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_qc_get_active);
 
-/**
- *	ata_qc_complete_multiple - Complete multiple qcs successfully
- *	@ap: port in question
- *	@qc_active: new qc_active mask
- *
- *	Complete in-flight commands.  This functions is meant to be
- *	called from low-level driver's interrupt routine to complete
- *	requests normally.  ap->qc_active and @qc_active is compared
- *	and commands are completed accordingly.
- *
- *	Always use this function when completing multiple NCQ commands
- *	from IRQ handlers instead of calling ata_qc_complete()
- *	multiple times to keep IRQ expect status properly in sync.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	Number of completed commands on success, -errno otherwise.
- */
-int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
-{
-	u64 done_mask, ap_qc_active = ap->qc_active;
-	int nr_done = 0;
-
-	/*
-	 * If the internal tag is set on ap->qc_active, then we care about
-	 * bit0 on the passed in qc_active mask. Move that bit up to match
-	 * the internal tag.
-	 */
-	if (ap_qc_active & (1ULL << ATA_TAG_INTERNAL)) {
-		qc_active |= (qc_active & 0x01) << ATA_TAG_INTERNAL;
-		qc_active ^= qc_active & 0x01;
-	}
-
-	done_mask = ap_qc_active ^ qc_active;
-
-	if (unlikely(done_mask & qc_active)) {
-		ata_port_err(ap, "illegal qc_active transition (%08llx->%08llx)\n",
-			     ap->qc_active, qc_active);
-		return -EINVAL;
-	}
-
-	while (done_mask) {
-		struct ata_queued_cmd *qc;
-		unsigned int tag = __ffs64(done_mask);
-
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
-			ata_qc_complete(qc);
-			nr_done++;
-		}
-		done_mask &= ~(1ULL << tag);
-	}
-
-	return nr_done;
-}
-EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
-
 /**
  *	ata_qc_issue - issue taskfile to device
  *	@qc: command to issue to device
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 05a1872ba329..849582e0d653 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -603,6 +603,65 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 
+/**
+ *	ata_qc_complete_multiple - Complete multiple qcs successfully
+ *	@ap: port in question
+ *	@qc_active: new qc_active mask
+ *
+ *	Complete in-flight commands.  This functions is meant to be
+ *	called from low-level driver's interrupt routine to complete
+ *	requests normally.  ap->qc_active and @qc_active is compared
+ *	and commands are completed accordingly.
+ *
+ *	Always use this function when completing multiple NCQ commands
+ *	from IRQ handlers instead of calling ata_qc_complete()
+ *	multiple times to keep IRQ expect status properly in sync.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Number of completed commands on success, -errno otherwise.
+ */
+int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
+{
+	u64 done_mask, ap_qc_active = ap->qc_active;
+	int nr_done = 0;
+
+	/*
+	 * If the internal tag is set on ap->qc_active, then we care about
+	 * bit0 on the passed in qc_active mask. Move that bit up to match
+	 * the internal tag.
+	 */
+	if (ap_qc_active & (1ULL << ATA_TAG_INTERNAL)) {
+		qc_active |= (qc_active & 0x01) << ATA_TAG_INTERNAL;
+		qc_active ^= qc_active & 0x01;
+	}
+
+	done_mask = ap_qc_active ^ qc_active;
+
+	if (unlikely(done_mask & qc_active)) {
+		ata_port_err(ap, "illegal qc_active transition (%08llx->%08llx)\n",
+			     ap->qc_active, qc_active);
+		return -EINVAL;
+	}
+
+	while (done_mask) {
+		struct ata_queued_cmd *qc;
+		unsigned int tag = __ffs64(done_mask);
+
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			ata_qc_complete(qc);
+			nr_done++;
+		}
+		done_mask &= ~(1ULL << tag);
+	}
+
+	return nr_done;
+}
+EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bf13af0c47ae..8fdfe5e4e6e9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1162,7 +1162,6 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
-extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
@@ -1234,6 +1233,7 @@ extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

