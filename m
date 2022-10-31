Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D8C38A02
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 02:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJaCiI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaCiH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 22:38:07 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A664F0
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 19:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183887; x=1698719887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xz6ycfIfidoOOGiPhXlSF5Bv4e0fjijWd4+tMRv7Bmo=;
  b=kkfQ+0+N8/FUN2Qc2KVGHPbAMT7O405+4ufk0bRsoKkNxj/s/Jo6PO/+
   oR3uo7a+mCySWEcGclXfsIXNhQoBDyrcYwg3z4t2z2q6FT0qLo9z0aDrY
   Q/2uren7QBhf8FsDp4XWWPLaUiUafwvPDXYvgxjsWzVi/Li+CblXcqArZ
   3qHiP1Gs0LpPmHCfMxuiDjFfmYYliCFntIuTSr6Jzh90+5k3Kqe2XUy8F
   p+1N8p46l0+d9qWx5os84d4VXJ0e1b+FgNbief4yC6b2lpw2eVpZZwPzJ
   I/7YU4PBa7DXbS6JqsSXldxEBgua+El5BA9Kk2Mep1wRLdNBuWzWP8f32
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="215447473"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:38:06 +0800
IronPort-SDR: rBE0ZI2tpLpigDGucQO8fJEKX5qIqk+kLyiOLbf4n8tK9h3pxmeNE/76B8n3GxT6T3QfKj/gwh
 QeE1+oTVTgqZkrnzc8NgnsWRu51eJJGLFWgNt2XWtDKM0yoo3kQ2eqUEZLCo3dlnI56ZiAqozf
 FXI3QNwRKXlPF8cTbRCk33x26jFHy17HxjG2JzCSDHVcm+/aYilGtQ6p6yGGX25hFcUirBdxu4
 PR6YH4cjenILZh9SY2PzGoA1hKxdd+yI5M+D82B3oqBL3QOq3IvQw+06n5lWECT3cTC47kpMNg
 MEaZNtmrBV7QGtJptgjMgksa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:51:39 -0700
IronPort-SDR: pNHs1EK2tIMO/h2ZBlc/31xWZhmrNPnj221JkRlJFpSKDbLi7yyEI1oxLFz2kZ0Hn1vjrP4S8+
 GJlzvb2snTgHhxBxKpZd6sFfLNmIKml16sZOc3lSJH6ru8WEB03e28IP1e8/QQ5qs9XsaSl8RR
 oJC5/a87VroNuOECAL2ANzoHkZErN9ZVHLtlciNptwy54l/BM3zZxrsqDmVcLWOgDKqnaHqkj5
 PtPE7/3Z+GszHDXYJ/BGIF9S+AOtNs0F7afG/sOhY4J2qp1/QG8QpiTboSS7ZpxlM/ECVvd1/9
 g4s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:38:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqf47QNz1RvLy
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 19:26:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183214; x=1669775215; bh=xz6ycfIfidoOOGiPhX
        lSF5Bv4e0fjijWd4+tMRv7Bmo=; b=mSFPBxsKCyB+SZa2mL2FrrvuEukrzZHxrM
        XDzfN585gQGvVt+c2ZwuQ8sl8t9SNDstQ08FeuvZQiyPjygzLaLFCVbZklszwdMQ
        /e162TUmjz2f/MWXzf9H5bznUlQ4zTHd6ArZi8uSxs+zPQZJrgzmJaMC6G5+ueb3
        scEykZNNBHDZ0NEqMXBvwnj0g6HTzKVtrjrylz61VcDXjUfJ/26xirBNUwHNow2A
        fZwp9hQnGukR/tYi5tqBk1wR6+d/VhkmkW+mNzAOFk2AtkuLaA7SljayQDUR2wGX
        Sfr7leXJrdhXdTFeX3aPlMmudvYmyimhghhNsOr9UAOL1sAOS1Rw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qvj7B9GFNTfM for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 19:26:54 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqc5fNBz1RvTp;
        Sun, 30 Oct 2022 19:26:52 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Mon, 31 Oct 2022 11:26:38 +0900
Message-Id: <20221031022642.352794-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
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

