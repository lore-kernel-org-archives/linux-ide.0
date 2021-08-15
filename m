Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D352C4338F
	for <linux-ide@archiver.kernel.org>; Sun, 15 Aug 2021 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05BC611C4
	for <linux-ide@archiver.kernel.org>; Sun, 15 Aug 2021 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhHOQ2Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Aug 2021 12:28:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhHOQ2P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2021 12:28:15 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3lLh-1mFaEN0ftD-000xYJ; Sun, 15 Aug 2021 18:27:28 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic cases.
Date:   Sun, 15 Aug 2021 18:27:25 +0200
Message-Id: <20210815162725.15124-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YRjN4oULwmNKI/yi@infradead.org>
References: <YRjN4oULwmNKI/yi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FqEZwcKwv3A4oiFIvCkxpwy0upSJi+3qFZx8PY6J1pRkqPKR7FP
 54iENpSN94dgUlFDObAHwTSbgJbWYWewfZv3wXXVKUoUCRZd+v7WLBOhuYX3gsj46nHl3g+
 WPpi5h4a/ppELVrCoL4BPHNAuh6FUy17BGAUSBr1cPjjZcWiPWX0e69cxvvrdJQsFqwTEFk
 P/qbnTneLGYsG6IU2JewA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mumqLsXfrM4=:+hQjxKG2nyOg8f2ouknpmZ
 pIqTqEUwMv5wAX8DDHPlBfq5xGvalJKWYaLCrqXuxT4jNubO3rpYExpw3BeLHoXvxgFPoIb1L
 2OD/T4jHHVnOivvhF1JGGMWGbfPAph0iaIthYN8imkoYrLxKsek//cXHWkoIheKP90Rr8QoAH
 qP1xb7Ekt2qvbYK2YHZYn59mCEIuBEPv/zJyw4JDGuvknWGqcRL2/IRe/7lhmcApM4JfuK+/l
 CGWrs3G3TYlHLgMxnMNwY0+jE1SLMz06jkUe39YUTPkIRIxDf3OgBEftFe4u6j1PoQN+9NjPM
 jWa4kt0aR/+1884rANmX5k/FmhtmAm+fkOVMn1tQvLCaDqoD1WVLI9S2S5fmW3yBo4UGZmnEB
 Gx3RgY78b7HJg2GsND+0idy5cOf7uUKVWSHaNj+nuJMusvz9ptzIRc6z4fi/sMYseukhyZZVo
 /vfC3PgsVvA385CnP3QOHwRGkiKuf+8ywpVBwIeRAXEPt6ULtzAYk+3sJd20GdtL6ZunhnqlC
 D48Nh+049WhCzv99QaFg0QZmU5Q6uDtcgWcOIPCCIASPqAAH3i+rof/LYm/mvkswCHRd0XWRj
 /MpvUuzVR6v/2wC0pRJoob4Kq1QtOmcGbZLhNB8wG5UlKMD3bCK5LmXfbLdBcvxKKQVvcirpO
 Zk1G7cr8NhrOCNfViSbY1cO+9uftpp9EUzPXwu80OZxpwyn9exPa2NCKFeG0oKokK3DE+0ebF
 ivYY8JOd/wjaQVFn7Zef97jbQphbzDaWqPqLCOpyADXkfL53WBLbbjOZrugcReiyl1JXM+6OL
 k1CbnzPR15Qk/dhyaVe/xtHz2NPb6YQVSCTnjrOYQSO5yQfnVU32HVDCg9KusaQX246nprr3r
 srfCv1V82w7wjR5cJ9Ng==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The ATA_CMD_READ_LOG_DMA_EXT can cause controller/device to
become unresponsive until the next power cycle.
This seems to particularly affect IDE to SATA adapters,
possibly in combination with certain SATA SSDs, though
there might be more/different cases.
Comment 5 of https://bugzilla.kernel.org/show_bug.cgi?id=195895
is an example.
Disable it by default on Crucial MX500 devices and all
PATA controllers.
Also add an option to set the workaround state, which might
help with gathering more data on the exact devices/controllers
affected, and speed up narrowing down the cause for users that
are affect but not covered by the added quirks.
Existing workarounds like forcing PIO mode do not work
(in addition to the performance issues) because READ_LOG_DMA
is issued even if PIO mode is forced.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 drivers/ata/libata-core.c                       | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..191502e8fa74 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2551,6 +2551,8 @@
 
 			* [no]ncqtrim: Turn off queued DSM TRIM.
 
+			* [no]dmalog: Turn off use of ATA_CMD_READ_LOG_DMA_EXT (0x47) command
+
 			* nohrst, nosrst, norst: suppress hard, soft
 			  and both resets.
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 61c762961ca8..219fa92ffc06 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2004,7 +2004,11 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 retry:
 	ata_tf_init(dev, &tf);
+	/* Do not even attempt DMA with PATA-SATA adapters, they seem likely to
+	 * hang, see https://bugzilla.kernel.org/show_bug.cgi?id=195895
+	 */
 	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
+	    (ap_flags & ATA_FLAG_SATA) &&
 	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
@@ -4000,6 +4004,15 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 
+	/* Devices with observed READ LOG DMA issues - unclear if only
+	 * specific firmware versions or only in combination with specific
+	 * controllers.
+	 * Specifically broken combinations reported
+	 * CT1000MX500SSD4, M3CR020 with B350M-Mortar
+	 * CT500MX500SSD4, M3CR023 with PATA-SATA adapter
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=195895
+	 */
+	{ "Crucial_CT*MX500*",		NULL,	ATA_HORKAGE_NO_DMA_LOG },
 	/* End Marker */
 	{ }
 };
@@ -6104,6 +6117,8 @@ static int __init ata_parse_force_one(char **cur,
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
 		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
 		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
+		{ "nodmalog",	.horkage_on	= ATA_HORKAGE_NO_DMA_LOG },
+		{ "dmalog",	.horkage_off	= ATA_HORKAGE_NO_DMA_LOG },
 		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },
-- 
2.32.0

