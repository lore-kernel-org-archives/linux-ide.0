Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA6C43219
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiJQDWT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiJQDWP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:22:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D684DB00
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665976934; x=1697512934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/VGei3mXd338tEnTEiU0+WWo95l65D0cCUal/7BcvY=;
  b=NWCw9nb81pqfiehpkrlQFkELjqSt6a48+8eEhm5sNh7wIYItFfC0OM4/
   Z8NzIKPTRfK7zmnSABhy3zkzAru1p9ujKME9TZNZfiKQfMYYQwFbjzq8I
   xmknNzWmdF93aDPazYnxzZJz4t+vy/gzHaHKB7Jh0XSIKGvrfB/tqfU5z
   NNi1L0kswpClLBf46DpTsI/CU5npWslD/Z41QJNfZya0WGdh8amtKmLbf
   V1FenERVt1Q2bJq1myl2JLQyLFRpZoU2J1uNxeI9idRD21rbYIPWhTrPT
   Vs18Tj2Zz0AR+dbozU8axgCoVPDgInaL2stLAM82105ZJhbD7ezD5Hyv4
   g==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="219135012"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:22:14 +0800
IronPort-SDR: +Pbfr0OEkU7K7bVBQx2vK/+jUdtBma72DjH53Tk0USeIwvUcqSqrPkTet0m4fTKcmMlN8Z9uwA
 NysK0yycUyWNvPpg4m4ALKtQOBZdq3GO8lLbUGL3ocmrSbpoeMSz0BWNG9/MDQ+SSWVNqvTC0O
 hMD5SgyOwymU+tgnY56MyiymaMGkX46P4ilwCzRgkSY/KpyXwlaeV3GMzOLb0WXl+FzvUryFAN
 EjaD0TGVD14UFyi4mqUewKggbvWxZmw2r1qEX6jvLFtcavlxeH1rwKTaXhFweM3YVkNEyL7W17
 sSAbrjFCb9cseYJ9AyvmkHPd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:41:47 -0700
IronPort-SDR: S8XhBev1A5plnjnMa3ZLmYo/Wg4ZK4/ywNvaMNG3OdPEbXAMMWnpektnl0QUPPxZIyFiFZL8FD
 vfw6aZeycCrWLXsivo5Z8HBJtOb/2Zf0Tx52mzq1AdYHB6csbXmrNM8DsPiydRuxepVFILtfOC
 USJXogO01/C4iHmi19I65elkTyZVm0Y2AK0uNMmnQ3z55ZVCjm0gO1UUUFcufdBpiS7AG/HWiY
 aLQCGk49bpGQA7C2Eh+IXS+xgSuAHzb4eSncPZgF7F6uBdairV8M4vb63BVPiQAwGk3aPlqmXa
 3RI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:22:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMjy1Dt2z1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1665976933; x=1668568934; bh=P/VGei3mXd338tEnTE
        iU0+WWo95l65D0cCUal/7BcvY=; b=iE3onShvPCfj/siEPXRQhrUS73RvlWqKoa
        sA/qAc/XmhHk0gw8di+mBTOxngD9CxgjSn7qhuVP9kSsXtbEHQmQMQKIv9zVD2su
        Et9CM3/roeD07CSf5kIcoMUH64kbtPlvb5aDjAS6m1XxR6JSPtdLqKtvncWA+QsG
        e5FHg6+akc8hsFv4oxeGqtWXU1DoNW4/rYxGwCDh7D39qb7Gy4AUvR+J1tqqsWDE
        SWsTa4wr3OwbpjI6g6TMBHEfADYY+q9FjJ5y5nzyLMS7GCwVp7/tf++61ou47Qgh
        M/XzgzULfo9dFfbU92yX9WD198Ny9sDc3s9pdRXCZYvbqF8Z3apg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZzVeEWx7Ercl for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:22:13 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMjw2TCXz1RvTp;
        Sun, 16 Oct 2022 20:22:12 -0700 (PDT)
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
Subject: [PATCH 3/6] ata: ahci_brcm: Fix compilation warning
Date:   Mon, 17 Oct 2022 12:22:02 +0900
Message-Id: <20221017032205.2210188-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
References: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compiling with clang and W=3D1, the following warning is generated:

drivers/ata/ahci_brcm.c:451:18: error: cast to smaller integer type
'enum brcm_ahci_version' from 'const void *'
[-Werror,-Wvoid-pointer-to-enum-cast]
        priv->version =3D (enum brcm_ahci_version)of_id->data;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by using a cast to unsigned long to match the "void *" type
size of of_id->data.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_brcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index f61795c546cf..6f216eb25610 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -448,7 +448,7 @@ static int brcm_ahci_probe(struct platform_device *pd=
ev)
 	if (!of_id)
 		return -ENODEV;
=20
-	priv->version =3D (enum brcm_ahci_version)of_id->data;
+	priv->version =3D (unsigned long)of_id->data;
 	priv->dev =3D dev;
=20
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "top-ctrl");
--=20
2.37.3

