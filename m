Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4434EC433EF
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F361AFB
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhJCLbI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhJCLbH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:07 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MtOT0-1mnz3R3SpS-00uqpd; Sun, 03 Oct 2021 13:28:47 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 5/6] pata_optidma: fix checking of DMA state
Date:   Sun,  3 Oct 2021 15:28:50 +0200
Message-Id: <20211003132851.12574-6-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NGkkEyr7gjaUpsiGwUEOwilZBJz16eWE9pXYcuvfkMvKf9D6W85
 AH6IZ2C+m/WooaxtzXX4NkH8ZKZQ+FbYIBMOqvSRK6sg6o+ANiNCXozxUwm05DTKMssuAwz
 YZefi6d+WhoLemtcnIxWosahstwncWy5RoVPgIW7UOQTJIeAxeP57yhIfz9TusjUu+SNSGg
 iz5XE1YjzwwOj3BG4CzJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EPNgMql1Y/U=:z+53rx0ycXSQCBcvD9cD3b
 SZcXHtGoJCy2NS9hMY+1/iAKGqkP13uIhVTVQcTF7eNgJhcaRjJUmffmE2BpaWT6lhIgqiQQL
 exCRgKDGu+czP1jU2DnzHPsLjbWEDO7+P/8q4Vq2tV46G5/r+l2JHtp92eB9AXH1CxPdr/BAS
 leNXSG3Zmw5HnuFdgk+YNV3kJ4iDMLnQ38+De+o8FR+VRDFwDhu31dvrCEips1rQSJSolHXgc
 yqzXysWoY2AEi2zkI0iXpNknL7+xEGFO5gKT+H1IBWHEBf5KHXlsDEsibxOmM53Jh0qdjqvoV
 wKpwTfOH3yrx49XzZ0/7zuv7f4ZKky7sLm7KDkX5ltZUFsQdYHfpCmZoZOT0PrtTUL+tba+cR
 iOfJfHgDCBwYMX56Th6LpUzB2wQfnmQ/KJynZbn5C10ElWNmyBoidGQBRP6QtdKf5KxgKJ150
 UqyzfJdhzTYmLaohrud1LxaXa0gPfqiPFjqVPncVzyreVjxOTmiOFusnxFU2uTJp6be3oysQX
 F2eOfCDbHTPsTGuB9j/XdAANzXYLektupqX5tomqSwyOl0kDNC+lAhhIrbATxvGsAHXkZZRBv
 EUtsgC7ZLDfb3lr5ybTLP3m/pFraf+0QwcmGcCFlPLSNBm8KSZ4h4lILUtqqJvUYoyDOtN5tI
 HXg+YZDK82ogHzpdQwVPyV7aX10xJU9RlPucQD9wQMFP7vB03NFmX/Li8LiK0CqmFpnXjCbPk
 vSWPc6rbvupQl2ppmrxWNUpL3IH4kZeGiCCNF/YkJIf29UE2rX0qbb4rQgg=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Change based on code review, not tested due to lack of hardware.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 drivers/ata/pata_optidma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f6278d9de348..ad1090b90e52 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -153,7 +153,7 @@ static void optidma_mode_setup(struct ata_port *ap, struct ata_device *adev, u8
 	if (pair) {
 		u8 pair_addr;
 		/* Hardware constraint */
-		if (pair->dma_mode)
+		if (ata_dma_enabled(pair))
 			pair_addr = 0;
 		else
 			pair_addr = addr_timing[pci_clock][pair->pio_mode - XFER_PIO_0];
@@ -301,7 +301,7 @@ static u8 optidma_make_bits43(struct ata_device *adev)
 	};
 	if (!ata_dev_enabled(adev))
 		return 0;
-	if (adev->dma_mode)
+	if (ata_dma_enabled(adev))
 		return adev->dma_mode - XFER_MW_DMA_0;
 	return bits43[adev->pio_mode - XFER_PIO_0];
 }
-- 
2.33.0

