Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3111BC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 07:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiA0H30 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:29:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23782 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiA0H3X (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 02:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643268563; x=1674804563;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NZVnGrvFwokDMNKghsBHpoxRVIKd+yantHMv5jmOjGQ=;
  b=NplttSH8LQinH+DNk4hJgOdmXwVnMecrUHOS2PA+vWp1elEzNbDpXT5E
   +yFD/31UKsVJmUBjfV/s8lCqHRBGspXyiYSiifyyrxHS1UoVApGy7XDXE
   3JeJ9gGPDS2dHlhrpheqORTx4v5AhT51F4JEm+AAZov2vbv2p9emyO5gh
   03vdh8q6dt8EJDtsGM0VyvnLmkmhNJZZMYfU/8Vkn7P3w6EyhmTuY0xkq
   U1tbL+f8JDXOobe8PZvP7MDff5Jn3d55aTt1jAaGD861y35X/sEPJeOAN
   Qz7lvEVTu03tyEJq0BigcOiH1em5hsFbDTGUXptv63ayQ3OK8YAgzVdKA
   w==;
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="295583698"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 15:29:23 +0800
IronPort-SDR: veInYRgg+4UF6DTbOeUQh9MHYK+9KM9GlrZ/2vtHJp3IKySBJe4rA4i6LJp0n/Qmzx482oPhwf
 +wAT1exokJUvHIQn9fRpei5LTHQzdeOXL/HVpZwJTJWjYrbGWwH4ij01Jaoz03Afxpl8JNavwr
 AC/LSYI3IEBFg4HlfxjCc3nuwVzef1VrD8/wNpRJ8lvuxCYHHV1GqDmGADXhDod+BQfi2jU3yp
 ds7xhFVaxhH5wLX9N8UvyWSEdJsIKvFOgPPi1Pqa8lAmlxh9gIKv+lEuc9Z7k4+y2bkEabI5Bw
 TmALDncFOqQsdgsow17g/OjA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:02:42 -0800
IronPort-SDR: lcz42phyxWV0yUWCzfHFy8H7osCoOTeXtm3XaariGiaKJQGY8jD3Cp2DMk3ibQkbs8AerH7yr2
 Qthp8KVDr4+CLVRcufFSGiglVPhT/ccIsSd07zw0wf8eMbSVWnVwPDOWdmgTP/jJg+yc9cDsUo
 1GKHaJtr0YDAR0aorTnn0zsui66/p9c4BXeDSSpgznuI/VncwhqTl148+Xllkn635Gc/3ovoYr
 I4vjml80+1w0tLhHM7vuS3yQsq+AYHmmOEuaL8LqlEIuExmQVhrlehotcPlraeylnS66UegChI
 +no=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:29:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JksfW49Vvz1RvlN
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1643268563; x=1645860564; bh=NZVnGrvFwokDMNKghs
        BHpoxRVIKd+yantHMv5jmOjGQ=; b=KmBYvDvb6SbRtyFD3JkESFTD6iMhB26bWm
        Yra6IoGrwqq9MVAtzSeTyPWJrV1Houlk3bdlEEwe6hQKVqgQgmnxKqS1bFdnloeG
        H+Y0aj02BmjxUdUPpxnJXBtT4ZneiEBnwoZ1eT66OgrFxNUPxoGCuuZNo2ihxn5v
        RYfikHAq5Hw8vAWPLOkRFQ0xQEafz+8hLpZ7z6BT7zXEhM2k6TylLk3MQYnYPFJl
        N/tlmAHQRQfH+BYdO3apB16Bg+UYVy6Lz2Rb4WPhj1LbIVt07Q+ZE2d/iAhVZmM0
        vxd+foZlfgXEV8aYh/MCKZjDHBsCJHsICqtQyNXE32hjWfxKDr7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dm3vcN54CXC1 for <linux-ide@vger.kernel.org>;
        Wed, 26 Jan 2022 23:29:23 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JksfV6dKdz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:22 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 3/3] ata: libata-scsi: Simplify scsi_XX_lba_len()
Date:   Thu, 27 Jan 2022 16:29:19 +0900
Message-Id: <20220127072919.139615-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
References: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In scsi_10_lba_len() and scsi_16_lba_len() functions, use
get_unaligned_bexx() to access a cdb LBA and length fields instead of
hardcoding the byte retrieval. With these simplification, the functions
can also be declared inline.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-scsi.c | 40 ++++++---------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 515c5599cece..eb40c3796a3f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1314,21 +1314,10 @@ static void scsi_6_lba_len(const u8 *cdb, u64 *pl=
ba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
+static inline void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba =3D 0;
-	u32 len =3D 0;
-
-	lba |=3D ((u64)cdb[2]) << 24;
-	lba |=3D ((u64)cdb[3]) << 16;
-	lba |=3D ((u64)cdb[4]) << 8;
-	lba |=3D ((u64)cdb[5]);
-
-	len |=3D ((u32)cdb[7]) << 8;
-	len |=3D ((u32)cdb[8]);
-
-	*plba =3D lba;
-	*plen =3D len;
+	*plba =3D get_unaligned_be32(&cdb[2]);
+	*plen =3D get_unaligned_be16(&cdb[7]);
 }
=20
 /**
@@ -1341,27 +1330,10 @@ static void scsi_10_lba_len(const u8 *cdb, u64 *p=
lba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
+static inline void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba =3D 0;
-	u32 len =3D 0;
-
-	lba |=3D ((u64)cdb[2]) << 56;
-	lba |=3D ((u64)cdb[3]) << 48;
-	lba |=3D ((u64)cdb[4]) << 40;
-	lba |=3D ((u64)cdb[5]) << 32;
-	lba |=3D ((u64)cdb[6]) << 24;
-	lba |=3D ((u64)cdb[7]) << 16;
-	lba |=3D ((u64)cdb[8]) << 8;
-	lba |=3D ((u64)cdb[9]);
-
-	len |=3D ((u32)cdb[10]) << 24;
-	len |=3D ((u32)cdb[11]) << 16;
-	len |=3D ((u32)cdb[12]) << 8;
-	len |=3D ((u32)cdb[13]);
-
-	*plba =3D lba;
-	*plen =3D len;
+	*plba =3D get_unaligned_be64(&cdb[2]);
+	*plen =3D get_unaligned_be32(&cdb[10]);
 }
=20
 /**
--=20
2.34.1

