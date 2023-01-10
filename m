Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B1C46467
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjAJN1k (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjAJN1W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:27:22 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD73BB
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673357241; x=1704893241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2Z83dzCeZHKddXeuTUmcn0ovi37DfKGzvD49wy2LNI=;
  b=YZKGi3BWD3IR5b+32WcnoQWmf9U3rlyVIIbKCtJKxVrjdR8pLzVxmljg
   CJmKmFykCppDuvBGD57qcuyQCnp6kCXTRZOWsDzenWzdciPKycjdYIfCN
   bktOo1FVGcIP3NBCE3IZbpBzzGzzwbC/hqux8vf/PFMtu0VDKmFFcDsvJ
   xQVgNNxULp+hUY8sOgXx1mDECzaHAVop1+7vToGToBuO/ruyJSdhIqtkO
   9ceXCUrUysuJw+BhLdwhDLDpYAWuI2JdzKAO1YnvY3xf+YRdlaMVJRuF+
   6AQVCyHPlNOGI1uzEMeb/GWFug+cj/6gq/jnqzcgW2Bv6goS8ByDVsNW0
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324741510"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:27:20 +0800
IronPort-SDR: l2edOPMWGMq02lK6vaxHtC8sfYj46CCgsN03+VsbcO9q+a/ma8oXcdCJ2Qj5/u11ZZ7SN1twsm
 jkXvIp0uu3Ye/54vKVRK03FC4wuHUxpguiqkHB5ZZwnu33veSqXA3RgsNs+xaWWTlDh/PvC0k6
 65NyhTc0n52vUJ1adQORspk8xlS9uhJTHB1cqUgDsNs1yJzCXDVF/yhi1fn5ww/0gBckl/iR6G
 oEkT03gaLnj5HBn9VvjyWkf2c/aOhMSq1cWPlAX1CQozRUCNU8PDyNqa61ZGvRUH3d8HVQ3o/z
 bn4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:39:26 -0800
IronPort-SDR: mKWasVohmWfp3M2u6vMy6lGu4bM29CJmX+XRS1Drylk7zTgjn86JEqy1vb2R3ih7bxbhS1vfjd
 GD8BzmYwpo1Ha7vFY1LmFw20h9c/F2VpSTBSQ2GsMkf9V8pZmMZEyPHvJXp+oLHH/casc3QpVY
 sllT0Fvijrr6671nmRcVXWnFe9veDvEBHEclPUsReRcSnOBg4P+jgW4t8pbup7lxBoxDtb+tHV
 o+VYIT3oBbMMwwFgqhdqu97zcGJ0nr7J8ETEgaWIRoGjxxDeFSbyl3MB1sRvuqa6J5fxohSNHH
 SHk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:27:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs6w57qpz1RvTp
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:27:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673357240; x=1675949241; bh=R2Z83dzCeZHKddXeuT
        Umcn0ovi37DfKGzvD49wy2LNI=; b=ZJ+0O30axYCJ+x2trR1XYoFhrpq/aV2ttv
        jKGDDhHgt9mHLxqEY5YPGnVjkbC3LIVJ9aTJQ3QZW5db72btJvoJv3RlGoaxKyD0
        uQfoQbv3rErZBsD3qjMbzTVqXhM9hILOMskdDAx+O9WJVQ2+CVqo6PIm8HV5etWp
        Ah0SJ68XAR49yjj2TSHdIwVAaLJYbi/XpIvqTbUKhYX7wgUd4BrCMeMxUrBzJCZN
        +FPP/1/B5Q5vQA5/tsTsd7liprMPNowc0/UERrSScnLjYdSlkOx36yo6GHKtQ147
        wDZMT3dh4I3QY0BmRyQfwkpCXOO2/uV2m0pX0S/bnYahnfY3ezxg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YE7Y4kURHQ7e for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:27:20 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs6v2jnwz1RvLy;
        Tue, 10 Jan 2023 05:27:19 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 6/6] ata: libata: blacklist FUA support for known buggy drives
Date:   Tue, 10 Jan 2023 22:27:10 +0900
Message-Id: <20230110132710.252015-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thread [1] reported back in 2012 problems with enabling FUA for 3
different drives. Add these drives to ata_device_blacklist[] to mark
them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
problems on old systems, the model number for the three new entries
are defined as to widely match all drives in the same product line.

[1]: https://lore.kernel.org/lkml/CA+6av4=3Duxu_q5U_46HtpUt=3DFSgbh3pZuAE=
Y54J5_xK=3DMKWq-YQ@mail.gmail.com/

Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ac88376f095a..36c1aca310e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4133,6 +4133,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
=20
 	/* Buggy FUA */
 	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
+	{ "WDC*WD2500J*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "OCZ-VERTEX*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "INTEL*SSDSC2CT*",	NULL,		ATA_HORKAGE_NO_FUA },
=20
 	/* End Marker */
 	{ }
--=20
2.39.0

