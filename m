Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11171ECAAA3
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiHYWi7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHYWi6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:38:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E31C6531
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467136; x=1693003136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dHvDoNmnLyAVW1Ir+CtnfwdYNp8+C05/e61xG9yExHI=;
  b=HT7FCZ3uQmv8F9xcshpWKzlC5r56dSqa/IRpabufJdjKPkar5Rk7nV+X
   cJdtLGe6e/TEHddJX09FfMnLi1u3zIljZ0jhNX+KNo4sL9SkoYgVE74HW
   k6tVfufZ9D1nOxDeRS2AG2wQvat4AVYA50xsvQtMVx/bav8wHE/Ksi9iq
   oCMEl7KyRW02odFku7ttZ76lIKemHgPfZ0OcYqYWPb9BdiQalG2KhtzcI
   08ofYYYuMH/a9KP8K7+g1Z7yYfMQ8MbFgrqUWpXG6CsLoqp0gyox9aVCK
   +zN7HPP/ACphNzHdeApazfZqelbq/123guVLdh5Sv/93KApccZ/0TvlcH
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="209678857"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:38:56 +0800
IronPort-SDR: LRwtUcKzhXYOmC6wioPYhsjZwdPOKo9upQRvAdCJNa60WUmMK/lYBbPab1dyqtmB/DGEA/Yjik
 LaVKt/IzoTWmpVUUOv+ikTz09fQiRHh9SaSpiEUqiuj3geknU6KlemipvBJS2jiexBe0ZWjc/j
 MpJm22XI1OUbwMqiWTY+ZDWR7DY42zdQNVqUqKS5W8SNicWj8w9aOxQ9iro4WdgTSAmm/IRpu/
 FANxFmZDUbvN8ywu5kHW7ETXXC5ev2r2htFnJ0z5A274Nrq2aO9v4LLa8ygiqq7a+ywFZ4ldy5
 YJm5hNhvPWorcM0aKv4vW6mF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 14:59:33 -0700
IronPort-SDR: 3BntF+UU8qXuMJJcMqOWQqQ4pM1cSP76iqbmls9SAXmJ6F7YIfR2oLkbNOdTb9G3rw7SjSQJf0
 14gUq+CiE76dce0t/SaESMqZN+1udh+O3RlWi58AGop09fIJGFJm/LJrav4buActEn8VW4b5m9
 6HGZta7c5uCc1tRC4HwrSO//2leSqtH4MnPinzBE4HYFooGV/bOLa71/q4h5ZmHLBWVGGE/NcA
 Y5Zr2+LCq9iFEeU193iqG/PUFHzfvlZpZ4ywx+5JNnSl/1c+2JWx3VzSPai+bYw+qaAc+z4PpT
 dWI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:38:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDHv40GxBz1Rwnm
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:38:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1661467135;
         x=1664059136; bh=dHvDoNmnLyAVW1Ir+CtnfwdYNp8+C05/e61xG9yExHI=; b=
        uQVTpvWFy3iTVt1bUcSy5Iq+edSeEgXSXkLkuVlDJaIZJXZWiQxr07p5la/6lSmU
        ruMd/d1DjPuzceRs8smfuTZ8Tc950qZRcMQ7l0YWfgUV0+a0E6G5fLYEiUyOhOWj
        b6Vwu/CwoTAXONPZkhf9VGKxn5Zha6UhI0+T7KYVY6NS7G5i1ynQqF4GMcZFSxgw
        JESeAuqThsd/WPqdN39d5XFFWF4aARU4aPzpM0ETeYOMS3ayD13DKilAkjtbiAqY
        N4juIF9SsP5zh/7ZU377jH+DSxGKubZnoN9wGdc6vcafB84Y00OhaAPtSuY8GoYn
        fTo94At2aF9TPtCQmSMnhQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i7P217a0pqK6 for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:38:55 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDHv3101Fz1RtVk;
        Thu, 25 Aug 2022 15:38:55 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-core: Simplify ata_build_rw_tf()
Date:   Fri, 26 Aug 2022 07:38:53 +0900
Message-Id: <20220825223853.354968-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Since ata_build_rw_tf() is only called from ata_scsi_rw_xlat() with the
tf, dev and tag arguments obtained from the queued command structure,
we can simplify the interface of ata_build_rw_tf() by passing directly
the qc structure as argument.

Furthermore, since ata_scsi_rw_xlat() is never used for internal
commands, we can also remove the internal tag check for the NCQ case.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 20 ++++++++++----------
 drivers/ata/libata-scsi.c |  4 +---
 drivers/ata/libata.h      |  5 ++---
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d343b8d37d11..8e5c79c96fef 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -665,33 +665,33 @@ u64 ata_tf_read_block(const struct ata_taskfile *tf=
, struct ata_device *dev)
=20
 /**
  *	ata_build_rw_tf - Build ATA taskfile for given read/write request
- *	@tf: Target ATA taskfile
- *	@dev: ATA device @tf belongs to
+ *	@qc: Metadata associated with the taskfile to build
  *	@block: Block address
  *	@n_block: Number of blocks
  *	@tf_flags: RW/FUA etc...
- *	@tag: tag
  *	@class: IO priority class
  *
  *	LOCKING:
  *	None.
  *
- *	Build ATA taskfile @tf for read/write request described by
- *	@block, @n_block, @tf_flags and @tag on @dev.
+ *	Build ATA taskfile for the command @qc for read/write request describ=
ed
+ *	by @block, @n_block, @tf_flags and @class.
  *
  *	RETURNS:
  *
  *	0 on success, -ERANGE if the request is too large for @dev,
  *	-EINVAL if the request is invalid.
  */
-int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
-		    u64 block, u32 n_block, unsigned int tf_flags,
-		    unsigned int tag, int class)
+int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
+		    unsigned int tf_flags, int class)
 {
+	struct ata_taskfile *tf =3D &qc->tf;
+	struct ata_device *dev =3D qc->dev;
+
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->flags |=3D tf_flags;
=20
-	if (ata_ncq_enabled(dev) && !ata_tag_internal(tag)) {
+	if (ata_ncq_enabled(dev)) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			return -ERANGE;
@@ -704,7 +704,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct a=
ta_device *dev,
 		else
 			tf->command =3D ATA_CMD_FPDMA_READ;
=20
-		tf->nsect =3D tag << 3;
+		tf->nsect =3D qc->hw_tag << 3;
 		tf->hob_feature =3D (n_block >> 8) & 0xff;
 		tf->feature =3D n_block & 0xff;
=20
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 29e2f55c6faa..f3c64e796423 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1605,9 +1605,7 @@ static unsigned int ata_scsi_rw_xlat(struct ata_que=
ued_cmd *qc)
 	qc->flags |=3D ATA_QCFLAG_IO;
 	qc->nbytes =3D n_block * scmd->device->sector_size;
=20
-	rc =3D ata_build_rw_tf(&qc->tf, qc->dev, block, n_block, tf_flags,
-			     qc->hw_tag, class);
-
+	rc =3D ata_build_rw_tf(qc, block, n_block, tf_flags, class);
 	if (likely(rc =3D=3D 0))
 		return 0;
=20
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index bc84fbb48c0a..2c5c8273af01 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,9 +44,8 @@ static inline void ata_force_cbl(struct ata_port *ap) {=
 }
 #endif
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
-extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *d=
ev,
-			   u64 block, u32 n_block, unsigned int tf_flags,
-			   unsigned int tag, int class);
+extern int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_b=
lock,
+			   unsigned int tf_flags, int class);
 extern u64 ata_tf_read_block(const struct ata_taskfile *tf,
 			     struct ata_device *dev);
 extern unsigned ata_exec_internal(struct ata_device *dev,
--=20
2.37.2

