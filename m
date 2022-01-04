Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA62C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiADK7C (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:59:02 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:41361 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230412AbiADK67 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:59 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNz3D8cz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293939; x=1643885940; bh=YkWEdMiYcrun25eWeg
        XuApHlXtiSAOATwIg1mIVIfFY=; b=fWNi/rdq33HbzV+/CYZf0q6bBkhgS3R38V
        Fn36pPTG5OPzGF9kRT6iaa0hNEFmpd7Bru+bx6Di+2bCkpmlnfuVgmg6P12Hz3Nz
        /VOhT+Gc0/IGBWoOHypkOP5VWSD7EbKxafNtdjaeTgtlNMnpPcU4ljefEalbr4tN
        5P1meRsboeM1kMssZAVxaGft+Rdx9h23gfM1E0iOSfoVaDL0n+a2xqU3Iut5zCy0
        KrFW3YuBKQv8RYMeiXsTBHAQ6pnj/tVzniX0+UUlyBUJNqJNOrnO9N9P5xmSmNBv
        /6u67UXTXhFL2KQWaeoRZCWl7pEGNQzNpSVw5fl+d3l5GVQ5Mtiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hb3nb77uy15c for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:59 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNy62W4z1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:58 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 22/22] ata: ahci_xgene: Fix id array access in xgene_ahci_read_id()
Date:   Tue,  4 Jan 2022 19:58:43 +0900
Message-Id: <20220104105843.1730172-23-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ATA IDENTIFY command returns an array of le16 words. Accessing it as a
u16 array triggers the following sparse warning:

drivers/ata/ahci_xgene.c:262:33: warning: invalid assignment: &=3D
drivers/ata/ahci_xgene.c:262:33:    left side has type unsigned short
drivers/ata/ahci_xgene.c:262:33:    right side has type restricted __le16

Use a local variable to explicitly cast the id array to __le16 to avoid
this warning.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_xgene.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 68ec7e9430b2..d5075d0f8cb1 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -239,6 +239,7 @@ static bool xgene_ahci_is_memram_inited(struct xgene_=
ahci_context *ctx)
 static unsigned int xgene_ahci_read_id(struct ata_device *dev,
 				       struct ata_taskfile *tf, u16 *id)
 {
+	__le16 *__id =3D (__le16 *)id;
 	u32 err_mask;
=20
 	err_mask =3D ata_do_dev_read_id(dev, tf, id);
@@ -259,7 +260,7 @@ static unsigned int xgene_ahci_read_id(struct ata_dev=
ice *dev,
 	 *
 	 * Clear reserved bit 8 (DEVSLP bit) as we don't support DEVSLP
 	 */
-	id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
+	__id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
=20
 	return 0;
 }
--=20
2.31.1

