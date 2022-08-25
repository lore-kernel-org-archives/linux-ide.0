Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893BECAAA3
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiHYWp0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHYWpZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:45:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B30BB69A
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467523; x=1693003523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zV15AZjvjsxtaqZtgPmW9FQMInNNNeZIS0p3VFopqLQ=;
  b=bc8cQqpMTU5jThsSchmpAiHAJqLbYlAdzLC4cIw+HJQC0SAlq4je3S0u
   SduzYqnnwHxVzPNcTXIIPeabHPG+PvIqZAayLAr+Z813aPzATd4i1IKXx
   ilo4Cau8+hTHJzb6LyBam4SrVVH9EjezaRPZdwG6P7iAVT347GUSNGp/Q
   GajZtUrThl0bekAnNx3q+rbg4uadqYcks22+e3ox5PP/hDIavGMH0qYCZ
   2EN/IAIAZLiS/vYh6Xyf5gqATZqqlqp1Ib/eO4D2ZfMjF7I6HhMDRn3b5
   yuQicW0bsJtma9yHtOA5qE+lUk+TMsl2NvERYRsUPwlrGYqAb22HChNfG
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="313965432"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:45:22 +0800
IronPort-SDR: 9reUmSw/c9PUj4HWyRSJdCpERZEKvtZrAY6q4MPh/gLwNJANYJq9GggOl0qA3R6RqltR5pbYT5
 DQFiF0nB9JNnIoJQc9QLplcOzqW2b4Dxh54W9ARPbFnotcVG+G2TPpX7qPFkGWS7jThn/nzHFF
 xvv9Hz5oalDeMD0EMxP1mOgglY/RF10UgknzVciWIauVTM4LbdBKa9UMEJmQ8WfS5KglIkArP/
 kZ2Nel5/PxA96rV28lr4ubUXpJT25WDNbMMbuF+IjEikpvPOPU08N1cwUq1nPnDHbjXfdWAzyA
 o7DxZupVdEi4lG5KB8yuDGbJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:05:59 -0700
IronPort-SDR: AMcbt+qd8lStGr9ig/y2sH7Ai96FQ5Je5gWjWpJL4+1SJfmGiMxdJ5QppvCbfC6R8cCrUXsmVh
 3U2uQ3nBMcPr/VFgE05dFr+aAmWCnaC9ENw20FS6xKnSAveS1wjmrHs916g49UcbUtv7glzRID
 4+pNIroDcnB463qU7P0xS1C+CFirFi6Bd51RxB77Zjh9rKbdzoJlxOrh/qtbRzNXD5GEdIHO3J
 EsMzqwLGFv7vuJOOa6fjtk+oP9MjiRAudm287WwY0sPPdCM1uj+lOiG0wR4VL3bD4vMfU+9dMG
 ORw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:45:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDJ2V1qBXz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:45:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1661467521;
         x=1664059522; bh=zV15AZjvjsxtaqZtgPmW9FQMInNNNeZIS0p3VFopqLQ=; b=
        FhFDO1BembFnkvjIE2wd13Gssf3kRr5KCDGqwiq+QhSzc5jz6e+e6biZMp1FmQeg
        24rYNVDf+DqAcY/bKucoP9sQT/hznoGLVny32KO4nPCBLPOd0VdUWWdQ7iidbuzl
        WlYRy9pYGqNL1acWktkBiVPPALolZ8+vDkt5stY1YT6GkViHoR5XlNCKezUJV9t6
        mY3RZo8T0WYelRup2JMZuKibWExfAlJ7cNn8N2x9yqr4kjtHP1Vrgy3phkNcvCfw
        OGVtsFLTSfpuhroSUyWODjE9VCvRkAIeqkyoRP8kXRcodDzPDH5KquBxmykZpoUu
        YGCctTrfZZ7GqViXgcyHZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fNTMQV4pRfmG for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:45:21 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDJ2T3cJZz1RtVk;
        Thu, 25 Aug 2022 15:45:21 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-core: Simplify ata_dev_set_xfermode()
Date:   Fri, 26 Aug 2022 07:45:19 +0900
Message-Id: <20220825224519.369685-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The err_mask variable is not useful. Remove it.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0b62fa14a74c..d0242c75aac5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4295,7 +4295,6 @@ static void ata_dev_xfermask(struct ata_device *dev=
)
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
-	unsigned int err_mask;
=20
 	/* set up set-features taskfile */
 	ata_dev_dbg(dev, "set features - xfer mode\n");
@@ -4317,10 +4316,11 @@ static unsigned int ata_dev_set_xfermode(struct a=
ta_device *dev)
 	else /* In the ancient relic department - skip all of this */
 		return 0;
=20
-	/* On some disks, this command causes spin-up, so we need longer timeou=
t */
-	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000=
);
-
-	return err_mask;
+	/*
+	 * On some disks, this command causes spin-up, so we need longer
+	 * timeout.
+	 */
+	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 15000);
 }
=20
 /**
--=20
2.37.2

