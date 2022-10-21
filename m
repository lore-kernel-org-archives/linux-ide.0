Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C776C43219
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 05:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJUFiQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJUFiP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 01:38:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA9722D592
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666330694; x=1697866694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5jDx0lP+o2kM2l3dFDfXJIWsNbQK6E/ZPhUoPm7PXlE=;
  b=GEgfkOd2/MH7UAIUtwSpV8LmYME8O0Vg5lUTTN4dF70QpPGgTv5byT+s
   YhnNsdgU3cGGrwhATfYXHiDQi93wmPCDWPerWhWoCcVuAddd2IbDShl/8
   k4ZdiFf7LmfsdXCOkXUnhPxQvmwgfgxf1+Yrcxwvy5bP9qXixxczazmh1
   gCJLhZBse225gKAoMNOs8HLKEnfocTXVUJgjBv5bPb7WoFa6cFIm8Z2pu
   g5an2zJYsX3awTNUUT6QHfGt2WHKQEd28g0fdMJbmszHR6xTPue5NFTJL
   fELVUknmDeR7ydiU68BbOquiRxnEAzgOTsTXB5xqTrBFxC+oxWZj7FUwu
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326518274"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 13:38:13 +0800
IronPort-SDR: /yTXpkZwRI19ogJMdB5C4Zk4AEQ+NxHOgu2tWSSMB19UlN+xx8VMqDrnkjTlCjODRi18eNi6Su
 WbBs6GGZc3H8zLduGnP2MA3zCXMffxcPw3mhL3x00CRoVbWrPACGlFeW+XG6AK9UsVvHjE6v76
 kOeXCJxEfILF2+jaMbSKKH6SwntR8ROyt1Sun3AvFSp93UlKiElxUoT9X0SiTa5gPmIl4AAdb1
 Ju7JhacO+P8IrgkI+cpVuwjNZHnL+ITP7VgeQFLkXPGH8SqB4CKK2sMFEcS4ZVilOPMbqph/6J
 feffR5LYQvP/q2T8srYuyJ/G
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 21:57:41 -0700
IronPort-SDR: duhhL8ufQwLdrCXt2pbW1YErf1ZNslrXKTa3ANhKXLY3XTkTMgEWuWTeYV8XsDKL2dOOVnQb4C
 ODev96GuKnbp7Y+n/g4XKHaIuiRyRo/AUczdewwmrUxuqHEZAPELE0sFm4xNBSw6fk3vKD+64W
 jXjcHpBHGIN3tVh4VCGq0saeTj+z0hO+uweqAlkg7aY2/FOSdyyusVWctoOqHQ/SfROwL4o41J
 hLpkPy3z0xMzig3jSytbp7e2lMcY3ima0At+rn4G7v+SbBfd8HI0XLZCX1YE7CTCsGVoFygqV8
 2yw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 22:38:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MttY136qLz1RvTr
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 22:38:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666330693; x=1668922694; bh=5jDx0lP+o2kM2l3dFD
        fXJIWsNbQK6E/ZPhUoPm7PXlE=; b=TXElKP3GpjEiYq/PM4L/alVS6V+ZuskerU
        JL/rKM5jCI4k7cJJBXmNnjCm0My+iyEJuvagOPwJVI9aD8/0dKF/qXPyyl6SFXse
        YBC4Cq6yDVtAmYGWjM8J8E5jKN2DxX4yr7tszAle99xbQU49fKWofHSFiIcHbIcK
        K6RKQfN5eROALwhA4uhIX4vusQBRRDNPvBQIpECHb9l/c6yZxMslHkxc9sARjE/B
        KZ74N1DFSq7+Sz877GeRW8Ii7EsSUxwLTAQJVhlPyMzw0T1CbO2VEcrgjPG7IdFc
        GDV5+vt9fCuEtdrAYOv+hVXPNkpAty/FO+cS0s6s8kphs1dMiWjw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oXYUWTx6Ww3o for <linux-ide@vger.kernel.org>;
        Thu, 20 Oct 2022 22:38:13 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MttY03xvtz1RvLy;
        Thu, 20 Oct 2022 22:38:12 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] ata: libata: allow toggling fua parameter at runtime
Date:   Fri, 21 Oct 2022 14:38:08 +0900
Message-Id: <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Currently, the libata.fua parameter isn't runtime-writable, so a
system restart is required in order to toggle it.
This unnecessarily complicates testing how drives behave with FUA on and
off.

Let's make this parameter R/W instead, like many others in the kernel.

Example usage:
Disable the parameter:
echo 0 >/sys/module/libata/parameters/fua

Revalidate disk cache settings:
F=3D/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F

[Damien]
Enabling fua support by setting libata.fua to 1 will have no effect if
the libata module is loaded with libata.force=3D[ID]nofua, which disables
fua support for the ata device(s) identified with ID or all ata devices
if no ID is specified.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6008f7ed1c42..1bb9616b10d9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
=20
 int libata_fua =3D 0;
-module_param_named(fua, libata_fua, int, 0444);
+module_param_named(fua, libata_fua, int, 0644);
 MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
=20
 static int ata_ignore_hpa;
--=20
2.37.3

