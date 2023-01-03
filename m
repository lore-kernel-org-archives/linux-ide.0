Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2CC54EBD
	for <linux-ide@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjACFWW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjACFVp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2023 00:21:45 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C4B39
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 21:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723172; x=1704259172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjsfBZV8/cYQenaf4a1MT8cE4OdYyuK9gJVyVtAGJMQ=;
  b=K6FMRHU+qzm3ut4jUcsJq8bQsKrX4AEH96MmKx3fBw6HJH1hfMM5BZl8
   vbhtEWFcO8gAd7lv6bUFweuMIpKcPwI/wlioELkIsZ/hBfvEVuWwTNF4H
   3FqSh/eVkiGbJTKAg0N2DuKxFjFLXU1YE7GK83w3knvT9RTGLIgvpUMuQ
   v4cwt31S59Fit7EfgkI1ARui8d+esLutK6uewthq0YhkAvyM3hXNCZmrc
   81FlurJzP/6ZbaRekCwJQ3Xo/urIjRf8wcL5j4zc8VLTEb/mfrITnRLSK
   KsZkY+oj4Z4GfVB9sx+u2CmQzxMgUTfjNRbfDUCe/SUBuWOq1qAgvTzM/
   w==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219794876"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:32 +0800
IronPort-SDR: ClSxViwwnDY/LwW63PmcrGOK2o5agyK9XcXA+TK/JI4wdv/Opis7AILDnbv6JmNJyUHoVwqBUx
 2NuZltaubpKgLWFjQoT9IhITwxteiJan9CkUWAvDCNhJQwtW4fc/GoC5oupUrQ78I+Ihs9aeFw
 kx1GMA5mo1cCO5GZ9vIWYXP/ppQdQeds6zfFFf0fc/pXPaEXv4CkmkyxeZWunWaCjIaznYm0OW
 VPaxgDdWGUh1PH1TT5zugTUd5+jZYn9PvaTAEWliTEgWyRLIMsHYQ0DgRleW5bcfQ5arL8Sm3v
 z8s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:31:46 -0800
IronPort-SDR: H9PAlbdNOWjVcaVOKVx5FnWXbQ5gYa09u74dKkCnByQe0MkrfJ3eI46YcTM+DSAH6r5GThFt1G
 Xg1eUkqzfnaE8Fme2i2p95Vj9psx76FWGzv8Lgd5GhaAhGYv8mxDKVOViipSJdai6A4+nxJvdr
 dcUhpqx0zNK7Dh/rDGNvTzTGGCDfHU/owAvGgYlxYGwXpfJkSZd8HmWxZD/NSLT7hon/3q/vDD
 sYVFEr/1Bg7b+RNLEGquYb/6y6fYKH/goNpuUagZTQoU7+mOgGyoe2LNv54GKVL5HsIlg9rRa6
 j1o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdJ1YRyz1RvTr
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 21:19:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1672723171; x=1675315172; bh=qjsfBZV8/cYQenaf4a
        1MT8cE4OdYyuK9gJVyVtAGJMQ=; b=gxNzoNBobFmA8AcjetYDO3FgL0ug2WYlXF
        qaKZnGS8C6h28X5QYkuSkt4dNITloAzyy/4jAuFPdkkq4edG12ZBRbAOhBD/QjWZ
        XA+vlxEdMFfXYQ4h02q5t/zw0ecP6HKYftyNtVpQ84nxSCMESi2EY644tI7lINJM
        OywaN9v13rRt0Cp7pdfJPcSRwOyZNYAij1wUIDQvpYerpuYQp7ntMR9EFXzoYy0w
        eTByQNw9u5G0DrQQhQC14U4BOOlYOwI8Rlac3fuhFmB0ET8Zktz3jmzz6PCAXIaB
        I6RFYCnukDR45L+3q8k73ybupVpW8oVEjhb/dpqHcjrNL7On7+Vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qwr551Rq_9x6 for <linux-ide@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:31 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdG420Dz1RvTp;
        Mon,  2 Jan 2023 21:19:30 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Tue,  3 Jan 2023 14:19:20 +0900
Message-Id: <20230103051924.233796-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
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
2.39.0

