Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E78DC10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC322073E
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QQaAIi6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCQOo1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40387 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgCQOnx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144352euoutp02d01c10a7f7aeeb9101daa6bb76b689d0~9HoxYqB9P1539915399euoutp02c
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144352euoutp02d01c10a7f7aeeb9101daa6bb76b689d0~9HoxYqB9P1539915399euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456232;
        bh=xWD0eKXRUt8GfRBQc6yizp5EATCbxvvTFgPTowSCZeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQaAIi6Ixg9XCAOn5xUoe2e4Ky0dPVa/L/5oE7lAOfOQpKB+Rda8BOBw8nuZ4SQ1A
         XzhcCfzc05FzjgUJmzb4yAtYZQCeWDEcReSR6Gyz005Qcc8aCkyf44Wd6v32yn01kq
         xzyLKQe6cY0W3/NwjnOvpO/Q/7gSopBbhbVPaBy8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144351eucas1p1544f0b649b717b9b34c61942c369f699~9HoxCoKs-1084010840eucas1p1b;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B4.E3.61286.722E07E5; Tue, 17
        Mar 2020 14:43:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144351eucas1p1d8d18236e6729d0bf21737a4296f56d7~9How1UvhC1085710857eucas1p1L;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200317144351eusmtrp17a10275e6375f96d5b310ae74f37d793~9How0sfnl0867908679eusmtrp1u;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-3c-5e70e2276f99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.E4.08375.722E07E5; Tue, 17
        Mar 2020 14:43:51 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144350eusmtip19edc1c274a340eef9ab91ed5db7a5b09~9HowWesoS0453304533eusmtip1j;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 21/27] ata: move ata_qc_complete_multiple() to
 libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:27 +0100
Message-Id: <20200317144333.2904-22-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87rqjwriDFqeq1msvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErow53ZOYCqbrVzw5dI6lgXGKWhcjJ4eE
        gIlEd/sqli5GLg4hgRWMEjO3zGKCcL4AOXd/sEM4nxklpm1awAzTsvDdJFaIxHJGieMzjjHD
        tWxv+AxWxSZgJTGxfRUjiC0ioCDR83slG0gRs8B7RokVk/aygCSEBQIldm1dADSKg4NFQFXi
        0S0wk1fAVmL2ljqIZfISW799YgWxOYHC1w7/YwOxeQUEJU7OfAI2hRmopnnrbLAbJATWsUt8
        2z2bDaLZReLJ5x4mCFtY4tXxLewQtozE6ck9LFANjBJ/O15AdW9nlFg++R9Ut7XEnXO/2EAu
        YhbQlFi/Sx8i7CjRdnERWFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuh
        geghsbt3I/sERsVZSN6ZheSdWQh7FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhM
        RKf/Hf+0g/HrpaRDjAIcjEo8vBwbCuKEWBPLiitzDzFKcDArifAuLsyPE+JNSaysSi3Kjy8q
        zUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoHRQk3YNj7Fy6mFc7Mtw7Z9WnEc
        l/yO8/4V5Jge+cwrfNflly1LWAsWyP/+9HYnl+9brUo71e5zHxvNov4t4jt1vexztOcEB7Ft
        V4+e/XhKLF3U/9LPSztDCn+bFLK4dssu+mClEc1ZIKGzN8+3MJ5pV0D67sD85X0OXVvmirh8
        Kv0YpPDdWlWJpTgj0VCLuag4EQDKjhPEQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7rqjwriDK7PE7NYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlzuicxFUzXr3hy6BxLA+MUtS5GTg4JAROJhe8msXYxcnEICSxllDi3
        YT9TFyMHUEJG4vj6MogaYYk/17rYIGo+MUpcbb7JApJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYQF/iRUfbzODDGURUJV4dIsVxOQVsJWYvaUOYr68xNZvn1hBbE6g8LXD/9hA
        bCEBG4kXb/4zgdi8AoISJ2c+AVvLDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjJZtx35u3sF4aWPwIUYBDkYlHl6ODQVxQqyJZcWVuYcYJTiYlUR4Fxfm
        xwnxpiRWVqUW5ccXleakFh9iNAV6YSKzlGhyPjCS80riDU0NzS0sDc2NzY3NLJTEeTsEDsYI
        CaQnlqRmp6YWpBbB9DFxcEo1MMbYP326oSyidXVs3U9epqUNB/ce3+F9oHvrMfXvnw09udpv
        v4qQvHit7Mt9zpjIPskrH90KZ5yN++G0bw0HW3r2k9+tN11eRkziPfd1twub7YnmuVlHDfvf
        bdWZ1LD8Z/PZ0y1b9badmTW9VL05zZrXyX9uU8Ht+IsT+C9vUJdYEBkisWfpZX0lluKMREMt
        5qLiRABtLb6hrAIAAA==
X-CMS-MailID: 20200317144351eucas1p1d8d18236e6729d0bf21737a4296f56d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144351eucas1p1d8d18236e6729d0bf21737a4296f56d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144351eucas1p1d8d18236e6729d0bf21737a4296f56d7
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144351eucas1p1d8d18236e6729d0bf21737a4296f56d7@eucas1p1.samsung.com>
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
index 1879072419fe..d246bc1e08c9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4757,65 +4757,6 @@ u64 ata_qc_get_active(struct ata_port *ap)
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
index ccd60f71ca31..57344f87b4e0 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -600,6 +600,65 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
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
index ecee9544fb86..d9cb7768fb64 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1157,7 +1157,6 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
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

