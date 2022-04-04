Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE50C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  4 Apr 2022 00:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbiDDAxo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Apr 2022 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiDDAxo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Apr 2022 20:53:44 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE42DA9C
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 17:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649033508; x=1680569508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nu6Oqa1GcXpv9HKR6Vbb24j7pGS3dPSH3VlGRVpIVOA=;
  b=PBmYfMxtVI9sFF6+TNOdgEXwcoY1D1uzV2UkQecAhZApQjkJKrmIRS88
   bymJ18vST3q0LAG6wcPinaPTy2oFzQCUiygX8VARELobHtEfQ8jGXSeg+
   XzOJK1WQ0rZxWXlbOqhni1WJRCPRXXzyg8m7cO4gpHvZpYFIpWhK3Ynj3
   sVfUNj+rCxd6cjrX+DU8o491l1j4NIenb1r3Ig9K6NZQwz+BYu6FlsF4q
   c7L/GEP+RDrWwy3kpxFBQ1Wadmxzl1DBOJiYP9fDbJtS/OzB4e7kjq4aW
   p8jyBL7M6muyOzuBKDIk3Et3GOY5TBiUYSaqeqzw68UW/+ENmYBcWyGQz
   A==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="196981484"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 08:51:47 +0800
IronPort-SDR: P2ogonXcp/sF2YGuDvyH9KOnHjXy+yDKUYfl/+R92P/sEJwHr9uws0zWCQ4/Ju4yna4uHEKEMC
 BJaQ7vL8RKBnB/QTGxzqDdMwAypO8jHTWcbvuNTGMn3rBRBxpjveIYk9BprXKoucxUalVhKKw8
 nMZCE0Jw4F8Iy0umZaag0l3w2TzSKdUOxZiIsaVjDTfI/2mxti93/IxhvQ6V94qXTtZXr8Fizn
 RX1Ui7GkabG0TSeLiP79ecwE0n5693zjkP/mh0kIjZBGJK+WQb6KReBXBzGUvZoCK3LBVHEw1f
 hbe4bCdSaP4WOsTOzO776Iv4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 17:23:23 -0700
IronPort-SDR: K7MQwzeBXtGpyxCSn8pR1BIDqfEqmaV74Oxups2J2kZAY/vrr+3QujAm8nnwJLkurxNKFXy6c0
 BWHVf0bIFuYN27Cc64UE6iIXoWWVIoKGtUvykwQqcxolLmktTskLBEvQLc/6ILzm4BfFTdN4oM
 STxhyfhIqgoOrUoAM7KT7f2CnwkTuJi2O36712dFMq9qP2DC/wxHpj+RAe6XRiCpXhylYEWR3l
 fI96566TAKJJwwc0JpALZ/Tkr596inQDBzpKbCuqCbzM3iuwfpM6L6e5C1AonOF0tSPde5rwcw
 4U0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 17:51:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KWsfq60ndz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 17:51:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1649033507;
         x=1651625508; bh=Nu6Oqa1GcXpv9HKR6Vbb24j7pGS3dPSH3VlGRVpIVOA=; b=
        LCfdaXMabGG4KkIZpcPQVcdTbY92BuiKSn7xYEpStWEvRBZNfBSu7CiWPymYx9bG
        XeNkiyLaG1XhLS3h1pAxAXFVfalMO7LBxUKJHuzQ6U99EyfXic1gE9JqyV3N2Z6o
        cEhh0WkbqCH8KZXKxjolVTMFAz7Axw1yi4Rt5RWfn2JLKr1eQNOjCExWy5L0gLXD
        THDZgc9HjpVdfxMqpGn4AfbTljwzRC7xp0ezKBfCMOVpMogyJHvZ06YqF+EofGh0
        w6xQ7tCuv7dunj5UGBJs2rYCXaJ4AJ4W37LxOCCwOWUdgIzWSYE5HT01FbC8XN2w
        iLzSICd7kWhcdg9V6U8i8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tqdo1VFV6lPk for <linux-ide@vger.kernel.org>;
        Sun,  3 Apr 2022 17:51:47 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KWsfp6PsCz1Rvlx;
        Sun,  3 Apr 2022 17:51:46 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-sff: Fix compilation warning in ata_sff_lost_interrupt()
Date:   Mon,  4 Apr 2022 09:51:45 +0900
Message-Id: <20220404005145.209422-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When returning false, ata_sff_altstatus() does not return any status
value, resulting in a compilation warning in ata_sff_lost_interrupt()
("uninitialized symbol 'status'"). Fix this by initializing the local
variable "status" to 0.

Fixes: 03c0e84f9c1e ("ata: libata-sff: refactor ata_sff_altstatus()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-sff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b3be7a8f5bea..b1666adc1c3a 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1634,7 +1634,7 @@ EXPORT_SYMBOL_GPL(ata_sff_interrupt);
=20
 void ata_sff_lost_interrupt(struct ata_port *ap)
 {
-	u8 status;
+	u8 status =3D 0;
 	struct ata_queued_cmd *qc;
=20
 	/* Only one outstanding command per SFF channel */
--=20
2.35.1

