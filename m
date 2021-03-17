Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03859C433DB
	for <linux-ide@archiver.kernel.org>; Wed, 17 Mar 2021 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D1864F37
	for <linux-ide@archiver.kernel.org>; Wed, 17 Mar 2021 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhCQSEW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:04:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhCQSEP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2021 14:04:15 -0400
Received: from localhost ([81.170.149.220]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M89XH-1lHvxN0SqB-005F0n for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2021
 19:04:14 +0100
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] libata: add kernel parameter to force ATA_HORKAGE_NO_DMA_LOG
Date:   Wed, 17 Mar 2021 19:04:13 +0100
Message-Id: <20210317180413.2992-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vItrKnW11gdSUFGWGSPqO+SpDKOWViVJzCYsjzWqyOrMzmyyv4l
 BDXpahtxB5RjmiZsVf6e3JqQ9ezDfa3Wqbwu1FEntxNPewr+fGUHl915YhFzCnOeTdSjUkK
 h3aHo3DVoaVo9LZQ+1/hx4x5YYHqinRrU4YFWIIqYtKL6dFJP7BUSDAznz/LoqiX2ATLi5D
 6OBpMhEwg9fKC4puGxUZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRIybGATCBs=:+7I0ce/A+OdG2QDwHv6300
 HOGffa294tgeTDBFoWz80QCMyiPs9QmQ36IYjGJ0eKaRO9SWWBYU65exwNXKFkWMlFb/KaW7q
 X/7gBEJHaIUR9b+6vtKjkES5lISzPR2ipZhKnIoKkpjMFGAjZmw+bTvI1EWNaJoboAeMeLhy0
 xgyEaqvmbACi6zIXzxGUmBnFk7KdELN7eYj80yBQR+sjiicMyBOK4qNhZcrWZaKhlAo3clpGO
 2fit99VOzD8mlqSSZQsiQWGrua9EDk4oBP192LnSTTN5JkMhmGC+G+hAp+Uy/s+16ztwEP+yX
 HDY8lxfq476mO4+XU+kc1pXfrxMcdyMNvL7NF5VQWqXSJZxvLCQrWSL/UHoQW3aqrxrNjdg9F
 nIBj1eHmJD8+VG+UFgiDwynPpe3M7lu6FMp4F24hIubjVETr1KuUcUuUoJYBW5LZdIOHdvYq9
 x7pRdacu1Q==
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

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 drivers/ata/libata-core.c                       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..d2428b3b98f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2473,6 +2473,8 @@
 
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
2.30.2

