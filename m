Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F7FC43217
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiADJFa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:30 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:15768 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229969AbiADJFX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:23 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsv2mVbz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287123; x=1643879124; bh=YkWEdMiYcrun25eWeg
        XuApHlXtiSAOATwIg1mIVIfFY=; b=nXYGuJDAChQdPiT+8JwNGdPEu21Mi9vdYk
        No/85CQpVDpE+Q0c4eQoz1kRRYPbiG9SMbXmUQmTFWpgFbnNPS9FoXT/SA+EnUG2
        UKxReHgikzR1C0cr5vjpyouGkWQEQq+S+ICaGUg1AQ/BAGVBsk0Hx6/0rmp6U0tu
        foC7RG5ROwQhOm8ZRJ3eYtL6HdukQ1V6Kr5p7KiYUaqGotZDOso4vccbg25tPoPq
        V36+nKJcDyva9KG0ukOsb367rhbWEXGkVRT8Nj+enk5xDn7tg4L4T7dXVXSorXCJ
        T1GVpnFlz0ME0fUpZeFW+PSJBx3ftwhuKqUQMtsjSecY/HDGL6lg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3GGpC3XbIFdG for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:23 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmst5X18z1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:22 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 21/21] ata: ahci_xgene: Fix id array access in xgene_ahci_read_id()
Date:   Tue,  4 Jan 2022 18:05:08 +0900
Message-Id: <20220104090508.1592589-22-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
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

