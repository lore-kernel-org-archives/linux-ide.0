Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5285C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 05:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJUFiS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJUFiQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 01:38:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FD1D3EB9
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666330695; x=1697866695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xuAmGEn348RubcykWSiLzYAm2/uYdDmjJOxyy3Ikx8=;
  b=d1EBigoXzWv1qoNQPzRfUgYbSVmg6dKoYz6EdZ5XQ0IfCkNu10zXsVUj
   sEdtCX6G1Wrr7BRlzS7ASAUV4bOvpjYM5tzQRgSLhcAaGq0kg7fX987SP
   zA5IG86VSu0StN4WkdMtO3F6uMP0arohCsaMvTAh6R1Ar3q1w6GpgRdPj
   rrPY3sLt0FMrSOySI7mDqRHMwDrzsErL4Vzel+1/YFWFa+Y/YjaS1Pl/J
   OGkRle0veR4XQSQjDtQakiiNKeHQM//zIpttH/d93ZZWuimFUZJ61Pg3B
   9NJn/1mYy42idyiMbvoKPInYK7CZxrILiv4C+3uGj/Zt69InLhijo79NG
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326518277"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 13:38:14 +0800
IronPort-SDR: BxyTTZdvj/Ub97MfXjjJ6zhwaMt8EWQ92N5LM+SMIXZIT+rbo/D/novyGj10TAF/7xKpoFI6NO
 AlswLIOnV8cgURgh3M/mj2jhYb5NCaLnxakNs4ZG5O2puet8MtOeRtzXMIg4cq5/tWjysojiQU
 TfxlDgTYlF943uYUN/nxRk6a3l8A5BGdCiFEjw08xKJYIQNPGg8e7RGnnO+Ihvyt0ZNW2v22cR
 mTmBNE47JzSSH/RpkFLQA60u4XX7188xn7ZEk7ZR0yQ4OCacsHpWl3HXZyaBB2IBvuMvioJlpu
 LyOUd51s2PwBJVMgbfJeGgo6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 21:57:42 -0700
IronPort-SDR: AUhRPngLNht3OWe7w97dX2Q8atfMKkItXhlJrVXw9MDF3/cwdHNqeEPv8w9Vn0kH3urEq3A8hy
 1hPKHktp5O5PjgioodgN6KyDX2n6kGHAHRj2yjE5KoV6XVTfq5BYw0f2bjzD7r7+R/DiB86jB7
 CBS37rmfBWSxUljtDwPq3HmVSD2Pc2Uc9hWm4FoxeQsgfZCz3nNFTQYcBefO/w8qXvl/HNa7vu
 SS4EOpXMYg+n4HPU11o97CnH1tQDPic1AjjrgnKjhxWSs7SjE3hTOv1ivBAsw/7rUXnJakNkdX
 3dg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 22:38:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MttY22JYvz1RvTr
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666330693; x=1668922694; bh=5xuAmGEn348RubcykW
        SiLzYAm2/uYdDmjJOxyy3Ikx8=; b=hnOWBDLk5191RCMpkLrc2QWy4+VroW3B+8
        0/mRMvWtwLn0REE9PM3NvG0ml4NceTOmV6P5yUyZaNdMJAii+NwshQLN/goKmRwm
        eLM3p1PzPP+2PxVnUq6qQlOJb+EndBhpCRk2QhpHdHvDSjcnzrWM3A6cNJ32filv
        YFCfHHlCeEDF7GGlzxwlbSaSgMQZ+IXIpOxYa+HkIOz2BjQjsbyR0plGKKMPFt19
        wvK3hVe2HfxqI70k2G/akCIBN2htxEy+XLwUw13Y0vTKI9dbsltLocM3srBGcgKg
        lLVKc2hYq3SNpJqNpAib32B4KHI9Qo29naMkxIQE1PQq15rfLcPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j4x7j-dHTbzF for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 22:38:13 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MttY12qhZz1RvTp;
        Thu, 20 Oct 2022 22:38:13 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] ata: libata: Enable fua support by default
Date:   Fri, 21 Oct 2022 14:38:09 +0900
Message-Id: <20221021053809.237651-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Change the default value of the fua module parameter to 1 to enable fua
support by default for all devices supporting it. This parameter
description is also updated to indicate it is deprecated and that
libata.force=3D[no]fua should be used to control fua support.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1bb9616b10d9..140e7e7d7833 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -127,9 +127,9 @@ int atapi_passthru16 =3D 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
=20
-int libata_fua =3D 0;
+int libata_fua =3D 1;
 module_param_named(fua, libata_fua, int, 0644);
-MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
+MODULE_PARM_DESC(fua, "FUA support (0=3Doff, 1=3Don [default])");
=20
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
--=20
2.37.3

