Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA2C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A35360EDF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJLGao (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47857 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhJLGal (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:41 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MirX2-1nCq0r0sRo-00et7G; Tue, 12 Oct 2021 08:28:17 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 6/6] pata_radisys: fix checking of DMA state
Date:   Tue, 12 Oct 2021 08:27:49 +0200
Message-Id: <20211012062749.4728-7-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
References: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X8qz+Clvxf0Q+dZO7lAvSLA6CsYpSOp7W/xt2Pfi5BSQcqvgZSO
 hkpJ+TnDdUec2UsXkYK0Re4w2gh7616bbpxtXDuKVyaxRcwE9MNMYAO1nk0FiJT0kb+63ZQ
 u06UAxX5IC1oP+qXefYRglwK0x3FFYu/isGn7W9d+GC9tYX3S1GN5uZwgtHJqPLyGuEcCSS
 9atYxyuNzVDWUrZMqPp9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ae76cY5temw=:4fKXCIo78Kw4QBK2wDp4Ml
 YmnzUKDUuLQCIzfopNYrIG6R2hw4TQyfEBFkttJ3PptlgyMyXJnXGDOPUy0QIp2oO9eer4mm3
 Yqd5cs2sIaXT5wy+PRAijjndfK8psRMXLMWp5pq7ViHBYgnqshuuR8SKYl9l5P3TQQc5jMbbQ
 8cZ3SSynkeVShXvTUbm+vUZwXj0fKInb5Kjl/aemt6gWeNiVAcziwWr4ob2OWjUC+U+PwuIKL
 9Ex6lZB8Z13SeX+C3UNC5Pd6k837DX3gcSGK48fhH2P5fpYHeFMEbKEGcl9n3qXv3oyN4T3cM
 R5YvHiqZqtn5vHUxM7JG+O5IQgK9aO6um/Vr32FIRwxNtIrQ9cNIqOhK4uFuj5LxX0cUMLHOn
 4aCzjKOKWrGjq2ginW+sJ+W3VEwpTiSA62plMNMZSxKlxDDFPg5LK5ulKdrPlsD1Z0ymRpx2R
 vvnybdrBrtpfBwsx9CFegYGXfu/yyXGEUCujuUNlRNqNLHgu/m1SFdu0eb+CbcWNSEmLHWYJ1
 HK293mwOF5mj43gsCvXe9Sm/uzflWvKI/HwfyyUTT+0aK3TOpH3ZHRDv+O2h6yXZdXY8mZI64
 PQgYGRenjbn735wiKB5qnUsz2l/odpsIMfzs0KqWp0IXS8GBEgAHajvwras0l9Zy+aMf+9bA2
 PnqHSAd1QPc/ujsPuiPG1X5Hoy8E0Fk0Wma8JP0dkivNKG6LxFLOhgpruQUNhTkCXOzCS1u8K
 27I54AzVpUSFpFupPuGoCT/KdbOtCFLQQOBscaYdEfHYwCaap7LQIUWK0co=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Change based on code review, not tested due to lack of hardware.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 drivers/ata/pata_radisys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 8fde4a86401b..3aca8fe3fdb6 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -172,8 +172,8 @@ static unsigned int radisys_qc_issue(struct ata_queued_cmd *qc)
 
 	if (adev != ap->private_data) {
 		/* UDMA timing is not shared */
-		if (adev->dma_mode < XFER_UDMA_0) {
-			if (adev->dma_mode)
+		if (adev->dma_mode < XFER_UDMA_0 || !ata_dma_enabled(adev)) {
+			if (ata_dma_enabled(adev))
 				radisys_set_dmamode(ap, adev);
 			else if (adev->pio_mode)
 				radisys_set_piomode(ap, adev);
-- 
2.33.0

