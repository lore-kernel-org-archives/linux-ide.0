Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075FC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D78460C4D
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhJLGai (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:38 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJLGag (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:36 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvPq-1mEEaG39tI-00UoSu; Tue, 12 Oct 2021 08:28:16 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 5/6] pata_optidma: fix checking of DMA state
Date:   Tue, 12 Oct 2021 08:27:48 +0200
Message-Id: <20211012062749.4728-6-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
References: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b85dMji3/3R0FUsm5XLNwdcPVeCEciMnjXGP66mKoiNf5pp3C42
 FZrRNXfYm779yUvasXdpTvhPoYbQE2qk1l9Yx/Vhx+PgXoIQCI1RZdrOkyGqn8/pb3MPQmn
 9tcJq8xcagt5kPUmiL0nbkNR3xYC/gwguI2PsiL/KLC7Qat2d/W3U1s7cuP+zjYb6/SGZWr
 o0xEIDA8ARoV4/BI0IHZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WpEHaBy0Hbg=:302Avo+f4Ux9QNxfVs5Oy8
 65cMgHsuJRLhyhpCqDJVcukj6YRid94ZBUaAz2/DiOuzyczVqx712/9UY+RnFualrmJvK4QQT
 HbXqPCo782c2BAQPtsQIaGCo5LfoagubArfkfxmnEDfWQvJaAW4aUEZlCyN0UkR0W8T6hwZvt
 OTnR2hOxj4CKbB848daC38n0xcyRRUBD7bgIerVi9IpgkSwvl+gP/I8NoZ78TCCegPBO08axL
 zwtpLDzy6HeJMxPgMXcPf8qP2VG75NThTnrYlXHmw7uZxQvJbN29x1GsUyalO4XK45VR64/g9
 +67yfjwBeDn1B2n3RlAH28yN+55CK1lQArUh25h7XGgppVRafn/IZDlIamGizRWycgO8MJDXI
 IO5U5vd5pJmYfkMB3kK9gtROgME/4UAECOy+iuEf42Nuqh+CCekMsxV4gjYi/2adUXYU+YkGN
 zZcxf71EguvNb0rln/TWgKsyGrGDrYrEHz+KDSl7EaygU9nuVb1s6rroEuK7X5UKvf1/A11cM
 KBWe8D/25iWkBbeubTK09/Ntbe2slfrlF0BViW1lPTdJf9i1W702dPMY/67nd9Xq4dT8N8lym
 Dy8kFhA6igvuZodqAB/oLwPywmxoKHvmsIIL4q5xVAG1c49WtsilBJWwFfcdRsEmJPkmIcn8W
 d+0ft/n31xESM5cRarFyfl2w3KrrO9s9995iqm/2xNVDb2oTkQqD8/AkgF0nUgC7gZ8Zn6R1u
 2F8DajQIa/6f36AY4UeINbd5wwDVglfwrtvqbxnGtzMp18nONtQhBDQ3jg8=
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

