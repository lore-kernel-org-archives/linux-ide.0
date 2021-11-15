Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516C7C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 06:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F3B61C48
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 06:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKOGJA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:09:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15528 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhKOGI5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 01:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636956362; x=1668492362;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fqoJjMZo1F/r6dIVMukKGKUdqw/okRPerU0FyVf9g04=;
  b=Xtjd1Pd6psJattC8MDQD9Q0TasDzzzjlEzzqrnDU1hiOXxPqY+v8JRGN
   lcITbPeIQTQ+iIPTo4lnbdrDuBHqZ45XrUr0KyqgdQFdLM99Unk+VLhUI
   A0xGLtex+DwkIM5ArOz/cDjANLSZmaD1Ud9xqbCLuyANYawpjGZTCWrQs
   VDunhQc798oRj8ya/GVq37U74A0Tskps4Zy0hpNPTzzfESluOLS1BY1Xg
   k+O/6WRuhxBT/hV2BOBFVG9V+gbWHhHPYkzXgUNDEynMh1Znw0UTmnnVr
   UMUa9zgzw94fSXFC2VZmx9MvXzr19rYus37zojopUF3lq+/nOiP0yh9ib
   A==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="297418912"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 14:06:02 +0800
IronPort-SDR: KGxgwk/Ipzdt+gP9T0DoKwIqsqpZc7DT4AnLzIpcMI7jRN5lxNNQYKaXlfPVdVWB/Yr/WJ6ljI
 MSf8hLcop4Z5oFL+hlODy5yKWmzBijGUTvRSiAx3ScEtrwC8PpBh3eutV4bjrJZMH5uiTRD8gJ
 HLWjkV7FfDAubaYh1XGl+34qFyEr9FgREcL+r6ZWQAGsGLz9AswGIVKaBJqXNaq1KSOGPkj/7f
 UBJABVAPV58oaVUnCxD2ufD4L1oedmTnAfNDfxR2mFXWIQa9wr1cayrUu30S98ct3fD6rbIYsq
 b/S/+FO8vpgijuHTa40s9HAc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 21:39:34 -0800
IronPort-SDR: NUpKViDCl/6tTuN00Fbb/dvKhO74u0QPkunXR49T6JL6yRxmedSUQzrQntA06nQ08JLabP6sEs
 9LG1aUn+SwEeW8uFa5UX9Ns8Xlp1Xb5b0/Tyic0d9iSnnMkOci4q6rDQsyoJrfVN/klCsaKgDb
 GiGvbDbjO4Qevp4mmTarAsSsXg9/alJQd4Qh80lImlizTNnNpQXkJ8MkpM75C0bZJ7KtNwXq8I
 cubEHej2atjNCtH1scHQAPTHpmcWgjVVtaAkwiaurEGzUGQkEGb6jfKsajBALVN98lgiOh/cEM
 U+M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:06:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HszG20b80z1RtVn
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2021 22:06:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1636956361; x=1639548362; bh=fqoJjMZo1F/r6dIVMu
        kKGKUdqw/okRPerU0FyVf9g04=; b=ef3KTYvEBeTV66lzZgMnChUdZqb/d7JE+i
        qTTvCs7Z1MTD81JFETgA+D8v8guNQnChe+JZoGlkZ/lyKvaCWmVte6ua7yeSMOHd
        rTXpdp9NTgXUc8WpZoScFEK5/ctIKnA1GuAW6LgJmtBBSHVsb8Jrt/i2K9DG62pi
        bbbKnr0cuCgmP6ckFarhjqqU/JZYtJ7jpO/ooJWHU0ITE/bJsHhOCmH2VJx0HxiV
        5yLbbahTtJquy1vNMXSLozEANUTcYWZCz7+UFFWPR7vxcOp3IqwUULI9QCT9bWVj
        xfTGgyPBDmki6uBPOv1sCvuUzqRrTY/96apdDJP2wl+o3iUzxpxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NT5Sb3sfBuG9 for <linux-ide@vger.kernel.org>;
        Sun, 14 Nov 2021 22:06:01 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HszG134lqz1RtVm
        for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2021 22:06:01 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 1/2] libata: core: improve ata_read_log_page() error message
Date:   Mon, 15 Nov 2021 15:05:58 +0900
Message-Id: <20211115060559.232835-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211115060559.232835-1-damien.lemoal@opensource.wdc.com>
References: <20211115060559.232835-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

If ata_read_log_page() fails to read a log page, the ata_dev_err() error
message only print the page number, omitting the log number. In case of
error, facilitate debugging by also printing the log number.

Cc: stable@kernel.org # 5.15
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8a0ccb190d76..edaedcd82630 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2031,8 +2031,9 @@ unsigned int ata_read_log_page(struct ata_device *d=
ev, u8 log,
 			dev->horkage |=3D ATA_HORKAGE_NO_DMA_LOG;
 			goto retry;
 		}
-		ata_dev_err(dev, "Read log page 0x%02x failed, Emask 0x%x\n",
-			    (unsigned int)page, err_mask);
+		ata_dev_err(dev,
+			    "Read log 0x%02x page 0x%02x failed, Emask 0x%x\n",
+			    (unsigned int)log, (unsigned int)page, err_mask);
 	}
=20
 	return err_mask;
--=20
2.31.1

