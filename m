Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF51C4338F
	for <linux-ide@archiver.kernel.org>; Sat, 14 Aug 2021 13:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE8A60F48
	for <linux-ide@archiver.kernel.org>; Sat, 14 Aug 2021 13:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhHNNrk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 14 Aug 2021 09:47:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36219 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhHNNrk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 14 Aug 2021 09:47:40 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MumVX-1n4fXh0dbn-00rnrJ; Sat, 14 Aug 2021 15:47:10 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] libata: add kernel parameter to force ATA_HORKAGE_NO_DMA_LOG
Date:   Sat, 14 Aug 2021 15:47:09 +0200
Message-Id: <20210814134709.16085-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B6mywXOBh3vFVSToyV9byjs7fi7kDIWuobcMZme0u3ctnm14B8z
 DUpjL+GjxBCfzt672cQJivddJsjWJ59LlYEQ0X/yrVhI/JQIMYnrW56X5PPhLFlw4bNU/Rs
 NjSrA2T3AHq4valgRrL6duNwZhXQtUsq/+HfFJLfVK80YkqLUcRk29skD5b8/hWhAgxDfVl
 9+wOGSikxVexARB5hPw1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mY/8J2TiAgk=:HajxAIfaivpDRXWP8dfFWv
 eXMJN80P8UJCc5sUyIfA5QR75gMDBL2ya0tmClh2qmwpU3Y+rdKmIrNooEndB6X6rcya7nobB
 kUEoTyr4JW9770C1o7t/nmvXiCq1wam3MTRTHLgKG/R/GbhZftwZsX4eutmncXUCwuAG3Guit
 Hg5CBVSMi74EqHUo+Zwc8zQyOHVZzPE4ds8JFa1vmAF883P8KdRJQCsTyGWrnCMQHVLjGqeBt
 fJe1KshdoG5guFyhaAei3ETRv1X5lZd4RpalOKL1sP8olcWO88+4PSd22nzPTsiCVq3VQwieb
 Z0gHaiBnj1L/OjWZN1R/Os0vDJsKjntrdADUb4ROHf2UpbCtNKlmMDl5Q31m7KQVTYEeiKKkk
 XjWImuBS8/cpQzIzuuvYTrumBdHblE0e+M5pMXpdneOS+7DL0zXqjKM9yMi5Qtfn6cGXwth8g
 vdVGTVIRuklns8u6686vRo93Q2qY3gPDpTFqfy+dteTbHs9w/WN2B/d2mhRka28vm08nEGKTY
 llTq0hm/f3Mgq6TM5aQdSjPC105pCvmaAmIv60WaifdTgkpw3zE+iKskX5RYUzMj0rmO0JQZN
 ihkitqmx3EXfR8JUB1kwNtyVzD0W4OnPkauZnnA9gxPmYFu+F6ySdTwdM+g4W3XE7ltIpRahi
 ycljgV4yZc0BoR8qeehECGBxX7J5P6oCtBhGnU820eXSh13/LvkwA7w1UDmKyRTUxLal30Mk2
 Ek+9x9Q5as0eYrQq+32ItetWCRF4fXo75VLeo26TtJ7ID9mx8ghDeRf2JXPrtRxGkebWqv/oK
 wCHnHiwDn+ydZojn20sYpbIA0APa//N5HsaCgscNMTfxleSVIweWLk6CfkfNHqdgLLO1WBlHL
 RrQzLxKEFo9l+FVQtRgQ==
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
Having an option to disable its use allows booting systems affected,
which besides being a useful workaround is also a necessary
step to allow gathering more debug info on these systems.
Existing workarounds like forcing PIO mode do not work
(in addition to the performance issues) because READ_LOG_DMA
is issued even if PIO mode is forced.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 drivers/ata/libata-core.c                       | 2 ++
 2 files changed, 4 insertions(+)

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
index 61c762961ca8..7fb865333a38 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6104,6 +6104,8 @@ static int __init ata_parse_force_one(char **cur,
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

