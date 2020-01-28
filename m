Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEAC2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F822522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rR//N+6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgA1NeV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58987 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgA1NeT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133418euoutp01641fc49598555bc078cf51da1eb05de3~uEFDEeMT00325703257euoutp01O
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133418euoutp01641fc49598555bc078cf51da1eb05de3~uEFDEeMT00325703257euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218458;
        bh=8/d83X2GMFWte90CRHDeZ11Hw0OcTRKjIJ3T+rqa7hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rR//N+6N3692tTC8smygh/ol6oO7xZM1eqgOr6e4d4cNYsUGlMFIXrJBwiFZf+7jP
         /lBusZbZ4O3Ik6OO0zz31pnI7/HJl/6mRkQEex+JTE9TQyopf/AAuxUMlC7dmNeJFc
         fGJqG/MAuA6Y0DK7mbYM15Y2byihG1fw6iDJ2mZs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133418eucas1p1d67cd1530bcba3b151ca7243c0919915~uEFC3AGGS1375113751eucas1p1J;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 76.5A.60679.A58303E5; Tue, 28
        Jan 2020 13:34:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133417eucas1p27f91558f4b86f6951d2f9f1ed19d84b5~uEFCjq-xu2469924699eucas1p2z;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133417eusmtrp262dad9ac779ad03c2d198d880f7afeeb~uEFCjIntb0330103301eusmtrp25;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-59-5e30385aa0c3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C5.92.08375.958303E5; Tue, 28
        Jan 2020 13:34:17 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133417eusmtip22a22b559b3fd1c74a17a98ecdced0af9~uEFCJwRAA0657106571eusmtip2k;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 21/28] ata: move ata_qc_complete_multiple() to
 libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:36 +0100
Message-Id: <20200128133343.29905-22-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7pRFgZxBn1XWSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAldE16S1LwVH9iu1bTrM1MJ5S62Lk5JAQMJE4tq2PrYuRi0NIYAWjREfDDhYI
        5wujxLwX11ghnM+MEguvbmCFaXn1uo8dIrGcUeLwy4lscC3Trz5iBqliE7CSmNi+ihHEFhFQ
        kOj5vRKsiFlgDaPEqsNNYAlhgWCJFTOnMoHYLAKqEjsXfAFr5hWwk7h76BMbxDp5ia3fPgGt
        5uDgBIr37DWHKBGUODnzCQuIzQxU0rx1NjNEeTu7xOeNdRC2i8TBbWug4sISr45vYYewZST+
        75zPBHKPhMA6Rom/HS+YIZztjBLLJ/+DWmwtcefcLzaQxcwCmhLrd+lDhB0lDkybww4SlhDg
        k7jxVhDiBj6JSdumM0OEeSU62oQgqtUkNizbwAaztmvnSqhzPCQOXv3PPoFRcRaSb2Yh+WYW
        wt4FjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPM6X/Hv+xg3PUn6RCjAAejEg/v
        DBWDOCHWxLLiytxDjBIczEoivJ1MQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeW
        pGanphakFsFkmTg4pRoYFa/PWt6qviT/dpztbmYp19RPv9fc13/ydh175p3LLmL96f/7H2aX
        /ir7paDvv0A66ofz4cTQedOZpAQKzzt1GRpPnnVq2+NZslcMn83/6B6e/+HQwsNy1fc/SOR8
        KznhEKfUJBF8ISlZ2VOnxW7mtTLXzT861vAY6Wlccgy4m+D3tq3Y6s1MJZbijERDLeai4kQA
        79Lk6ywDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd1IC4M4gzOnNCxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9E16S1LwVH9
        iu1bTrM1MJ5S62Lk5JAQMJF49bqPvYuRi0NIYCmjRP/CA2xdjBxACRmJ4+vLIGqEJf5c62KD
        qPnEKPG++wwLSIJNwEpiYvsqRhBbREBBouf3SrAiZoENjBKvbn4BKxIWCJSYv/MwG4jNIqAq
        sXPBF2YQm1fATuLuoU9sEBvkJbZ++8QKspgTKN6z1xwkLCRgK7H+zFNWiHJBiZMzn4CNZAYq
        b946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbBtmM/N+9gvLQx
        +BCjAAejEg/vDBWDOCHWxLLiytxDjBIczEoivJ1MQCHelMTKqtSi/Pii0pzU4kOMpkA/TGSW
        Ek3OB8ZoXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxil9xrOj
        K3c8tuC5xPhoQp13tX7/vg3Hmn17/RY73F53MqSyOqY0ttlDK1vpHxOPieTT/771IZFOPcuy
        2mLaZwVaflvls3Q/Z8N/4UrfG0063LxtardiHqy6t82bvYLj/nnD60pHgh1r2Fpt1ogL6BoW
        8YdmT723Wv80z4S/Ov8XcHYb/q5UYinOSDTUYi4qTgQAcA23f5kCAAA=
X-CMS-MailID: 20200128133417eucas1p27f91558f4b86f6951d2f9f1ed19d84b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133417eucas1p27f91558f4b86f6951d2f9f1ed19d84b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133417eucas1p27f91558f4b86f6951d2f9f1ed19d84b5
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133417eucas1p27f91558f4b86f6951d2f9f1ed19d84b5@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_qc_complete_multiple() to libata-core-sata.c

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  33212     572      40   33824    8420 drivers/ata/libata-core.o
after:
  32815     572      40   33427    8293 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 59 ++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 59 ----------------------------------
 include/linux/libata.h         |  2 +-
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index 8c6ed82dc166..5749aa57c352 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -772,6 +772,65 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
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
  *	sata_link_init_spd - Initialize link->sata_spd_limit
  *	@link: Link to configure sata_spd_limit for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 17f1d98eab71..204e64ff4b93 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4456,65 +4456,6 @@ u64 ata_qc_get_active(struct ata_port *ap)
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 453322cdf64a..62e962b62c5d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1166,7 +1166,6 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
-extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
@@ -1202,6 +1201,7 @@ extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 #else
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
-- 
2.24.1

