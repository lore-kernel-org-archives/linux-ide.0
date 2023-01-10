Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D4BC54EBC
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjAJNP1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjAJNPM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:15:12 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177173FA1F
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356510; x=1704892510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IW0E0zt4+oK414/Fnxtbs0u089eGYcEATsrMArum+s=;
  b=KK/MFtw6tcJnXg006s30xby4RPF03rBed1m+JyqgaIgbIdZkF3ewDrXe
   tQV0JPqFh3NaKYkGHwS0BshWOm9wFiHkQAaZf+0+Dts65Qk+FimF6xnDF
   trt4wLaIHTAWAj/vgoEkaiXFm2dDi2BuiXpP7UEMYedFzY88WxAkDoVCW
   rb+04emxqFgpdyH7QaL0HMafp3L3vbWkIsnTSpDQBcdsA0tO0kklo7TL2
   9zW6232suifptVpH3OUkhKTf9wZ5IJDeg5DEnMewASOgEJXUrha5omN3s
   hA7C+xk4wBPxs85nue0CNB5ZQHCZp5WAEfxR3VREv+tvI8mFH6BgAVJXC
   g==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225492649"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:09 +0800
IronPort-SDR: J8kSDMA28zv9b7moUw58nKLbQrBeT8P9bI+yJy6/KNPczSuQG66zGV4OP0wJIsqeEv6mrx0BSn
 uR/UyN7TMJ0M/+8RwpccY1/Q0MqxymvW/3b6/HNYrrg49dXHbejl4YWV3fTZuPrFHgS+NsFikx
 H6o56cBRABbdmJlwuZN1PHHQRS1FHhjOEx5P8/Z5Zqr8UhwML1l4jP5HK2eTRtLAKfoLxkb19m
 ycFKJqIQlKdEzsv/4z5JQFRA0U8CyMVVAN2rKejJI/eDqr2a807JwC+hpjP0KhlOu0bdZmFu1C
 ihI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:15 -0800
IronPort-SDR: t6HDkcTXDwrgtx+ZEMNOACN/zq9FBT6nFOYb/+7LGfoak8Yiec2xdLShvn9R+KL2Zqw7pz5oy/
 XCSufoMQljpgJnBLPDpISr2VCYPWSlmQ45W7w+ja5cVQ+x55i5BHXyMroqgxNeHf1V7Cn7a4+o
 JnP9vgBvcERpSxLmHAs4qE2xTOoM40hs4jYh48vHSMyyZj337zaPs8Nkh8FXkf0IfPx6bxc9Z6
 tEhj+xVN+ORwaa9PV3QmDVoE7WhhDqYOlJ83wNYbrgz3HghVncIXJlmK0bZOXwsp/ilqyny4Je
 DzI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrs57nPz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356509; x=1675948510; bh=/IW0E0zt4+oK414/Fn
        xtbs0u089eGYcEATsrMArum+s=; b=Prfl90dAQRianVVCKovPCof4A/01sz28yM
        Ad/4Jd6AteiQvYYyKeP1AV3zTdVLfPYHqH7eL9MInl3IDYPTSbZGWJuFAFx7VLUr
        BXXnYf6NryhiDMP+guZefP4l+pLUrMBfLZWsuNjcw5ULSK5D3IGqfdXVr4x7aPjx
        lUFx1xW05f6U76vPv/AxK2AllzG8d+adOfiNuKhNRk7nQmCAlBWhr9O9qaWVrgNz
        SGEUztNS5bHWi29D6NJU/6zy5VBPKdWh+YaUdWF+3KtlooYKTRiPzu7+x1nu0kuh
        96NFny1USu9IHtGF49KMx2sZmsuI4xgYnICFE9zZhTST6pu6+H6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bM_KrZgd5SDv for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:09 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrr2t2Jz1RvTr;
        Tue, 10 Jan 2023 05:15:08 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 3/6] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Tue, 10 Jan 2023 22:15:00 +0900
Message-Id: <20230110131503.251712-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
reflect the fact that this function sets a task file command and
protocol. The arguments order is also reversed and the function return
type changed to a bool to indicate if the command and protocol were set
correctly (instead of returning a completely arbitrary "-1" value.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6b03bebcde50..1c16342dda08 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -574,17 +574,18 @@ static const u8 ata_rw_cmds[] =3D {
 };
=20
 /**
- *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
- *	@tf: command to examine and configure
- *	@dev: device tf belongs to
+ *	ata_set_rwcmd_protocol - set taskfile r/w command and protocol
+ *	@dev: target device for the taskfile
+ *	@tf: taskfile to examine and configure
  *
- *	Examine the device configuration and tf->flags to calculate
- *	the proper read/write commands and protocol to use.
+ *	Examine the device configuration and tf->flags to determine
+ *	the proper read/write command and protocol to use for @tf.
  *
  *	LOCKING:
  *	caller.
  */
-static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device=
 *dev)
+static bool ata_set_rwcmd_protocol(struct ata_device *dev,
+				   struct ata_taskfile *tf)
 {
 	u8 cmd;
=20
@@ -607,11 +608,12 @@ static int ata_rwcmd_protocol(struct ata_taskfile *=
tf, struct ata_device *dev)
 	}
=20
 	cmd =3D ata_rw_cmds[index + fua + lba48 + write];
-	if (cmd) {
-		tf->command =3D cmd;
-		return 0;
-	}
-	return -1;
+	if (!cmd)
+		return false;
+
+	tf->command =3D cmd;
+
+	return true;
 }
=20
 /**
@@ -744,7 +746,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 			/* request too large even for LBA48 */
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		tf->nsect =3D n_block & 0xff;
@@ -762,7 +764,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 		if (!lba_28_ok(block, n_block))
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		/* Convert LBA to CHS */
--=20
2.39.0

