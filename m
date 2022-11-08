Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8474DC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 05:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiKHFzz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiKHFzx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 00:55:53 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB03055E
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886953; x=1699422953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72yD6iRsTcTQnmTGrcE8Sp21QO5a7ZQHprkJJaWcZdk=;
  b=LYUqBz/rO4vqPQX9QGMubTLCqYga7lyV29q1/oS8MBdCvEls9uPiVllw
   JDM20aXXtK7IoqUhMwDUUvvRJiEARoiJGodzQ6zDH/MupxV8X5TB2q7Xt
   rWMtYivSlVeNrnizWnGe14+ExbIEDtUsnOxG//ZvTLG05JAIdPUe2K2/A
   oC3O/a55PKBMZphRN0naUvla+3V2jUyDgYsOmvZ2nwWu/SDQ63+NJcRPL
   pUs1S7b03bjeUH6hfrqKNXCbKJeHkqlHw9MjXojyrQksvo7iHPxcFkQte
   +dg4yUwO2g8hEMDC0ucmV2tURA8/9T95DHbDBzK+urmd/C2k8I2cRpzNG
   g==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="320067452"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:55:52 +0800
IronPort-SDR: mw6PrbRqObzBwMjOGXr+4AXyTQqVxooTresUa5Uk1iPEzisTew26D+xwRdK46gPB1pd0IcX7Tf
 8m5mw4mhjyME6hDCeaUaRNI8fB6ElbBU311ll9TmqocgfHZ1gCgt5KHyoYCEcV/c75BnoCQa7y
 IYj8XbjRX8Hsu1bV/N8rxuMQNvYKmAUxNWarLoIbGgaQlhJn9uvNpg3fxZ0BlgugR+56gD5JKj
 Ijww2w6u/rm1TLdFaQ8C7pQBCMOqHAvjF09BMYkdJFIIR7Ly/XNArpvhsKAYHvGntZd46aYMBd
 VKQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:09:13 -0800
IronPort-SDR: abj8/kew9rpE3F4QBOUx2AAZ7cOkfgH7HAUuqvLqEvEJ7lTBiCx8SkopvJG29JDAqayUxY1urb
 JcU5nQNZQF+KfS3XlURabxFeVwZ/xh+/zFOILBEhEazom68tL/lrZwMxqnseeCfcTEROQm/Gkv
 IVDYV+YXpnmsI1Be8FxnyHfgh0MWmjPp4Wc0BUKFCBYvZch1jZTFfAncwpwhbymZNqVrVe3ofr
 BkDhn7j1LoVjqetGGBq7BnC3wnLDuyOzkRDkNNdRcYN1JJzbZ6G4Azugu2DMMQ/GnAt/CbnqTV
 e4k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:55:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y536mWyz1Rwtl
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667886951; x=1670478952; bh=72yD6iRsTcTQnmTGrc
        E8Sp21QO5a7ZQHprkJJaWcZdk=; b=pzNM/9yDuzQaBSXXI3kLYzFeP7eWQgNysM
        RUO48Ams/0lv5AXHNtKN12RC+qMjME/q2mYE5qg9B0wYDVLLZwWqx4DAaKKLKIzN
        9iEqq/6/xrtwl0vie6KjIUd5G1nQJ9KagfoSeV2YlwzDbVqIJdnqM+BVfILcwzHD
        wvwfQUrAmrmVR2HfX/9aIa4tf9AoiDsGFpVQ9sm9zF+wYe5Y2hPWAdoj8Uupwpj6
        myrDeB8DC8A72z82siUjkTlXy+PTBhV0gzhxS5KE/DP8IhumRLw8d4o82THaNA38
        wPYW973sxjw37701YHBQgIJJhnqUeKReKk7NKgTuzudtc9Zb4tTA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y9RbqY5-9t1L for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 21:55:51 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y522Qqqz1RvTp;
        Mon,  7 Nov 2022 21:55:50 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Tue,  8 Nov 2022 14:55:40 +0900
Message-Id: <20221108055544.1481583-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

