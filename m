Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C58C38A2D
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 07:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJXH0X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJXH0V (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 03:26:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBAA5FF42
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666596377; x=1698132377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z2iaB0HrcPFaC7ZRKJ1Fli9urLDjZezhPswD1Dio6C4=;
  b=km4JlM27qErgQSPIXpbIybwL/WFVJDoX+UZWFHH7A3kYxvTcVRAIltzG
   C6YufgL80ACHjVFSct7BFnbv54tSa+9DVANhdVu2YvoHf5pVZFeETnuGk
   szzYcx6Do/P9aJuy03FxYM1+dfB/03wiplzUR2CvUiN7dj/hCkWzgDMhc
   vjMDSpvlAbQwfdk8u2vqmAvQmAc7opDLKX87tNWl9zBIHqxlh6RMHijSs
   Z9u84El3Q8I4qoRbRmmYhuU/otX9fulIncpqmlv5/SciEMsmCF1j5aFeo
   vp0WtUx0MfrRRNFp5QA+Pynd9F5LyYWoWzpfc7cU1fgm06tJNHfiOT11N
   A==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="318901547"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 15:26:14 +0800
IronPort-SDR: xCt4aYy4E6P8FFVE5kbRyZrE9JZswQBlTxLC/yBA6RgihvA2tZT0tGjkhjIqEVdeiNcPF5utpu
 6qDMuC1MItRnZM1IF02CxKvhHhfUbhD2E5OoNnCMHklphJdTMsbu/bBxQAzVDWtz1sClJzdzJe
 goW4Wm85T/0YJryOgZk7C44P6EEAIXsuCrziGLvJNCgwd1moWJi+6LIJuoergymZOJYGtlX4dF
 8aK7eb6BKRUSYG9iQeJ2DcjLHxzNLlmdou9GWGYjVt/4eMaUKjrLToD43KnZTc2GVU+yMigjLj
 zpsZIAYFlW4xW3SqFQKfW+wT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 23:39:58 -0700
IronPort-SDR: zOAf3bUnIHQdfKCwWHAtqPoYDquAHFsbadsL/IYesuFiz4d5XFVsto9MfLsRqndOLR0K7AGcPp
 Png42FxhYqP0thD25ZlRM8nFWKn23+7Ew1EvS8Sy3adrtgCl9ygoIxiCzrcwiH0upp/zw05mZ0
 KM9wOYpGq/bHH9PHrZQdCnrUNyCDZ+E48G7AExH4Mhz80FLMOVeuUjmZuiv3GXJq7P5hxOEOCN
 raivYbNtpHtEMRdJKtnSaoCofUM/bG7g0fxlSRnerMhHXAIT3+cwwuV3QPfgP9oyfdqb2TGINS
 7BQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 00:26:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MwmpG0r1cz1Rwt8
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 00:26:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666596373; x=1669188374; bh=Z2iaB0HrcPFaC7ZRKJ
        1Fli9urLDjZezhPswD1Dio6C4=; b=IEJajYXjAQOr23Fx+KQ/4f7Bwg+2OC7C/M
        +cHJYmL8OQKqAX+2J+yNc8YmGHmsiBfeFQAJREKx+S2XqDjyT+Zi/XoaiEBMimMo
        weDoVhd66SxjwVEx66UqC0WLothjAOarWtTiyomD/iaLqsrZ46FJPhAHvGQdWhyM
        nysuum40f5nNRW4qUyl8b6orjPi6BUsxH9epx9IG4Zd8l5ZN5+slCCM/c5rbPAIF
        YTEkLK0EOpxCiuMGo6662Ard0zkWCclAhiauk4J9lt6yNHf9YaDirsi8SzU0ktEu
        K99h/DtJzDmI7Z2vU37/avTzEzhQTyDSu7kv6pUeT8i8ydHoQRqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2DpmAiS6p0gn for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 00:26:13 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MwmpF08QRz1RvLy;
        Mon, 24 Oct 2022 00:26:12 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 2/3] ata: libata: blacklist FUA support for known buggy drives
Date:   Mon, 24 Oct 2022 16:26:08 +0900
Message-Id: <20221024072609.346502-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thread [1] reported back in 2012 problems with enabling FUA for 3
different drives. Add these drives to ata_device_blacklist[] to mark
them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
rpoblems on old systems, the model number for the three new entries
are defined as to widely match all drives in the same product line.

[1]: https://lore.kernel.org/lkml/CA+6av4=3Duxu_q5U_46HtpUt=3DFSgbh3pZuAE=
Y54J5_xK=3DMKWq-YQ@mail.gmail.com/

Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6008f7ed1c42..27aec8e63a8c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4128,6 +4128,9 @@ static const struct ata_blacklist_entry ata_device_=
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
2.37.3

