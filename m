Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D0C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiJQDWV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiJQDWR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:22:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3504DB06
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665976936; x=1697512936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oVd3kKUW3BD9R22KKr2B93jbr7Wn+zAbmF4qTKLCcU=;
  b=BeN29Pj2EL3R2FY1G2UXc34fEPysHI034fhMy9o8jLVDLiWw5KdgpYlb
   AjR4pMD0WCBFxQAdqlyZsBe+cShC9FGcXww5rIlexE2r9XgdU/Kcv6DyA
   PMf7czhszZS1QOgGyFyPYs2auktBmAcOZD1aBNrukqOKtFMh1X0ymIe24
   nRePMLvVOHmFKDkXGGVIwebBHhH3OdsiNzyO+xcw0EGexxkH4BZ05ZeIO
   qlv2mEPu9jXV68OfMBq0MAv3gadEEaCGMJiTtyQ7xZ2D1pVbZhOYY+r84
   Xu7li8A9p/4mFf0nCkU05DpUPtujfSM3MBpYkuAMyAK8HXfK0uXM7qdRF
   w==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="219135021"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:22:16 +0800
IronPort-SDR: pq2AFwCOk7OUs3c3d5kVlPaUPunfpnljzr+5CkH5d8kapnzJc0JBgMiaE8FeSQj4OsurF027yG
 AZ3g4E7bsnHwbNQKc/Tcx49HhRKZhmCLb/Xo38A3jK3NncYlDemGkG95Cz2vOgeJ5exWieu3YZ
 idz4fJDSvcyQKc/DAGB4lmoImD1tAddhzei0iU+zpNsctGSDo9VVj4dmWc1px61GAg2xb5g2am
 B7gmA2xDtNFk2s8aWXOrrjGXOj0yyI5tsvGsfWCFgoAEn0oKPAfnGgtbmghKuyKIV/fzGuqtbj
 OWPFTKPOsB0KSSBvAhfXieoG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:41:49 -0700
IronPort-SDR: 20dL8khkycyoLRBzTd2qYuJmdAQPH8tBEbpdSiTp8W+kmtFaf3ZScPbVok1ff507Ee6rFupCET
 /gY8P9tJ/8h6+5f31crEULTa+0jwMqPhHQShy9qNdsAbhqcbwzRLLMrF7Sj/YNymovj69fLze0
 0bgVYF3k9ht8zxbJEdVD1JCbF074aTZSc08O6UCxsUPhW1JH9XsQE0FDLnZ9dpCjfjnbKMMw7U
 zcVvZ1x4fBShxmehmdwjH0ENVWZERUB16q0RK8JHl3WsxB7bdb+5BNHvqxVTY4a8WXhXusWCPe
 cMs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:22:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMjz6276z1RwtC
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1665976935; x=1668568936; bh=9oVd3kKUW3BD9R22KK
        r2B93jbr7Wn+zAbmF4qTKLCcU=; b=rF2LdUjZnJtL/Exkv3BjRLjLgXR0Qsi2ks
        X839gYzxXeTVjtVrsSqZmVtYhbB3rLOBr8UV2ZaOsW+Mr5lvjm3tHec8Tdqw20ly
        0AdVo87lQxcGX1sUbNLWyYV00uG3MhrBiLRnHLd8v/KAz3nEHd02gYsjKm7S1+ET
        KBEIk8I6iN6fRZUPtkDVRiDlec4Mur3jfSkyXpu0wEvwr+g9attNMVVfR+bqNLCG
        UyrsC6UrC5D/T/lLv+VOnaoX0H95aeoljggjfuPzZ0hzwiOOFs17D8iQJg7pUCRd
        62tyoLb2CWnRD40q9X9NVZwDeis9ij8vcvpRakte5QfxNtTdAwrg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ozqHty-36_U0 for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:22:15 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMjx74PXz1RvLy;
        Sun, 16 Oct 2022 20:22:13 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-renesas-soc@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 4/6] ata: ahci_xgene: Fix compilation warning
Date:   Mon, 17 Oct 2022 12:22:03 +0900
Message-Id: <20221017032205.2210188-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
References: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compiling with clang and W=3D1, the following warning is generated:

drivers/ata/ahci_xgene.c:788:14: error: cast to smaller integer type
'enum xgene_ahci_version' from 'const void *'
[-Werror,-Wvoid-pointer-to-enum-cast]
       version =3D (enum xgene_ahci_version) of_devid->data;
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by using a cast to unsigned long to match the "void *" type
size of of_devid->data.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 7bb5db17f864..1e08704d5117 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -785,7 +785,7 @@ static int xgene_ahci_probe(struct platform_device *p=
dev)
 	of_devid =3D of_match_device(xgene_ahci_of_match, dev);
 	if (of_devid) {
 		if (of_devid->data)
-			version =3D (enum xgene_ahci_version) of_devid->data;
+			version =3D (unsigned long) of_devid->data;
 	}
 #ifdef CONFIG_ACPI
 	else {
--=20
2.37.3

