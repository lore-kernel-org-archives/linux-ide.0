Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38524C46467
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjAJN1o (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjAJN1S (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:27:18 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D1BDA
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673357237; x=1704893237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IW0E0zt4+oK414/Fnxtbs0u089eGYcEATsrMArum+s=;
  b=bkI3ft/fidq98NUPEj9ie3beEEFrGC94fPQfrd+VHWlc1GdqcC+7jFOO
   j32b4qaWZYaFJ1bjgjJ7INVSkI/2airpvy1o9CxQm30AOw5y5B9MBL0eb
   e2eFNdQt40tM0lPIU1xvHfm2iLm450w3oc8XrYDPXca4MNxxYEx49BAFC
   gxgrsD0x9DGcyJLcIfshokpcpRBp+5NH41pm47B13HUuPo0ZVB7CYm1/g
   htqtrKdW9o4ERd9euwLkHq9We0Goqcq+eXLtDspgX2AvrC7u8K+ao0a4l
   brGUrgovh9Mw/nN4LA/LTntSNpiuJaUvxvq4b1ROQNoCFR9ng0hFmWIS/
   g==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225493137"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:27:17 +0800
IronPort-SDR: cSYRuQ5yshc4X6ayJi6SxwyU6UolMMbIxRsFY2jZIkYZgR4sNCbMG1HW3ALZMw/z1wqR6NA+o6
 Olszlsd5b5Jis9m5GAqNx2NjXVPdlxPf5ER1rZi1Uo1tZLqjtXQ02IFA7K9moVtKSTvnpvll+f
 lisIi5CyERJ/aa/yxKQ+WXjtvzPHm2sj+vO29EUBXKnPxzUwN1AEckCHe/Z9K/2c1f788V2wQL
 +HHRBhPeVLQcnxD9vzztVpggBVdaNouxjCEm8GZanLj4imibR8T4u9ecv8ijhl/yzJ5n8aXPpb
 5NU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:45:06 -0800
IronPort-SDR: AGjjAcXm51QxJ/e0r8zxJ5EdWGOrq+wsUv4m0DdsHWIU2r9Rx2desUTj0Ja+A2AIDMvFq2E41M
 Hjunw1Slpn4X0Qv4JqVTmrVPqlB4XT1qdi6RnJhrMaYFRYMAUrZGFYv8473EveZ1fivmE7UnaC
 EA2CQpoBBCAEVuGFhEQRO/5VW35wHfoM6362o4/1Znc33WJkhDRX1N7nk/p9dYALlURC4abmyq
 vT/qnzxIfXGfWKDVP/2LGxwx42+LMDdYqXGWW3Mn4Mwap29wlLyam2pLfKwr6BUQi0UeRoT6ED
 PAY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:27:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs6s19Yhz1Rwt8
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:27:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673357236; x=1675949237; bh=/IW0E0zt4+oK414/Fn
        xtbs0u089eGYcEATsrMArum+s=; b=MK2CxU/ZEzcf1au7Z2bvfttpHm9I2cNPKw
        PX3BHXPNgZKZpgwSJeIfUy/QcQySlZifexjcEvrRK2iXLqDxIW/2GSGxjkeEz5XY
        Z7trTCPKm7odrhLWbXpE3MzZA3wmGP35cZKlyuynDg4rUxs2bZPTI9vIq+Bjv8By
        Pz76YAq4J9DRfduLwDSJQ6pQpA+MJuH4OxsF0ycUPSBrUzF4V3J7HhBzbMRnjwpF
        Ui1d5DboQzqvGp9K5HoWi7j6m970ox8JCBOjuR/LsyWkPjRPs9376oQqrdIPizSn
        VLoGec4/49c432j9S88hHcx2xedj+Tq2a4QwF1P80oIlRH7e4GOQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KL-fop2rc01L for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:27:16 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs6q5SHhz1RvTp;
        Tue, 10 Jan 2023 05:27:15 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 3/6] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Tue, 10 Jan 2023 22:27:07 +0900
Message-Id: <20230110132710.252015-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
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

