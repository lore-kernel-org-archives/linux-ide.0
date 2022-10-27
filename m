Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDBBC67871
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 07:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiJ0Hut (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ0Huk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 03:50:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839F50F9A
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666857038; x=1698393038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZvxT68TPawr5kMpnZe7jSWLnJqX8MsbOD5/LZPH9N40=;
  b=ov8fvjklP6rNCnUl0ZPoN7ehO60l43S0qXnVLH3Dzx+7BSHZITCrB1JG
   wLqumL62NFF9eia0MFwMfEqt1gR2/AE0Ie6vFggFTOeHmh4P3IzF53/ug
   2Aqx/OACOdqZusg8pbtWm4uRP50+Y86KO4lwnRXhOBxuX5UgmgSbwQyS4
   BTpzFoLHJ0YI4zn8njHV9KNtf0REqQSCh1hdIeRHqMOgB5MQnTVGB+CDE
   RmJn8/9vp7Plx3TLzQL4OkX2/7DlcWWIu7k2QqQMkeQnjcao9Qd2/VekJ
   rgn/EsA+7arRY3Mj5l99LEnLY270RQql/YKyIrP08DefQ4zrAxmyBF1Za
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214853401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:50:35 +0800
IronPort-SDR: K8JBNUBeV5I1afT5RVcuXqgTvM76BpRm3cF9fYt/uKc2KVFVhOTSP3d4uCArULu7t9vO1nv2eN
 hc5TxTNZeam842FoFpRZc1d0gXwv5JlpCZrj3o6hbWJ6I8VgA6gwnnmVI3rRGIU5aUOm89JntY
 d6y6Ny76o927y+JgcJ18//OT9Wm6fyXZ6TKcHD1bTS/NfcupRyxsv1dkAVI5KmR38HkyRCtpWI
 Dob2uNbh5cQzt6yrAniNO2DkJ61B971IMOACWvShRq+0AB5VbXSWkrps/sDD/Nrn124qmDcZ5B
 4Ee6t7qHzaKvDc1AnGHb13yM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:09:55 -0700
IronPort-SDR: Q8ZC/jTwjVQFqVprI3KohK/Ak6WwSW+IZ21q11vAQ1RnueibkHaeSuBA2Ov5X13YGPZiLnY2DM
 aAc2fwg9aKhMKYTYIIzTOQnkRDYzUO8iRl4O/ZW37kENGn8TQm4kWJV5J9vpxUwlbBVSsS9Wj+
 3dZt1V7IlRX8PL825Yk40F+nHXAJ6bTe+p8eVAW93QPr7gbFrr5CHlWkwxLksZ6ybmauavhCKm
 X/08eNXo6/6ykup00AqAZTlKWpF5YA8R6caSKhdFsfmm4OJBq870cA3l+nzIMxenMESyd+R8PQ
 Nt4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:50:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MydBy13z4z1RvTp
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666857033; x=1669449034; bh=ZvxT68TPawr5kMpnZe
        7jSWLnJqX8MsbOD5/LZPH9N40=; b=ZUjnsPudx1aC5KC4KJ9IvGzAal4oQgnZgv
        E6enAGX/s1AE+YEFnygtbInZeYWAETFxnnqaO+6vOqBOa7Rs8Bf+1ziJjar3QLQI
        /+CDEZy+pz19+0Li6/NpUbf65TpvT3yudpYKY9GIGBxK+6oNfZRvk0LYeMKX5EoZ
        abLelfvWmUnrcIXUB/ZhWOdcOETHwdhoUnZ8cgyRf5gPn7D0VXRwxCgbbDKeU/MX
        WMQ6LbgtC7l2GuQ18jXZWQiKC9rnZlK9m3cSb+3LGbgcsnx3DfctaRgu1lkyGGSQ
        CUVOBsu5gYCDqM1UtTqhr3hjjB/FqNN28cDYt7FUqr81JiCIuY5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GuRAki6m8hy5 for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 00:50:33 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MydBx20b4z1RvLy;
        Thu, 27 Oct 2022 00:50:33 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 6/6] ata: libata: Enable fua support by default
Date:   Thu, 27 Oct 2022 16:50:26 +0900
Message-Id: <20221027075026.240017-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Change the default value of the fua module parameter to 1 to enable fua
support by default for all devices supporting it.

FUA support can be disabled for individual drives using the
force=3D[ID]nofua libata module argument.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ec732c47b6fb..77a7be74e65e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -127,9 +127,9 @@ int atapi_passthru16 =3D 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
=20
-int libata_fua =3D 0;
+int libata_fua =3D 1;
 module_param_named(fua, libata_fua, int, 0444);
-MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
+MODULE_PARM_DESC(fua, "FUA support (0=3Doff, 1=3Don [default])");
=20
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
--=20
2.37.3

