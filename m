Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A304C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 12:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbiDGMkA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiDGMjz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 08:39:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B70258447
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649335075; x=1680871075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHFecJtTnXKctSENm8ITt50lChhW2egFo1kg2CIowKg=;
  b=OxZQS5V1OtjEkswFsrFbt4YyOjlRcmvNyq72kOIA87eadKYqd+B88z0S
   hdx4EVsTJuM+OzHzfDk2tEfqc9Ud3jPIVJwVN+Aa9C7KwaqyKXbApSVyE
   eg3zW0t+xQZeP1HX/lJ7FERxmrJNu2RNU7LH74Y/AayBAQQ1li8uSHA/0
   8eIO6M5MYgY+BFTzQ90MCL5CZclCf5m/fcqqPNlKsShBkYuqEC9kTw483
   NLqKky39+MD4+FUI7qayNTw4PFQurtwBwyKxSA/P5fhvWQnFmRlpyQL5s
   DzsK8wPa+LH4wrq7PsSEZ6e3TXdD4UYePg3qpYvg4O5ZuSdKQu3Q+Mnq+
   w==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643644800"; 
   d="scan'208";a="301515562"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 20:37:55 +0800
IronPort-SDR: MpJNC3GCNMdjH6NGDJeHxbiw7JPXfFlLe/aiCECdaJL+YJeDwNwx/ZXhzkMATsVXuydOjlIfas
 3XBQzv9J3XpkXgJGUL7/qR8oljrm8YwjvIj9fvW4zxuM30pRJ9eFrwsDmogUvwPKFEPSbeOd7u
 1GCHyg0U3xcjxzLdim4lYN4N4HHJvHM78Za4Mmmdx253EkdyJfs8sd3PyN1R+pkNh3oLorEvjb
 nZUCmgDEOWHXpTP36DkONV4uXyFry3ZxTdAyrMkhDz3IDPdv2u81wwqtOrWKPkO9XSe/fXZG3D
 bQWdxEkoHFmvmBV0+CoxnOQR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:09:25 -0700
IronPort-SDR: ophSdIudX2XsUg+BNCtoc17x8XfNGAu9XH9A+o7cH/4E42DpGqP2oeSMql37WSw5pv1g2NjACe
 jGJdpzMN/HJAlRQS+1GG08wPbAXH4kzOekqOG/XbGJeMqhOp/BX4CLeYPwFwRzyUa4vqcEkHGV
 KZsVLPocOzuNONVp9PzNZ7Or/AOi7lVw0MvmiFUDgq2Y0xVE92s/5orNNZdg7+E//T3dLBc7HC
 2IwzmOJXPSJsdXFuZ/kEDJUCCbDptXLhPY8DyzTmUdZFgCAiSL5jLZNIHcSX6Rj0nOO+yQRmqT
 t/M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:37:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KZ1BC3403z1SVnx
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1649335075; x=1651927076; bh=AHFecJtTnXKctSENm8
        ITt50lChhW2egFo1kg2CIowKg=; b=fLIQArLY9PONgyIuIa7283yM1hIr/+dj+y
        ANkgk7RzwBt2scHov8XFtPtb6L2CrqXhxMTXlK7Dou8s9bZMhZtGe8PvuWc36Q4v
        yOEt5QQ2xgPJSqz0wravc8yFrdm7RR2dX4ev25eJEX1s3cop9HNZxDQTK5FEODcf
        sTjIgNxw4n221KSYJqHr2cwcr3+gp55bIMqx+GmoMBGy78OZXN8sUf8diAX0yxfq
        nYDArikXcUgKEIKb4uPVMaKZQB6crw+vmrFOkGwPD684vUqMN3o+yK9sHn4nbbVv
        rSVhK7j2gD+H/s8txW+u7wNBwkSqX2ciOLqexE943/5txoLUit3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fhlGIUkvxe5N for <linux-ide@vger.kernel.org>;
        Thu,  7 Apr 2022 05:37:55 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KZ1BB2StMz1Rvlx;
        Thu,  7 Apr 2022 05:37:54 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 4/5] ata: libata-core: Allow forcing most horkage flags
Date:   Thu,  7 Apr 2022 21:37:47 +0900
Message-Id: <20220407123748.1170212-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

To facilitate debugging of drive issues in the field without kernel
changes (e.g. temporary test patches), add an entry for most horkage
flags in the force_tbl array to allow controlling these horkage
settings with the libata.force kernel boot parameter.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 75856f4210d7..121cb55a219a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6230,9 +6230,27 @@ static const struct ata_force_param force_tbl[] __=
initconst =3D {
 	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
 	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
=20
-	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
+	force_horkage_onoff(trim,	ATA_HORKAGE_NOTRIM),
+	force_horkage_onoff(trim_zero,	ATA_HORKAGE_ZERO_AFTER_TRIM),
+	force_horkage_on(max_trim_128m, ATA_HORKAGE_MAX_TRIM_128M),
+
+	force_horkage_onoff(dma,	ATA_HORKAGE_NODMA),
 	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
-	force_horkage_on(disable,	ATA_HORKAGE_DISABLE)
+	force_horkage_on(atapi_mod16_dma, ATA_HORKAGE_ATAPI_MOD16_DMA),
+
+	force_horkage_onoff(dma_log,	ATA_HORKAGE_NO_DMA_LOG),
+	force_horkage_onoff(id_dev_log,	ATA_HORKAGE_NO_ID_DEV_LOG),
+	force_horkage_onoff(log_dir,	ATA_HORKAGE_NO_LOG_DIR),
+
+	force_horkage_on(max_sec_128,	ATA_HORKAGE_MAX_SEC_128),
+	force_horkage_on(max_sec_1024,	ATA_HORKAGE_MAX_SEC_1024),
+	force_horkage_on(max_sec_lba48,	ATA_HORKAGE_MAX_SEC_LBA48),
+
+	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
+	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
+	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
+
+	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),
 };
=20
 static int __init ata_parse_force_one(char **cur,
--=20
2.35.1

