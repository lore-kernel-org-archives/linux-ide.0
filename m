Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB7C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 00:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKGAub (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKGAua (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 19:50:30 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677AFBF5C
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667782228; x=1699318228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xz6ycfIfidoOOGiPhXlSF5Bv4e0fjijWd4+tMRv7Bmo=;
  b=OYsp32JXca9fp48VsKHZQwxZkgruuQvNcmhiUKUspVPtIoU9XW9PiezA
   7LRqVU56uziCqi1HaMl40MqXjS938y9yec/bHUIcTRx3BUzl3Yn7LHp3w
   HsyY0tuKQq6oIg6j7YBX30rAdQt1zIzzGXCq1Rge2xxEwH/6UuMP7SGFF
   YSMy97yENFeNtdiUP4N59H1zonyg7VnvF9XybptV0sqtQCYqxY5Z/M73M
   DP9gSmFP31PelTsHbCNceMM8/SokReEIMzwyQJ5jpPonHy+fGnqhMnSVl
   ozWbX/Q2HXxFFTNONGm4ptwii8edD79ox1gaRhLeUDn/rG50x6y2ldmV6
   g==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215958473"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 08:50:28 +0800
IronPort-SDR: b7f5bs1sNwKzbrv4ZVmkE1eliJoXgOgKr6Ax8e6fmM+8lbp0hK9rWAUd/8hNc0Xqcw6a5fIR/A
 hWp2bL2Sw4ekvL/0qk2Ra0aXCVYeeKnIuwaq1KHsKQCW+Yj2/felcuVHuDtRHgBNzcm/Q920bZ
 X9UVf1B8bmp+XMkr3Kdfd32K1lHxNwNj7C8OuQpM2xDLWSSZqxh0chlB/0za1dZpc6KDle5pgB
 xZj9hgaOcuoLLKen+bX1D610WesMGALgYlJkJq4pkCcZMDR3JANwLijsDN4xeX2suoKOpLX0QR
 H7k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:09:35 -0800
IronPort-SDR: Z+0fDV3fDQjzCqx+JMZPhopo009CpEwEen+rPiGkeL6ncuAwtli7r5f38A8XutGUGt3PpkrX6R
 eR+PX1Ko80faUcmKFtKyhPDLpf5P48ZgB1UyTTDrOxlKu11O3/7cFoAPiQ4G7Ax9WXdnWe6COE
 7H72PTYdKrwOwdVcLi0DX9N+WpLx2NUNU0siLixhOyNzGT+mBJS+tH/+exNXobwFwtbJPlJav7
 +08rPyfOkBZtx+lNxe+LiXcoc14UKGR+6MM/zVHWtNc1Xe+JdJOtQbmqAx2x/5bs2LO/4Q2bBM
 2QM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:50:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5CM80T8Tz1RvTr
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667782227; x=1670374228; bh=xz6ycfIfidoOOGiPhX
        lSF5Bv4e0fjijWd4+tMRv7Bmo=; b=DMDdbM5qMjqlcRYkIThNQ0G42Yj5EhNkP/
        t66xUS0rLnL5c/wrS/hLz6uhfnrk2PR54dkWGacki5FNvh68hslhJTiGbA7wXAxh
        umLFWA5QYVXQzzF/rOO99GKwIo7RUIz0nqoABdgI35yIUihR8pLNY8uwiXNaAwp4
        Uw1yTpNLXOATrgRJFAjnTts+TEyIjaWhaHbCPpXzBJoEF04oTavOUVXUPWcW6QEX
        MW6EcgMq6nRidNgq0YiE19qrVvjIPYyOyrBthDa27TL0lzsKRH+dU9YERE9qSoxO
        ZI9924g7JxpBzFSkHHaKFluk5QRcZtuOdT59TmJb50hhaBzdET6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OE5JdmXjhx7O for <linux-ide@vger.kernel.org>;
        Sun,  6 Nov 2022 16:50:27 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5CM63qm7z1RvTp;
        Sun,  6 Nov 2022 16:50:26 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Mon,  7 Nov 2022 09:50:17 +0900
Message-Id: <20221107005021.1327692-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
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

