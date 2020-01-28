Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E50C33CB2
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEED22522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AS5HJMu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA1NfC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52378 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgA1NeS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133416euoutp0253c930be76be71e498651666373812c8~uEFBA8tXb2932529325euoutp02L
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133416euoutp0253c930be76be71e498651666373812c8~uEFBA8tXb2932529325euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218456;
        bh=YJuztuDcbtIa1CTQmlrIwWwmuUQVBn+CSkuRet1nkR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AS5HJMu8y1zv72dmiZLal3rxhpOhbK/1NnaztVv+l7HyRdyBVMQcfxlvVVeY/xYDt
         UM/rceEbn6aCWezx6btP3QJ3IYNKOFjKSxv/ZOjCWk70QTpW8kvPy8bamoRnkNnF/S
         i1AaFQPPeX7QSNhsFwHzUtQuxBpvt0JdChGKqYT0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133415eucas1p24a251a44e423d3382f722c7a2bf472d7~uEFAzRnRQ1867618676eucas1p2e;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8F.CA.61286.758303E5; Tue, 28
        Jan 2020 13:34:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30~uEFAUmukq0087500875eucas1p1-;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133415eusmtrp2326360a694214c3d920da348f5247054~uEFAT_xGq0330003300eusmtrp21;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-84-5e303857529c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 93.92.08375.758303E5; Tue, 28
        Jan 2020 13:34:15 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133415eusmtip2980e30d713ad90fcf10fd3e1397f9405~uEE--HvAl0685506855eusmtip2X;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 14/28] ata: move ata_dev_config_ncq*() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:29 +0100
Message-Id: <20200128133343.29905-15-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7rhFgZxBg++mlisvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK2Nak1vBybCK6bPWMzYwLnbtYuTgkBAwkbg5W6mLkYtDSGAFo8Tjv1dYIZwv
        jBKHtvUzQzifGSXmblgBlOEE6zjwfR1U1XJGicMXXjLDtfzYvZUFpIpNwEpiYvsqRhBbREBB
        ouf3SjaQImaBNYwSqw43gSWEBXwkNs+4yw5iswioSrzrfswOchSvgJ1E4x4hiG3yElu/fWIF
        CXMChXv2moOEeQUEJU7OfAK2ihmopHnrbLAbJAS62SU2nNjHBtHrIvF9/WdmCFtY4tXxLewQ
        tozE/53zmSAa1jFK/O14AdW9nVFi+eR/UN3WEnfO/WID2cwsoCmxfpc+RNhRYvedB6yQwOOT
        uPFWEOIIPolJ26YzQ4R5JTraoM5Xk9iwbAMbzNqunSuhzvGQuDxzG/sERsVZSN6ZheSdWQh7
        FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMLqf/Hf+0g/HrpaRDjAIcjEo8vDNU
        DOKEWBPLiitzDzFKcDArifB2MgGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKa
        nZpakFoEk2Xi4JRqYCyM5ue6XfVymaq75tbkCTY6K4SyHxjNM/nRdi5YcL7/pn/H5/ySFc9i
        W6B4ee7UEJuOHC2e62E5b3gfqE/jvBHce5h9Scf5CQWpN1at+nJhnprKln8cfgUxuwRPsly5
        r7vgEOts4dRAy4VvNDqfChpoVjzTUPRraXEKErIXzatbF6FRkeV0QImlOCPRUIu5qDgRAK3Y
        JVMqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4Pd1wC4M4gymLRCxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzGtya3gZFjF
        9FnrGRsYF7t2MXJySAiYSBz4vo61i5GLQ0hgKaPE8dapjF2MHEAJGYnj68sgaoQl/lzrYgOx
        hQQ+MUp82+MAYrMJWElMbF/FCGKLCChI9PxeyQYyh1lgA6PEq5tfWEASwgI+Eptn3GUHsVkE
        VCXedT9mB5nPK2An0bhHCGK+vMTWb59YQcKcQOGeveYQq2wl1p95ygpi8woISpyc+QRsIjNQ
        efPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzACth37uXkH46WN
        wYcYBTgYlXh4Z6gYxAmxJpYVV+YeYpTgYFYS4e1kAgrxpiRWVqUW5ccXleakFh9iNAV6YSKz
        lGhyPjA680riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MCo+iS+Y
        Ud+psa3jYpyNK7/y+8b/JpOSbu98KJDGWi708ewPxd2flQ5nzzISzk/hmbff+GqNrOGy7FNB
        C9zfP9j0/bv+/Fm6i3KmsBRK3zt9/HAds22g8fL8r/I3Xn76Zt15eUbzhAtT9ff+2pf+6uc8
        vR/MtT+5qu79rg9TPJps9qLjh/yvxHVKLMUZiYZazEXFiQAMSQwPlgIAAA==
X-CMS-MailID: 20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_log_supported() to libata.h and make it inline

* move ata_dev_config_ncq*() to libata-core-sata.c

* add static inline version of ata_dev_config_ncq() for
  CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  36627     572      40   37239    9177 drivers/ata/libata-core.o
after:
  35499     572      40   36111    8d0f drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 138 ++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 148 ---------------------------------
 drivers/ata/libata.h           |  18 ++++
 3 files changed, 156 insertions(+), 148 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index fed8009981c0..f2629e069a55 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -120,6 +120,144 @@ int ata_do_link_spd_horkage(struct ata_device *dev)
 	return 0;
 }
 
+static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	unsigned int err_mask;
+
+	if (!ata_log_supported(dev, ATA_LOG_NCQ_SEND_RECV)) {
+		ata_dev_warn(dev, "NCQ Send/Recv Log not supported\n");
+		return;
+	}
+	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_SEND_RECV,
+				     0, ap->sector_buf, 1);
+	if (err_mask) {
+		ata_dev_dbg(dev,
+			    "failed to get NCQ Send/Recv Log Emask 0x%x\n",
+			    err_mask);
+	} else {
+		u8 *cmds = dev->ncq_send_recv_cmds;
+
+		dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
+		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_SEND_RECV_SIZE);
+
+		if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM) {
+			ata_dev_dbg(dev, "disabling queued TRIM support\n");
+			cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &=
+				~ATA_LOG_NCQ_SEND_RECV_DSM_TRIM;
+		}
+	}
+}
+
+static void ata_dev_config_ncq_non_data(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	unsigned int err_mask;
+
+	if (!ata_log_supported(dev, ATA_LOG_NCQ_NON_DATA)) {
+		ata_dev_warn(dev,
+			     "NCQ Send/Recv Log not supported\n");
+		return;
+	}
+	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_NON_DATA,
+				     0, ap->sector_buf, 1);
+	if (err_mask) {
+		ata_dev_dbg(dev,
+			    "failed to get NCQ Non-Data Log Emask 0x%x\n",
+			    err_mask);
+	} else {
+		u8 *cmds = dev->ncq_non_data_cmds;
+
+		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_NON_DATA_SIZE);
+	}
+}
+
+static void ata_dev_config_ncq_prio(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	unsigned int err_mask;
+
+	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE)) {
+		dev->flags &= ~ATA_DFLAG_NCQ_PRIO;
+		return;
+	}
+
+	err_mask = ata_read_log_page(dev,
+				     ATA_LOG_IDENTIFY_DEVICE,
+				     ATA_LOG_SATA_SETTINGS,
+				     ap->sector_buf,
+				     1);
+	if (err_mask) {
+		ata_dev_dbg(dev,
+			    "failed to get Identify Device data, Emask 0x%x\n",
+			    err_mask);
+		return;
+	}
+
+	if (ap->sector_buf[ATA_LOG_NCQ_PRIO_OFFSET] & BIT(3)) {
+		dev->flags |= ATA_DFLAG_NCQ_PRIO;
+	} else {
+		dev->flags &= ~ATA_DFLAG_NCQ_PRIO;
+		ata_dev_dbg(dev, "SATA page does not support priority\n");
+	}
+
+}
+
+int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz)
+{
+	struct ata_port *ap = dev->link->ap;
+	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
+	unsigned int err_mask;
+	char *aa_desc = "";
+
+	if (!ata_id_has_ncq(dev->id)) {
+		desc[0] = '\0';
+		return 0;
+	}
+	if (dev->horkage & ATA_HORKAGE_NONCQ) {
+		snprintf(desc, desc_sz, "NCQ (not used)");
+		return 0;
+	}
+	if (ap->flags & ATA_FLAG_NCQ) {
+		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
+		dev->flags |= ATA_DFLAG_NCQ;
+	}
+
+	if (!(dev->horkage & ATA_HORKAGE_BROKEN_FPDMA_AA) &&
+		(ap->flags & ATA_FLAG_FPDMA_AA) &&
+		ata_id_has_fpdma_aa(dev->id)) {
+		err_mask = ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
+			SATA_FPDMA_AA);
+		if (err_mask) {
+			ata_dev_err(dev,
+				    "failed to enable AA (error_mask=0x%x)\n",
+				    err_mask);
+			if (err_mask != AC_ERR_DEV) {
+				dev->horkage |= ATA_HORKAGE_BROKEN_FPDMA_AA;
+				return -EIO;
+			}
+		} else
+			aa_desc = ", AA";
+	}
+
+	if (hdepth >= ddepth)
+		snprintf(desc, desc_sz, "NCQ (depth %d)%s", ddepth, aa_desc);
+	else
+		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
+			ddepth, aa_desc);
+
+	if ((ap->flags & ATA_FLAG_FPDMA_AUX)) {
+		if (ata_id_has_ncq_send_and_recv(dev->id))
+			ata_dev_config_ncq_send_recv(dev);
+		if (ata_id_has_ncq_non_data(dev->id))
+			ata_dev_config_ncq_non_data(dev);
+		if (ata_id_has_ncq_prio(dev->id))
+			ata_dev_config_ncq_prio(dev);
+	}
+
+	return 0;
+}
+
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
  *	@link: ATA link to manipulate SControl for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 52bd81bad484..0a90e0e65f0b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2034,15 +2034,6 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	return err_mask;
 }
 
-static bool ata_log_supported(struct ata_device *dev, u8 log)
-{
-	struct ata_port *ap = dev->link->ap;
-
-	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, ap->sector_buf, 1))
-		return false;
-	return get_unaligned_le16(&ap->sector_buf[log * 2]) ? true : false;
-}
-
 static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
 {
 	struct ata_port *ap = dev->link->ap;
@@ -2084,145 +2075,6 @@ static inline u8 ata_dev_knobble(struct ata_device *dev)
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
-static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
-{
-	struct ata_port *ap = dev->link->ap;
-	unsigned int err_mask;
-
-	if (!ata_log_supported(dev, ATA_LOG_NCQ_SEND_RECV)) {
-		ata_dev_warn(dev, "NCQ Send/Recv Log not supported\n");
-		return;
-	}
-	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_SEND_RECV,
-				     0, ap->sector_buf, 1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get NCQ Send/Recv Log Emask 0x%x\n",
-			    err_mask);
-	} else {
-		u8 *cmds = dev->ncq_send_recv_cmds;
-
-		dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
-		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_SEND_RECV_SIZE);
-
-		if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM) {
-			ata_dev_dbg(dev, "disabling queued TRIM support\n");
-			cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &=
-				~ATA_LOG_NCQ_SEND_RECV_DSM_TRIM;
-		}
-	}
-}
-
-static void ata_dev_config_ncq_non_data(struct ata_device *dev)
-{
-	struct ata_port *ap = dev->link->ap;
-	unsigned int err_mask;
-
-	if (!ata_log_supported(dev, ATA_LOG_NCQ_NON_DATA)) {
-		ata_dev_warn(dev,
-			     "NCQ Send/Recv Log not supported\n");
-		return;
-	}
-	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_NON_DATA,
-				     0, ap->sector_buf, 1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get NCQ Non-Data Log Emask 0x%x\n",
-			    err_mask);
-	} else {
-		u8 *cmds = dev->ncq_non_data_cmds;
-
-		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_NON_DATA_SIZE);
-	}
-}
-
-static void ata_dev_config_ncq_prio(struct ata_device *dev)
-{
-	struct ata_port *ap = dev->link->ap;
-	unsigned int err_mask;
-
-	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE)) {
-		dev->flags &= ~ATA_DFLAG_NCQ_PRIO;
-		return;
-	}
-
-	err_mask = ata_read_log_page(dev,
-				     ATA_LOG_IDENTIFY_DEVICE,
-				     ATA_LOG_SATA_SETTINGS,
-				     ap->sector_buf,
-				     1);
-	if (err_mask) {
-		ata_dev_dbg(dev,
-			    "failed to get Identify Device data, Emask 0x%x\n",
-			    err_mask);
-		return;
-	}
-
-	if (ap->sector_buf[ATA_LOG_NCQ_PRIO_OFFSET] & BIT(3)) {
-		dev->flags |= ATA_DFLAG_NCQ_PRIO;
-	} else {
-		dev->flags &= ~ATA_DFLAG_NCQ_PRIO;
-		ata_dev_dbg(dev, "SATA page does not support priority\n");
-	}
-
-}
-
-static int ata_dev_config_ncq(struct ata_device *dev,
-			       char *desc, size_t desc_sz)
-{
-	struct ata_port *ap = dev->link->ap;
-	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
-	unsigned int err_mask;
-	char *aa_desc = "";
-
-	if (!ata_id_has_ncq(dev->id)) {
-		desc[0] = '\0';
-		return 0;
-	}
-	if (dev->horkage & ATA_HORKAGE_NONCQ) {
-		snprintf(desc, desc_sz, "NCQ (not used)");
-		return 0;
-	}
-	if (ap->flags & ATA_FLAG_NCQ) {
-		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
-		dev->flags |= ATA_DFLAG_NCQ;
-	}
-
-	if (!(dev->horkage & ATA_HORKAGE_BROKEN_FPDMA_AA) &&
-		(ap->flags & ATA_FLAG_FPDMA_AA) &&
-		ata_id_has_fpdma_aa(dev->id)) {
-		err_mask = ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
-			SATA_FPDMA_AA);
-		if (err_mask) {
-			ata_dev_err(dev,
-				    "failed to enable AA (error_mask=0x%x)\n",
-				    err_mask);
-			if (err_mask != AC_ERR_DEV) {
-				dev->horkage |= ATA_HORKAGE_BROKEN_FPDMA_AA;
-				return -EIO;
-			}
-		} else
-			aa_desc = ", AA";
-	}
-
-	if (hdepth >= ddepth)
-		snprintf(desc, desc_sz, "NCQ (depth %d)%s", ddepth, aa_desc);
-	else
-		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
-			ddepth, aa_desc);
-
-	if ((ap->flags & ATA_FLAG_FPDMA_AUX)) {
-		if (ata_id_has_ncq_send_and_recv(dev->id))
-			ata_dev_config_ncq_send_recv(dev);
-		if (ata_id_has_ncq_non_data(dev->id))
-			ata_dev_config_ncq_non_data(dev);
-		if (ata_id_has_ncq_prio(dev->id))
-			ata_dev_config_ncq_prio(dev);
-	}
-
-	return 0;
-}
-
 static void ata_dev_config_sense_reporting(struct ata_device *dev)
 {
 	unsigned int err_mask;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 9eebe4e0be39..24b08efd79a3 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -15,6 +15,8 @@
 #define DRV_NAME	"libata"
 #define DRV_VERSION	"3.00"	/* must be exactly four chars */
 
+#include <asm/unaligned.h>
+
 /* libata-core.c */
 enum {
 	/* flags for ata_dev_read_id() */
@@ -85,13 +87,29 @@ extern void __ata_port_probe(struct ata_port *ap);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
 
+static inline bool ata_log_supported(struct ata_device *dev, u8 log)
+{
+	struct ata_port *ap = dev->link->ap;
+
+	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, ap->sector_buf, 1))
+		return false;
+	return get_unaligned_le16(&ap->sector_buf[log * 2]) ? true : false;
+}
+
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
 /* libata-core-sata.c */
 #ifdef CONFIG_SATA_HOST
 int ata_do_link_spd_horkage(struct ata_device *dev);
+int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz);
 #else
 static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
+static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
+				     size_t desc_sz)
+{
+	desc[0] = '\0';
+	return 0;
+}
 #endif
 
 /* libata-acpi.c */
-- 
2.24.1

