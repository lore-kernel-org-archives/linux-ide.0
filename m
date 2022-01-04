Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F4C43217
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiADK7B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:59:01 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:61339 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231766AbiADK66 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:58 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNy27Q9z1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293938; x=1643885939; bh=XP7I6JWd2cbVrmVtE6
        mq4d1SGhifkl7D2b/yi72Jeq8=; b=eL7aqvVpmTjqs3f3AtgkUNJ0iyogO2/6+U
        WPTs3H9/tFFaHqxMHN8BOWc95Okpp07pHwGEPjhYNeVVtDlgoMaxMJwAQZGtPRLw
        V+nddL4fm3MXSBfGerp+hn2ys8/Tas+vD5VLphgd9LTHnX1bnvYy2WWyzjGi8IAZ
        ROZjMEc6w/HsMissYgo6lwYdX0RwH0xmlj5/FL1dQsgilGoJMZM8MHipmhPnMPLu
        juKSK1yCOOCNbN32jM+toxZRCPtHXS+lJn/m2leBNL6Smz+bzrxWZjovFuUHUeX/
        RrZcCDyx6bih9qKgdSAG9sseCWluhzy1FeJF5dR3xj0f//2OmOTw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eif_PE1mHOfC for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:58 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNx55Wtz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:57 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 20/22] ata: sata_fsl: fix cmdhdr_tbl_entry and prde struct definitions
Date:   Tue,  4 Jan 2022 19:58:41 +0900
Message-Id: <20220104105843.1730172-21-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The fields of the cmdhdr_tbl_entry structure all store __le32 values,
and so are the dba and ddc_and_ext fields of the prde structure. Define
these fields using the __le32 type to avoid sparse warnings about
incorrect type in assignment.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/sata_fsl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 101d4dd79f62..13d532193405 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -221,10 +221,10 @@ enum {
  * 4 Dwords per command slot, command header size =3D=3D  64 Dwords.
  */
 struct cmdhdr_tbl_entry {
-	u32 cda;
-	u32 prde_fis_len;
-	u32 ttl;
-	u32 desc_info;
+	__le32 cda;
+	__le32 prde_fis_len;
+	__le32 ttl;
+	__le32 desc_info;
 };
=20
 /*
@@ -259,9 +259,9 @@ struct command_desc {
  */
=20
 struct prde {
-	u32 dba;
+	__le32 dba;
 	u8 fill[2 * 4];
-	u32 ddc_and_ext;
+	__le32 ddc_and_ext;
 };
=20
 /*
--=20
2.31.1

