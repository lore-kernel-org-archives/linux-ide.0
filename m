Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79DC54EBE
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjAJNPb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbjAJNPO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:15:14 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3049147
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356513; x=1704892513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2Z83dzCeZHKddXeuTUmcn0ovi37DfKGzvD49wy2LNI=;
  b=Hog0Q+ua4AqtaoPi3W23HLxH+gN24oajlCWzuFp/sHzOqSoEJ7NSsJRA
   QBz7o3JmynuAa0gdCE2zfI9qye++roZ/mtmZZoviY8Fc0sC5aYBoAeAMH
   sCDna7FszcZ/xTRqlqeELqA52xLDfyz/dvkDWn/xc6jfHB0U3ADM8A6/c
   jPYwylkhvyYM75CmSJXBBxTN4tQBpATHZS9G3dRe+g23+E8H4RvxF56sn
   39XCkNZE48e/AV+AO12TCmbQ7EM+ZvxAetEHciAo1B5+lbziIz34tg33V
   gwSUQoXHdZ0xTKfMQPohpceev1WeMOass2QooT/839MdMQMiMMo6BdAfj
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225492653"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:13 +0800
IronPort-SDR: 3TaAtP5y9dTo66YOllta9P2goLjvW4S63wO1T9FO2JibqiCJuDr8P6aRDrGhVAIbhJ8UZrhYOl
 OFHhUCLiTtPeLNWfIbyFZYzp91DavbsKH/Zni8cCjKPfEzfVCln2V02dvb24VruATAJTakQPgd
 QFuHI+We0eyr1/Uh7hAPbO9+1NtwWJN7Oy6y9qY2yX11ibACpsbhpfQ+rAIr2HZoGHa8I/7kNC
 gWB43e6oeWTwmSaHStLTDynAYAvAZ3HFT5aEKMOsazAgV2tvLXMOuPaD8et7vbQOtZsSUnPEj5
 vX8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:33:02 -0800
IronPort-SDR: jD6usvTQS9FmvaQpQmO+MKtX6aa4yBcX1wG76XIRGJMtYUvmU2JKDzwoseDaJBxKIJSUfvZerb
 mp4POFYTJMt5r4lJqgUtt+Zojv5HZcpgdYYWvZKtdLZzi6TTHpFxzd6DwsWCBRHAR8V5jAs6xQ
 FMbzmzKBNCcQfCtAg1CukeSFeo3Ow/ZzwB7iSabdeaAUOq7WXoiDsvY+u/GaG8IMeyU5HEdKqJ
 W1iTKmORLHuUWoglPfl+0UNJyVx0S7it/REeqkaERxySds5MRpDkd/p6mE8W9mLbvMtsp1o1k7
 A00=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrx2fmXz1Rwrq
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356512; x=1675948513; bh=R2Z83dzCeZHKddXeuT
        Umcn0ovi37DfKGzvD49wy2LNI=; b=VX2Kvw4AbdRR1YuzyfHvgUG8L/5D6rCZ5r
        gvRN4heP8JVI/VSlOxxhR28MzfWxtz9RI6LbsJdGkr5u/i6wdvx6WOBAE2Fi4spG
        zqQ2l6sqKPjV/qn0XWkZ+J5MFBCdeQo4KDJ3z637hIthT+Qu3l2cBm2ZXIpnXwBb
        hO1Eb08xCsoIfnzo6WkoHRHvRV0X6xw4CaZSdP/7qFz6JgYXymR6ANp6Mx1ShNNG
        ZhsGDjAFE/DeATfGDYTPmDEXmQk/wkUsWOKW0Dl9uQwFfG2KgW2tfGw/ymd8ibJG
        blzMeEnDrOcEYAhdl5QWgvr+U3BKHtTIVnxLehs2mX/xmWV0mtPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lI7itkPfpXph for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:12 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrv6VDdz1RvLy;
        Tue, 10 Jan 2023 05:15:11 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 6/6] ata: libata: blacklist FUA support for known buggy drives
Date:   Tue, 10 Jan 2023 22:15:03 +0900
Message-Id: <20230110131503.251712-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thread [1] reported back in 2012 problems with enabling FUA for 3
different drives. Add these drives to ata_device_blacklist[] to mark
them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
problems on old systems, the model number for the three new entries
are defined as to widely match all drives in the same product line.

[1]: https://lore.kernel.org/lkml/CA+6av4=3Duxu_q5U_46HtpUt=3DFSgbh3pZuAE=
Y54J5_xK=3DMKWq-YQ@mail.gmail.com/

Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ac88376f095a..36c1aca310e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4133,6 +4133,9 @@ static const struct ata_blacklist_entry ata_device_=
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
2.39.0

