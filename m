Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432FDC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFD760EDF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhJLGao (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhJLGak (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:40 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmUDf-1n0PHl1Ip7-00iVdP; Tue, 12 Oct 2021 08:28:16 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 4/6] pata_amd: fix checking of DMA state
Date:   Tue, 12 Oct 2021 08:27:47 +0200
Message-Id: <20211012062749.4728-5-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
References: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:280TJQEtH0yKcNgrAGS4p7WhPJwlbMKkwwxDPUXGYTFNM42OPyE
 4WbFgGMBTn8QSK3JhFxGcK1KkKdNUz01H7oyyE4u2Qr6lwYt/nfrNpbUPlnCkEFzW3UGrcK
 ElyOUgBYxyvjkk4xqfcMt1s/XyQKxP8TS/mXGrzFpU4itHKnuV+/bk+Qu3sWJ28vil7ggx/
 D48GL9kuAaf/x3316mutg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1hdlr00Qdpg=:bfzWAdri14Im4JLM1bBPpe
 +SscsIce9/JFaVTGo61hitV1Hzd8Ri5v3uU2zQOuxSN3Y8vC1RF1HKxitgjzs/2PDYlOISpOb
 rUuCBKXGBN+u/jy9y3faEd1qV+IhgCgAa3ZA7+GfqRCSm1LoCx0F4sTs1YUI+2CRVL6sLl/gg
 9Iaov0YciWh5CkdU5kiEQAKVc5pR0RJUE+OHp1ARdcpTkPXbKd38i5wspnul11v9DNAwnLLkQ
 VSR6phg5eKpvspwmXluHuj4OENAR4sfJU9EgQTRCPXT3dX6YGc1pSSdi1px47K+o5jSKQ/hbr
 Zjs+VIy4Eu7XO/W2RQJqkuW6x759bJRGDDqkNWzGFceYvDIZ3dt+tox1Qmsqf1BKnNLYM3nsl
 YueHWJQFYyIlBNlHMyicLrGVjnIAHKSLIaEuVbdwLSiCbt241DJUjVNFl66gubSQVSYYYziUn
 YBLITyIC/YvqX51vxBm8uRKbORdEx/KZ7LYWhEvq6eE4rjNOeR1mUXDSpIuYeBOtMxC5kQohF
 1kku9Pl683SyDvA2MSq9JvRl+2Kd5Sc7+aU4e2Ys9ifumB1AYGMUfLg1wHVlw9jNDOEC3oKN7
 DhLj9JkGUU8DZF3mmplOSnj/Pxqii5ldfVindvlaU7XGKiZB4A56imBubMX8Qs5qU8h1faLfb
 o6kZj034qsrKOAQbrUGZ+zcB6GQhUDOfkzEos+iEp+eXi8sIZnG0H/mT99O8aSnTPZJ7BQ5QU
 BxC5U0gUMQcNtyGSElCpP/pZHCuL61WvZOzkSc/VxxVcH1QWeGklzCADpM4=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Change based on code review, not tested due to lack of hardware.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 drivers/ata/pata_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index c8acba162d02..154748cfcc79 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -66,7 +66,7 @@ static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offse
 
 	if (peer) {
 		/* This may be over conservative */
-		if (peer->dma_mode) {
+		if (ata_dma_enabled(peer)) {
 			ata_timing_compute(peer, peer->dma_mode, &apeer, T, UT);
 			ata_timing_merge(&apeer, &at, &at, ATA_TIMING_8BIT);
 		}
-- 
2.33.0

