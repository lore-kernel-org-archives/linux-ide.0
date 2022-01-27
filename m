Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8407FC433FE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 07:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiA0H3Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:29:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23782 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiA0H3X (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 02:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643268563; x=1674804563;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SfgOOidNN1sUEB6J+HVJXi95BK6rb46fh1tlETej//Q=;
  b=dCXjtn1kNMX+j+z24rn2hgM1a2WCfTsiWWxEwheG5Ds2tx+U0+vAByfZ
   7jUT9Zo9tuxTz+mCGcuKFDVANdENIIvB2nUZ2gEGuQFXUYR1ou7Qn5w+m
   v1UbasPkrnIvsedWIUgxttLvtSadkM4Vi8/40IjKtwHI4tjcvYWTMOhCe
   K30ILnyr6rfZrmDJKM52tD5QcTv0AW09mjHfoiRhDy8rNH359anqz8aE7
   M1lCgTvJN1VUSzEywX4/HZHzJ2mhLF9XXI9hXSxc9HdbO1T82sGCeB7Vi
   vUA/ymlmu3BD3qc4+7IXMGwrc+to9nHqA8MkY6CR/pIhpcGVAD0jvyMoO
   A==;
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="295583696"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 15:29:23 +0800
IronPort-SDR: 6ecFKShPcZXzSb8PYW6/TT6nxQyww8kpO8Ym1g4ADRrQWpxMWiJOqrsDAeh/a6OOGrYfHN0VEC
 Py8hBcyERuVhmRssi2l/4C6cbOsTl0npLIuT1pJs2VZbI0IKw72uXHOxcS5decAfS8Un2gmXRg
 uvXR/+E8xr8VvD7qEPJo1BkYxOZZYSCn5M+4qoPNww2Na7P9A3P2FHlz7zLpAw4EWXH2aALAUG
 AiDTMMt6iVfsvJ6UJa8Xumr7DwoKyNX82yEYvM90l0XC2oCa7BpCWUtQ612P89CfDhIy+f4dkJ
 TbAw0xUQKgFCurS6JpZH3czm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:02:41 -0800
IronPort-SDR: 6A0PnGC/q7Zyg1zrQKfcHOfY5IwoJGcytqOuI9LDpvoQVu3y+54WJcDzrGK4SXWXC4OytjXRRb
 QIO1gBly/0L4hQrI/cy7iGWpdKFgJt//QHM846gVrVMh3nsmWTdA9o32lBEHLFqsTer1kZTT0X
 lx2bKMxOrC1Z/aCmoLw/hub6jzhZ/2VqhN32gPg0Zbv2sbseveYQjF0WuJKGKM/noqpL87Ovld
 5LqtfcpRsPqrdgn1VbmnUkmchsn10rN3zPz+mIIslw7H70ewqiyEhTzwiNLwo5UlH1/qSSXVY6
 BN0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:29:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JksfV6qslz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1643268562; x=1645860563; bh=SfgOOidNN1sUEB6J+H
        VJXi95BK6rb46fh1tlETej//Q=; b=hTPlOPHdF71eoTB3nyOWsoLo89J5GiYAZu
        /aV9sJV9BNB4VD4az2cZhI9rj2FM+IblrlYzts9xlccKCB22ELECJxExRtcJnDuF
        efax3VHMNYRpjlZl5/u5hiQiEsuSj3kKVA/hwTXmosJKEC4gx0hIgV0qxzw7S+RA
        MGMADCqnZil+QEPeYxbXdtJzMwT4X3Enp6O2z5NueKvy73flO/P66tyr29kYNcu6
        1aMpgsJzmbo5Q7+5b4oVkeU3LWDHXOsL1IQknTsnEDweVMksJAmD7oPqGoO0UWh0
        THZniADqtbwz8ur3C56NEcnXKinAZQjmWDjItQKr1PGfhZeqFrCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K0jvF_81YOnL for <linux-ide@vger.kernel.org>;
        Wed, 26 Jan 2022 23:29:22 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JksfV2b9Cz1RvlN
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:22 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 2/3] ata: libata-scsi: Simplify ata_scsi_mode_select_xlat()
Date:   Thu, 27 Jan 2022 16:29:18 +0900
Message-Id: <20220127072919.139615-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
References: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use get_unaligned_be16() instead of using hardcoded accesses to
16-bits big endian cdb fields.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c73e94c06147..515c5599cece 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3672,7 +3672,7 @@ static unsigned int ata_scsi_mode_select_xlat(struc=
t ata_queued_cmd *qc)
 			goto invalid_fld;
 		}
=20
-		len =3D (cdb[7] << 8) + cdb[8];
+		len =3D get_unaligned_be16(&cdb[7]);
 		hdr_len =3D 8;
 	}
=20
@@ -3698,7 +3698,7 @@ static unsigned int ata_scsi_mode_select_xlat(struc=
t ata_queued_cmd *qc)
 	if (six_byte)
 		bd_len =3D p[3];
 	else
-		bd_len =3D (p[6] << 8) + p[7];
+		bd_len =3D get_unaligned_be16(&p[6]);
=20
 	len -=3D hdr_len;
 	p +=3D hdr_len;
@@ -3722,7 +3722,7 @@ static unsigned int ata_scsi_mode_select_xlat(struc=
t ata_queued_cmd *qc)
 			goto invalid_param_len;
=20
 		spg =3D p[1];
-		pg_len =3D (p[2] << 8) | p[3];
+		pg_len =3D get_unaligned_be16(&p[2]);
 		p +=3D 4;
 		len -=3D 4;
 	} else {
--=20
2.34.1

