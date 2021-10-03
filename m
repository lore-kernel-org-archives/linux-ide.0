Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4500C433F5
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55D061AFB
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJCLbL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhJCLbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:08 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKsWr-1mE6Gw1bW1-00LHLR; Sun, 03 Oct 2021 13:28:47 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 4/6] pata_amd: fix checking of DMA state
Date:   Sun,  3 Oct 2021 15:28:49 +0200
Message-Id: <20211003132851.12574-5-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SVS4rPTkQfeL08z7wNxHsdDx0NsumBXfFAOMXuE4YgGpM+z2bci
 6q3h6LHQuAwrZ04DUlCImUOUlqVih5SumwJ4GlP0FUvqWVDXFGOFTcrH4Er4wpp0lF7LYxb
 82I11Eo/zSykqWo365A61uFxruqH7ci6hg4qElLgqFCqg6OuQG4UJju0a2WEgak505bAAoS
 XA+l1SfLimZj0u2z1/S7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UkN8+b+RrZY=:m8gboBFbwTZeErg0UphD68
 qISesJwqcn5KEOOBFiyRkeSadFNYsTa6A7eNtsi793eqRfOsDq/3/h+QcLm4bsRC6HI5nm95c
 s1rZCNduPloT44U5OAX8nNHSQxAZN9EQiJa95sz5swah0kr21wLXoMgwcpjarNN/MwnKFEMiK
 pTo+LAeFwEAWIZq6mcKEC+67I+K+ga+Ra7lH9A94ZhErSJpuKFzOlpxMK+8D8PK0AZ5NnvF1c
 CBAcD5IftT42B95u0+Q6CmrdZb5ag9eS5gOQ2a2nwh72qR010/a6JbPpsLXGCMxVlJAmyvNgs
 OsPnfh2llBY5DmkgdR8aUZ3sPUV2iZ/8XUK2tHkZtwOan7nQclwHd4b3rLewjHx4jIjPpECwa
 /agqyvNyBu0/Kd6MV02CZ84BKtoo6OHgENTfEbVRWoGBe9LNKdjlx9QaLi/ne0PHyzAfEj3cx
 6dmDysBM+J6bTbaJWsYRZQ0zROnIubCmpogMPxRVde0IhvEx6Rk7sF95gnCpN6M7Cq4HCJfsG
 eV/Dau5Qlv49wXUnL+ZQq9Nd49pcif2ecx+oD3mUTJFajvu58nHa/BBcxuJE03QaM2MN+TcPR
 X58fgGJZIo3j38QE9ZZX6Vs6m7/77DoPt2Mou7Kxm1XVJv6kAQSz2zKwf48+Aj8ecJNr9d30K
 RjVuQGmPxrcEztk5F6EsFjrOFl9HSSoxh5tihVsKh4N5bBnDUyQHdGK581qw/KTGsV1leZpRT
 s8QNv2ipPm+5cGPssiHvO+wU3A3YlpmGy2J++Dc+Dbn28Td/QzJhnfoO+jM=
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

