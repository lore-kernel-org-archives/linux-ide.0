Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F6C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhLBIkT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:40:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63701 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbhLBIkH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434204; x=1669970204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q4+jQB6IzMwtjyTYbUVpZ8/hVJ/jfapkUHY4m/vWn54=;
  b=Vc3TReZC8mpFfgxFiKOMh1djE1nr1lpcvwzfd4M/Ci+l1vmbDWuXGPi9
   YHVkjz/YDRImp3hOu1+p3bgYzGA7BWcB7q9EYxRNPzqJjVTH1DHZfysCl
   N3DdW4GQLrSojE/+o4InrQX5ooNbNRx+R1EzCXuvlQ4lU63iptmN3f2w5
   7ghSc7Iv9HQtqaTkkxJwmjRWEdH05otlrOmi7FamL4X4lZCezex/LF7a3
   RENjdVNbh6Z9ac+NfABnV6QatyK3OkLlglCFM9bhEouCjd1ii9gQVGQET
   LUHYAH74iTG5uLldMevbtCkpweVCB+Smw/poQL5ZdM3iVhWlCkPS1hqpm
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="186250273"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:36:43 +0800
IronPort-SDR: iKrol9hlcB2UVJ4J1WyZVGGP7ZNnh8SPkJW1Jool3T9HtZmUGGTpe+jgwdplHuQ1rebjon8zyI
 evhYt2+DwfLHhUkGCB5a4Y88NNhDs1hF7KnwEjniAp+evrbKfcX2NKUhm/rYGsXdAMHo6R3Es4
 eWvxGqlEDEPq7+jq5MDGzidUpoqTKeQXnpriFFoJFp9tkHqJ37ljsGq9OEO50AufpgIJ3/pCQL
 bVVyX/zaAW32AZNghsGtMF0HD0SdzG5oK9IMsb4wy5CAA/mGUcxcdOoEa7A1FHlKuL7Hbv2UBH
 gYfBvOZDbUqjBkIYi4AkrvxL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:11:26 -0800
IronPort-SDR: H6WE9Bz4vFwvUQiRNSOQPcyh7lExOgDDws+Dd8NBueUSMNJ7uIfahe9vCwUgZy2L4wifsD+Np6
 KKXbtGaPPlMcD9Ai25sUQi70uG/Q7yVPC7+dAmL0VfttftqMnL2LPQ7/fH5x6lA8raGrXnn6YF
 3Yi7HPAcqeyAq/mTSYwIrX80Z6AC0cIsoR/+jQR4UMoeKFx6LqUGAWWwHJB/6m0v5dxO6cCYFs
 8edZLe3UAzvuzhgsItKqvGliXF/wWHTLBI8maw5fNs8WHtihnSj0D0tvvvn2umCj2rNQLnScQZ
 EgY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:36:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4Tp22SW3z1RtVp
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:36:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1638434202;
         x=1641026203; bh=Q4+jQB6IzMwtjyTYbUVpZ8/hVJ/jfapkUHY4m/vWn54=; b=
        uausdhSwlcSClHucHcG2MFYYNxMuz/8EIgWCBBXRB0JzkDmy8FgawqyTkQCejUCj
        Q8n9Uzop8cESS486BASJVTAHAhq9KDkdyA7WStykH78bCmxnlYYgRwLVGx8qphNP
        q1x+8JVgZnb5JMHAUVwvgw3lAMxSw/VtA0yxpEJ4gW3F6X8x/T3IdkEilezI1+xW
        PJq5iVgahTTU/pgENC6NNAEJZtTcTb7tND6ZU/Yppw1P+dRtMGXrRnrPjHva7WQF
        /HUK3J4dcje4KdAUZ7PhmUHPrHvlmduDNKZXNeMvj6f/ZJvD3istBSPrY7y1QA2w
        HSPAPpFruxBlgFxwLtHiEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6Nf0thHRNzn4 for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:36:42 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4Tp13fmDz1RtVm;
        Thu,  2 Dec 2021 00:36:41 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] ata: ahci_ceva: Fix sparse warning in ceva_ahci_read_id()
Date:   Thu,  2 Dec 2021 17:36:39 +0900
Message-Id: <20211202083639.645311-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the following sparse warning:

drivers/ata/ahci_ceva.c:107:33: warning: invalid assignment: &=3D
drivers/ata/ahci_ceva.c:107:33:    left side has type unsigned short
drivers/ata/ahci_ceva.c:107:33:    right side has type restricted __le16

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_ceva.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 50b56cd0039d..e9c7c07fd84c 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -94,6 +94,7 @@ struct ceva_ahci_priv {
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id)
 {
+	__le16 *__id =3D (__le16 *)id;
 	u32 err_mask;
=20
 	err_mask =3D ata_do_dev_read_id(dev, tf, id);
@@ -103,7 +104,7 @@ static unsigned int ceva_ahci_read_id(struct ata_devi=
ce *dev,
 	 * Since CEVA controller does not support device sleep feature, we
 	 * need to clear DEVSLP (bit 8) in word78 of the IDENTIFY DEVICE data.
 	 */
-	id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
+	__id[ATA_ID_FEATURE_SUPP] &=3D cpu_to_le16(~(1 << 8));
=20
 	return 0;
 }
--=20
2.31.1

