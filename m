Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0841C4332F
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B704061AFB
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJCLbM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJCLbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:08 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6sWd-1ms7mZ13rb-018LSO; Sun, 03 Oct 2021 13:28:48 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 6/6] pata_radisys: fix checking of DMA state
Date:   Sun,  3 Oct 2021 15:28:51 +0200
Message-Id: <20211003132851.12574-7-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a4qkAMK//qKUFDNcKTMV17t3cDIB1kVtl4hrjkm5CL2l2xbkOTb
 PZChEIrGcxanjbyzEST8TlCrTnv/JtVLF/r+H+v44TIF3X0drNt3sHau+zmRdwDiizzAE3M
 u17Vfx4DKfo1RTzVZLD4YpycId7LKzMxpIdacCE9wlab5STiOcVWAxQ03I3zfXF6z6fuKlX
 BtmgyRtt3DQ33Kcx9/vjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCl2dFDeHTc=:OpPjiqv47vu1A7hzJJwGZa
 J3eDH9wP1Had2P5XLZ+LCHYM08ppFN4uZQfOFDfRi+7SzyitNMKMPgJT/h8Dmfigq8AilgiBb
 IhsUZYmjJaBYWFiCHJtc9rUrb19oILdFTUujpWD3dOYWSZT3wiWmYgybArMclmg5eaZMAAFiu
 flINAG61TaGA842z1mHoOJJyu1jskKe9ShpkHLySOIkiN1gXnsWANpOfcTJgcr33c2RPlA5cb
 2dyPFeL1r0ybCKRl9bzKnn0pmotra/9bRD5mmbOo1ZjLzHK4gKy4aKeMuKwqHxWMK1+lEeuzZ
 0OMTT7JiKLL7tWbZYWgblDG+2PnyX959nqfBAexqhN/82JiHX83gOFCPeH9MVymd5GilFK1rZ
 SdCnigrPjKLr5fCPuucBNrbTj8f/5+vC6Sl83PehvirH6HNm9SIja3iGNe0uwp5ceAN2ik3d0
 lon9xbxhm9z+AoaTELU94GDjCZc94T6C0vkGoTT7rDsYd85VyU+8m/z4CDo79ApJ9qh3IvCUd
 tpmugDVrhi5IKGm2HAAniLFtPnPisPndl1+RSaQWA6LMqGjo4Nrv3r4jAB+rOGqXuc1DgU7pG
 ugy2maLztdXeKSuQbJT4+DSvid8UAsd9zFXtZo+k3fcclZrTZgBf7sACeYXiPIVR7rfpqPkE6
 4MxVXTouLibiBMm1DQDbIOsxe3Hrvs3OwAPrYWplPU6yzBYjEjMoG9Z8Z/Ng+oJZ7aq1bhY+n
 /p84Or4gXiNm1HsDmfwhcHpKNb7wZoul3+ObKssrnw3R8ebgvud5CMZlbhM=
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

