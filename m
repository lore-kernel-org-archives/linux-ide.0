Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B7C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A5660EDF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhJLGak (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:40 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhJLGag (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:36 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3D3N-1mb0DI0mYH-003cLI; Tue, 12 Oct 2021 08:28:13 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/6] libata: fix checking of DMA state
Date:   Tue, 12 Oct 2021 08:27:44 +0200
Message-Id: <20211012062749.4728-2-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
References: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RMPRyvaBEtnClBp+K0wv7rOPZEZWFt7VuVlzzKXQ66tqkbnfjFG
 5o7kRisXFDA9l4tzSsSnjlNVDabkj+D6ynvIDvZl1vygcUnUGE0VVBiMznRVT2u1ItSACr+
 Mi1DIuh6mVhXuDLX2sukp8QCCCYYlbtFhAeHtZrMB69xevS+/OXBcO9kLZB0GPb6UzD1ff2
 8AaclvIqzLxxgMvj6jbrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0YyJJBD1uY=:ibpihMhGJWjBRVEOYt7iZJ
 tNcYtRivOlDCdRQmkQAx046Y9Ut2zKeWqH2jIsyTOP1OHU9fuLFZ0mft3GftM5CyZHX6dBKuL
 oB7P27+KsJHby7mV/Ib4D+L07uAVsV0b160p4xPKM5BtJZJXSInYS8u103GuNIOMzoxuPYa46
 7DZ6GOmqDyz3ua7CVWcXFCp5Ph2OthG+90kZeRWp+d+VLCdWCE3eDE5iMvKqm8zj/z1aEnI14
 b0MlmJaIbE52BEyuaLVzXekdWQFBl9nLzJ9k1ceJj/usGCAPO8EflpXF5ztusINJKmnVbE53i
 b9WPgC9kpVrpq9F1lZsQwYiOasfIqiln93sg9BSF/3E7F+Pu0xsBJnbi2FP2USRiazkC6XUpg
 Rb6UW/rZ2jE7lQpkUzFdsXdtQXl3bsKZ2b2/pU7hTmuVMWGk5cBKcD0NafnjqlGDGatVpebHa
 N6m/ICKEaJ32gJqj0rv7g+uud5dHPeQ5Bhn0Ww6/ct+Cn2xmRenqGwDhsx2Sn5bYZKxRyehQ4
 99J3il1KLpcXTjMoQi0m2c6914A2yXQK1Gl8OchGgA/JDZ24k9Qpg7NCpM2EI+LO/RSxZ/Sfr
 HK8qBeBe3tpdVhTzByrabsCfMLkildWq0YcLkS/PoykehpnNJHMzT6CoSsC93TbQv/RLlBmtR
 Hx81mP6dMtQekgmFeKbIAEVVpzNJoL8bOI9R6iF3DoMOzuVPcXtxbkIICvD5ddrt3SoH1xaeS
 eMolVkiNbu+S2/DcuG6KPOrqgaQ3YENHDF+3l9uaBQgcrQYI74ZogazPpaE=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
This meant that ATA_CMD_READ_LOG_DMA_EXT was used and probed
for before DMA was enabled, which caused hangs for some combinations
of controllers and devices.
It might also have caused it to be incorrectly disabled as broken,
but there have been no reports of that.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=195895
Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index eed65311b5d1..046faf0dbdd3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2007,7 +2007,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 retry:
 	ata_tf_init(dev, &tf);
-	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
+	if (ata_dma_enabled(dev) && ata_id_has_read_log_dma_ext(dev->id) &&
 	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
-- 
2.33.0

