Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48BECAAA3
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiHYWjR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiHYWjQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:39:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9056C650B
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467155; x=1693003155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AsUh0dDFE1lKke/1ed+V0IXQKOoZ7OJAR9Pki2Jmxxo=;
  b=m+1GrJZXWQK2TnvjQevIf/WDpD2Dw8IziTuCmAk+zIZ9h6+Ffv3Gczjj
   RPaUODjcvr+FK3Gf1gY6RPHERK4bT3ebtJtotb/n8LZ6Lu5ncyhPCIodh
   bPv9DUwXqwX9zykA2987o2qNB9LxsuDOfwc4NodrAOngBpg0HAk+nM9T/
   H54p7H0UP8UWh6dcCUBCD1gSgCt+eysjUVN2vahydmC+YqvPrjI6YPnv5
   tYxlzv9udTFjhBFKqBe3uw8HhNydEbDzfzxACfq4nXaXtoZOfMzUHVR+2
   5RI0jezUK4z7KSRAFyPwyX0bNvOGypJZlDOSTH6tGBzsI7vWr1vfj1e90
   g==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="210185435"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:39:14 +0800
IronPort-SDR: LTI+4avZ3gh4k3871269pcnJt4SUqvABiYTceDgpINcYsdv5fKs50WFpriTmUJfrK3RCv0rsY/
 rwy4Im6EkFbQ9iH75QcZL7iTdR4zLQrVF5DQTxxlgkV12v1wko6WZ95JszW99mViSJLM5wR9X6
 Y8bDhM5VFv0IK4kGEV4cwaxwVQP4EK8N00KfeaBQ+acr5P2ML/FOV+pNRsILe9Sm+KIN96ErW0
 STiGxTeGYE+iQJeUHmrP49rLpG/cd76/EoWAq6/AhUP9mnP8Y6cI/oAKXnOtGUgVawLPJXMIIy
 POpswYpbUpAOFqsSO8F7od43
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 14:59:51 -0700
IronPort-SDR: MAETJ6bRimj0XL57KXkiq1UAPYBg/AGyP32Q+2QMsvO+P6agB2s1WEn5RqTOtdJUmdqg1BAf0u
 vT0FhgR6owUpP39vMu8KIdmJ9s3x6r6rnq0R+m0ACWJCKhe4XQ9nlSpc3vMlMPOEzEAg5AKcqL
 uDLdHpY+Ti1mZyY0C3d96S7KNstMRLX7LBLhnomKg/PTubzQNfCuFfDbZkzaVsjOyRMBBNbfdE
 7UoEmpWWGn8NuM2H6YbnsE8636BG2OQASObrfV8Iu5dtm56F9saTwRxySAbGg951Jkx+ILAy1E
 P7U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:39:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDHvQ5ZpBz1Rwnl
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:39:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1661467154;
         x=1664059155; bh=AsUh0dDFE1lKke/1ed+V0IXQKOoZ7OJAR9Pki2Jmxxo=; b=
        LCndEoMhXz4BITpjVkfTFYoAMMIZhp0kjQc5uOrb/I/y2RjoknVf69jn2cxC8THL
        0CYWNyc0gP0eV9AnTzfjJdiXh3Zkglt3r2XzyM96YOdMqFg3ZFJMG7sImL5kL7+j
        SvXjGles5bKcxaJOyOflfM0Wodj446io0RF+Wew0/ASnNFJbiZQQhow3fMlCpR/f
        LjHhrmUvyoHeQ8+y2/i94YF6DYYXOjnOev+Dx9dv3zSTRW/KNog7/C/aI2Vro+fS
        x2akkJe5ObkcQb9BWv3p2emuHtrU/hiwXg4tIIOOymujkokGD4NdEGyTe9geKqXj
        lnn9VMMxLXvr2FeanBPGhQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C0B2nyrB6uT4 for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:39:14 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDHvQ0TkWz1RtVk;
        Thu, 25 Aug 2022 15:39:13 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-scsi: Improve ata_scsiop_maint_in()
Date:   Fri, 26 Aug 2022 07:39:12 +0900
Message-Id: <20220825223912.355011-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Allow translation of REPORT_SUPPORTED_OPERATION_CODES commands using
the command format 0x3, that is, checking support for commands that are
identified using an opcode and a service action.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f3c64e796423..99ebd7bf3a9c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3252,11 +3252,12 @@ static unsigned int ata_scsiop_maint_in(struct at=
a_scsi_args *args, u8 *rbuf)
 	u8 supported =3D 0;
 	unsigned int err =3D 0;
=20
-	if (cdb[2] !=3D 1) {
+	if (cdb[2] !=3D 1 && cdb[2] !=3D 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
 		err =3D 2;
 		goto out;
 	}
+
 	switch (cdb[3]) {
 	case INQUIRY:
 	case MODE_SENSE:
--=20
2.37.2

