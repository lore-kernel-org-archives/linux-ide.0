Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910BAC19F2A
	for <linux-ide@archiver.kernel.org>; Thu, 11 Aug 2022 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiHKRcD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiHKRcC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2022 13:32:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B898A7CC
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2022 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660239121; x=1691775121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=38bQFI5lOdwxFrLh5gttsJkjb7M/hVCvCCIfSkw5xE8=;
  b=lrEB22aDqVWExCrlWCP1SwVTM8iF6lgCM8wRvDYSamHFsfA9f0LPU01T
   P4JvwxiYV9/abeek9zcKOB20vXhgyGEtIlF4sr0g+z2P+Dm6x5QARZ2h+
   aX/gVZ3vhYdDHaQKJlMBkRi30H3/O68E/FZZB3CjHd0vJQRGCXM9j1qrt
   AEhXSTzyCdujRZi1fxqEpUuMpqKl5drDGQHgAnBACVpzZJNdPvHZnxL6u
   8Mq7yw9vfOCLnetumRZytqXMgfjKpSrgPWZNP35WvWkM4U3UwXD+vZmOv
   zFiM4Mht5+7cp8oH56oKPHDBwXgm1CSYLDtslNhKUDE9Lr//dJ31gNaNX
   w==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654531200"; 
   d="scan'208";a="320568858"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 01:32:00 +0800
IronPort-SDR: /HEagm5Hnzq/4sMp/ECI1iuMoTpCZ9Z/mDQoYOzXFRBvXyRG+T5JYP+c71npK2pr+WpGJTUpLQ
 tyaG72PHHNDq8y7m9/T1yI8pNksYNrcBFh6vabI4gwN6whtBJB78NsNA/rxhGI3l8e0a12muOs
 to6E3vJa6ruquhgvKlvggcZh9Cf+LFWuDok63Sp5Fj2IpnrbYGXCMev/JszTB6zSaL+WgSzUKa
 PvFOiF/ryZDibbEoXOcZfYAYGX08y5hZ1+mf2365lRvcvGZcWISL7sYLHsH9gblKUSOSbVc5WT
 i3Mdkagx8O0+tmONH/6KVH3Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 09:47:33 -0700
IronPort-SDR: 4964PGNzdpZCVgpeO5jbNmwG1l8R9TY4L08Ld/dQhZsC1UAKXMPC0km8qm0gjfSAHt/ypO7cCU
 Xf3Zw0RQpoz7GVOiaAB0qLFXzB4TWMWYGsqhX6p+wrKqHlcFS+B1WXVQns4cRglRlz9SrT9EWW
 hFSSK/70QRFGuN49MwAudTHd75ivUrZGj19NSFbTSnLBy3qxx/S09LjchOb10RPEs6dM4qQzP9
 R3QWZUJ0A5Hmvj1Yxwoa/VNFd/enYvhbTivYTXRsVt5be2fLPi3gi8IksMaaVHJbDomg/KFpil
 zug=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 10:32:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M3YlM4tPRz1Rwnl
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2022 10:31:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1660239119;
         x=1662831120; bh=38bQFI5lOdwxFrLh5gttsJkjb7M/hVCvCCIfSkw5xE8=; b=
        s1HSabPby32+klgGa9rGjPp7tTkDW1fDvxPplKR5NdFc6EAzVaETtpm5RutBnNGE
        AWgSfDcOVayJ8BH9CurE6jZQQhJemzGdWr5I9UH2Qw+HCGVGSbTWk8QeD9IelzUs
        bvtVdokRNG80/TnUum3m52ZdcwrPXsRW+LC4hdlC1/m1ex1zShIvqGT6Uy8GythE
        EoFdEHGdtupW/+nrkBz9NzeNggYW3cNde9kXdibdQERGXFns4XN3Ra/T2sCkwKaC
        FnmdtAEMHSdF+glSbJ6+TEOORMM7lIS7aqP4jK41+M0uHVjVyp/QTje9+a58JfQz
        qxXjtLqxlYjNWqhs6ujrLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ox-Dky3WFk3V for <linux-ide@vger.kernel.org>;
        Thu, 11 Aug 2022 10:31:59 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M3YlL6F3mz1RtVk;
        Thu, 11 Aug 2022 10:31:58 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-eh: Add missing command name
Date:   Fri, 12 Aug 2022 02:31:57 +0900
Message-Id: <20220811173157.472395-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add the missing command name for ATA_CMD_NCQ_NON_DATA to
ata_get_cmd_name().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-eh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef4508d72c02..7c128c89b454 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2122,6 +2122,7 @@ const char *ata_get_cmd_name(u8 command)
 		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
 		{ ATA_CMD_FPDMA_READ,		"READ FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_WRITE,		"WRITE FPDMA QUEUED" },
+		{ ATA_CMD_NCQ_NON_DATA,		"NCQ NON-DATA" },
 		{ ATA_CMD_FPDMA_SEND,		"SEND FPDMA QUEUED" },
 		{ ATA_CMD_FPDMA_RECV,		"RECEIVE FPDMA QUEUED" },
 		{ ATA_CMD_PIO_READ,		"READ SECTOR(S)" },
--=20
2.37.1

