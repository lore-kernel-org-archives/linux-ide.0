Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB4FA3746
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJaBxm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJaBxl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 21:53:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ACD9FDD
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181218; x=1698717218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xz6ycfIfidoOOGiPhXlSF5Bv4e0fjijWd4+tMRv7Bmo=;
  b=erNUGukHdwIlMpIBQfzcNRu7wtJKSjUV6XR4tsF/fm4QK+Q00Ubi+4K5
   mdmbNJxLoMBxc9o8yhPF8QIXU8cvkf4WKMiUKatLsrBxpU5wmGYxZZx1M
   uri7eVTU8ly88LGgTcjAx43fpOxDnBIq72W7kr2bEWKzhZuGyIScNwBUv
   +UKT+MvABhphC34P2V9Ufr52ZFoJhA9QgzMkGR6ZUeFsht+PCVUKXmUpb
   F233TbfkvywvdZmuRvpzt2pNwNbHnhKDovZ2gDq+rpzQAwD0vSL9WDjhw
   F/x6M0SZf1pOm1dCWp4Na6O20QuNQzapRnJnf3shQF/E3sV0teF+Ux+Kc
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220246027"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:38 +0800
IronPort-SDR: RLGK1khXdxxSwNagHGBwNr78AUitNSAOEEORF2+ANGZz24vRd05bumQD+wV+4mHHDXZe/w/4ok
 V/xxYHdsjaYWV5MMzsAwV2mybRzsGT3pSSa9rlr9l/Fq/LL9HwBVNsn0YJLOmGNl7G4ckGYZk/
 We5/YBiqjqqff8waas9XL4epDRmlGrII3Qq31KXwAt9u7xXQN4GE08IBhAUb9IgzB6jwcK96fo
 Mw624hX7uFY/c+rz2jpS9fDzBjCS4XtlOxZW6NOFm67YaP/FusjFnS7dT2SFs1Xq76587Iz6cK
 7KAO/289m/Mi4FhsXFwSCYM7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:07:10 -0700
IronPort-SDR: MehPebfOyksUimGftqekhCluTqwVvcG91Y7HLyvtZ4j0Gis1nijMNu+z/nuc3y+Fa7s27XHXfr
 MTyMFcCv+8qcFuyFa0V+EabCTacl+hj3g99I063LtLNS+OYpqAxKFkrDihJCdFSAZ9WKsoFFfu
 fZjZXVDl09Za+RGnYukKIAVwBnfiRVAqDfZ30EiVBbqJELMgMIA/s00jHFpq3M/GNZa/00yOZs
 AjeRWx5X5VQ9XAScVsY1YuIj7turW8tCvmAMZjjfvpDYvirlTX0IVK38Wc49GNsYiPIrTO3M1A
 b8A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x5D5T2Bz1Rwt8
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 18:53:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667181216; x=1669773217; bh=xz6ycfIfidoOOGiPhX
        lSF5Bv4e0fjijWd4+tMRv7Bmo=; b=ONCNwipyzZ5hfPYQpYbc2AJyNirqDw2GbQ
        t/Kjy/Al705nYuz73rRQPS5K4kGd5xxfmHA1sFwqSMMFfjPET97iH9IRsmLrk8WB
        oV6vYvLAvZ/xZmg7O/0tDMX1h282iqP2l7KvTnDrxWVh7DzpfRp5Ce+EmX3gw03q
        +mWgdN+Hgb44aA3eYhIqwT/JR9BVYl+4oSh3mZN8BoHkH3H7c6aFqdhTfgJIHt1E
        tACn45SdHTqZNc99/wry9NLPvNw4KBI62tzBbUKnCzsJdGKUHjyb2ca4Whe6jq/j
        jZBNC8tH+MRoIVIair2yRyy6F8s0n2BS5+cVToMNrTSBC2Ty/JZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FdPi3Fir75Cd for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:36 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x5C2XfJz1RvTp;
        Sun, 30 Oct 2022 18:53:35 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Mon, 31 Oct 2022 10:53:25 +0900
Message-Id: <20221031015329.141954-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
reflect the fact that this function sets a task file command and
protocol. The arguments order is also reversed and the function return
type changed to a bool to indicate if the command and protocol were set
corretly (instead of returning a completely arbitrary "-1" value.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..6ee1cbac3ab0 100644
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
2.38.1

