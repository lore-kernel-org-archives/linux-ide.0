Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE74C4338F
	for <linux-ide@archiver.kernel.org>; Mon, 16 Aug 2021 17:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3106A6054E
	for <linux-ide@archiver.kernel.org>; Mon, 16 Aug 2021 17:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhHPRQh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:16:37 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhHPRQh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2021 13:16:37 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeknF-1mq6tR3CMP-00anaf; Mon, 16 Aug 2021 19:15:44 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic cases.
Date:   Mon, 16 Aug 2021 19:15:43 +0200
Message-Id: <20210816171543.11059-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8lUiZpkkeK2H2te/7c0AwWm9eRlgDlogWPxjSytnnzAlThQc+uo
 90kUH+t5zytWvxqYn/j472Z1lN2QpFzkq9MA7KVbiSpG7nagpK0NwS9nqntEatAErZT4nhU
 x5nccKvfPQahHEeweXju64W/eW3LBpHx0SUDiCT1RLVytJH88occQ1hOxU3S9MCnUTLImLC
 vO+K8jTgy8Y2eI0X40dKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MQHN0AD/mwI=:i2FSoLcyHAph265MUyEMZN
 2+DaXrv/CyOME4xOXUTjEtwfGAXoO1hpoMN2NSOIpJ0a6MQlPHF+n8Dhg6e4l0EhRGuuR/XtJ
 edWXZAT8dEQJktUXcI0yWgEVUcC3om4oWCoxPxTtd7+9RM1CnP6I71PDQ51MHgBvXYWBrR4lH
 boKzyt+hPXPizfD+s2PT4FtNPDDRhNjtFVqMMesOPuGgvQkvONdHIyQmbz8DDMRR3PoIdiFL7
 r5ZlO/+G7Hwv93q655XJUoFA1zHMmetDoXfq1cQVhOy5SLe+fK9o7oFFxa42QSGPXOczVbAAA
 uwxYSNm4qk0d9CCWLfcUNN2LNI+5ZivsN0S/IDtVtT0737Rf6F9vLddTGjSSKLPamUNHvGd+x
 yf8M1/NThM4qJbJPU0yYavXvuEPt0hxUSD8QO2Z5Gpx00iH1lNKqr9nn4JqRI0Uo+aWcIbpg+
 HIeniE6xqfWASvaXUCaEakrx+jMt/h2PwexUswn0BrvGT8isdFs04VdFhwNm2uM/vkH9jxQHK
 o2XJDszvg/haPyQGKOUKqT7PrfgnsjFji4Nx9DxtBUeKQQE4qvntl2aKzI3LPZnyJpoyg+SY2
 jie9kXwYfZR84TrBOOllLZ/tuOpe+/zby/RwTDxIkZaqgXnuo8qPsul33IqvrPxHC1Hq10KAS
 ZfDWBt5+Uzna2fRhCgeSLcARg1XNJdGXbaSzMqifWA8QOhZvII8+JnLQRAt3O12YevG7zqQ8V
 oG7UUWqDDrqHje2gYA/IFXSBjRWUQwmEmywo1Z2b0PuS7g053283fNCbLrtJMB4o87rwDuv4p
 erfIdcd+OO0p2Mr2Pk/fCmzKYbdT+SmjRoNH6Q6uqhTZBAAOMAVK/F/stC3fG9KXq/saAGudG
 k+C9JPXJiXkYv3mfPvBg==
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
 drivers/ata/libata-core.c                       | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

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
index 61c762961ca8..9934f6c465f4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2399,6 +2399,9 @@ int ata_dev_configure(struct ata_device *dev)
 
 	/* set horkage */
 	dev->horkage |= ata_dev_blacklisted(dev);
+	/* Disable READ_LOG_DMA with PATA-SATA adapters, they seem likely to hang */
+	if (!(ap->flags & ATA_FLAG_SATA))
+		dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
 	ata_force_horkage(dev);
 
 	if (dev->horkage & ATA_HORKAGE_DISABLE) {
@@ -4000,6 +4003,15 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 
+	/*
+	 * Devices with observed READ_LOG_DMA issues - unclear if only
+	 * specific firmware versions or only in combination with specific
+	 * controllers.
+	 * Specifically broken combinations reported
+	 * CT1000MX500SSD4, M3CR020 with B350M-Mortar
+	 * CT500MX500SSD4, M3CR023 with PATA-SATA adapter
+	 */
+	{ "Crucial_CT*MX500*",		NULL,	ATA_HORKAGE_NO_DMA_LOG },
 	/* End Marker */
 	{ }
 };
@@ -6104,6 +6116,8 @@ static int __init ata_parse_force_one(char **cur,
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

