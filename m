Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938CAC433EF
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676AE61AF0
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJCLbL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:11 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhJCLbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:08 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2fDr-1mWB7Z23P5-004G7u; Sun, 03 Oct 2021 13:28:46 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 2/6] libata-scsi: fix checking of DMA state
Date:   Sun,  3 Oct 2021 15:28:47 +0200
Message-Id: <20211003132851.12574-3-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eFeDCxZDuQMflTp7KvyB9rE2k7Yp/A51n6DuACv4WTKd2+zS415
 1nrKATlwwHqLq3wxUVFXir+oB64Ir2imN9AMq3pb3/xZKu2M+vo+C/XT7MZNEU9QTGcluHR
 OqcIYrKNEd8hpdMsAr+LHNNWnZfS8Tw+VsFINtYom21O/bEjOS0p2IFp/6b9vMqCFaHSFKR
 gKVEQMbuKcPBB5fhA9FOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z0INSxRmCqI=:WMGEEfqwrTsJAqf7IlbNkY
 sAOarbOgPuvEhrz+Kdyn9YsaZuqjFBRDvEgAht9huRjB6BW2370dT8x5ZYYjzml1GNqPlNuqI
 lQYJpiF5k8s4ztZcslqIvJoxVSXdiN58tZ2IYeTsvtyVSKWwhxGWu5ftK7i/gEtt4H8kW1WyO
 E4+mtK+r7Atb8d7ASEg9p7ewyTx5CSZ+2as7KN03C0Ka494hOtsTpjLNz/+xzPd+PuNbbOEla
 We6KucOMKmzH5caDlJi0RU3gRXhG0NMkzACE57SgBfuM4JwAaF+WOz8wnhawHCZzTgkseS11m
 E5F4M3uLEab3fR1uT/D/WW4RTeOmweBnGon1zUtX46NqYdxaYSK55QfNlYpGFVdRf0IbT76Rp
 Q9orvO5Kjvsjfr2XhpGtlIGXXKdPLNGt/W+KF/Mc9BL4UEBqJKhKaMd29FD3hMyH4kMsnQf7u
 cWL/9eXXWSL0UtIF8wPndYiSOOLB18tEwoR13kqXZofohYqWGHqZ8EI0wYWXzPJ4Ejjdb/YIo
 Yz4QBYJ2ll7soVSkYf/m0HDIoVAT6lKA6jPOs5bsd19FFv0ZxvkKS+sf7AevMhbDmJ21fdhfQ
 OAX+wB5/e9dDrNFQyQRVFq7pHxS/Zls9BdYiWeZprEbPz4g9YTDNdr5aq57bTkIbui/7cZb92
 oOnEs8Iedt4vZTV1B/ZRj/u5exz7frtsvcpCjxBmhyYc18Bup2H4a+NExIu97MHMVO7+F1a9j
 S9wtGN+omYHicnpw/w5a2q0A2tIzqGTEWVKt6ZkUtzJTMjo8auvQFB6sYJk=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Change based on code review, not tested due to lack of hardware.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1fb4611f7eeb..0adea33f2137 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2981,7 +2981,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	ata_qc_set_pc_nbytes(qc);
 
 	/* We may not issue DMA commands if no DMA mode is set */
-	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0) {
+	if (tf->protocol == ATA_PROT_DMA && !ata_dma_enabled(dev)) {
 		fp = 1;
 		goto invalid_fld;
 	}
@@ -3131,7 +3131,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	u8 unmap = cdb[1] & 0x8;
 
 	/* we may not issue DMA commands if no DMA mode is set */
-	if (unlikely(!dev->dma_mode))
+	if (unlikely(!ata_dma_enabled(dev)))
 		goto invalid_opcode;
 
 	/*
-- 
2.33.0

