Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA2ECAAA3
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiHYWjK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243794AbiHYWjI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 18:39:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C17C6955
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467145; x=1693003145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ruJdsCktlwXtG8/p1R12RnsByf9O5ZTwxMzwsWxDCK0=;
  b=nf9vHVaykj1x00WDsky1zdt9m18Hsa3g4zdhYH468mhAKYJS0ZjmrJdR
   wgs/nY+cgz4WMx7zcZMziQSIsIrNq8OGJqLt3YwgB2VPjZbwUh5ca0v6J
   SUUBQMxQn+5UWspk13bi8Xdw7KnfUrVDqcRp7Xl7blFHizbdT/9S5RsAD
   JvH2JdxRw9yMDydpNC+PHtHToh+r2L2kKU+tmTbKampmqn+5cNIuiuwEk
   bYiwOQPjeCVv8yGR8CpIJvvkLt2wyWouHLZl3YUdhounSZ2xLd0Wj8amx
   jYODeJ1ku73xldUDoCsZVkb9sDveyA5H+FBmtVE36lom7Q+HnSccVUB9r
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="209678862"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:39:05 +0800
IronPort-SDR: +2jbmsMJRjwa08i1AiJ2jT96ftL4d2uyGEJSUvNEM6wZxjNV9AFA9csdqbyOU7ppw7LlgWjSfQ
 6PvNMr0UZHyj4qRVm5XXeC1Q4KPPTYqhz92TWDrJvGDnRQx+ft8vfZ6gq3nnq8OGgglEz09YLo
 FA8i1TaT7/Jb6/wc77jdrOAILVdLC+cNTZ6tebvMT1JbxdXmJlLMzqeLElc+f+zxZv4ly2WTWv
 RiHJL3qJbaV3LV37hN7nlMzzNWlMArFhbUARwmCW6cxgm/tUannCLvgZeJZuYUUjKu+Sk6tGDA
 jMKHU4Awhi3+En2p42M8lZui
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 14:59:42 -0700
IronPort-SDR: FjmaiqsfJ9bRgiP929vLaA7FObOMJ9r0LuCas3ijqm76REm+l+jEOJuFbi+RRct93MBUKdHXRB
 pprixiToeFh6i2HN0EJ4q9V6XYKPVJmL8Na7rbOFO3MZVmoq4rfoPhkt8ulW/rLDsRU6M5XZ0h
 S1SiCqaPfBZBHEK5tdOgTw6BwGqr6eW25IM+tYQ0fnD8xnuD3BD4pDt5EZta/P5HaNEIuwfa7q
 Cp9APsHpZ5ZpT0MtcNE0s0hqFj5hnydsk5pIrjj96Ty+HaWnG65vEuod5Az/fDcPK/9IZ/6lJU
 N4s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:39:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDHvF2fzfz1Rwnl
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 15:39:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1661467145;
         x=1664059146; bh=ruJdsCktlwXtG8/p1R12RnsByf9O5ZTwxMzwsWxDCK0=; b=
        Rx3aD+Hc7W/dCAKM+PR0T6WOvqn1lB0QvPsiLovQ4ybzL4PVG+Cmqcy0WnfS/8yI
        K78N+sz3FcjJ5BQp4VvRgh9pO1LRzAYHTCgEuchfZJl7TrTwcPHydLqKIR4jDQM0
        ZxSUtjmGvmOZUwiilUW+SjhwI5uiGP+gYBQgdMGuPoqUgg+1mEs+9XekC6TrDiUI
        MdROv2MW54QtBD5hS0HJd7vl0x7tmLIUIzd2V6KQ1mtF7kurcM4v96VoxY2ABe5y
        RzpVU5McYKv2QdMoLteTrlEdYE6tw5ygTh3f2PYtKW1QGF70eSjiE9JCtGMVTzYj
        i2/N6cZXj4pNR8cPbjt/BA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yAOLF5wh6P7X for <linux-ide@vger.kernel.org>;
        Thu, 25 Aug 2022 15:39:05 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDHvD48yMz1RtVk;
        Thu, 25 Aug 2022 15:39:04 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE
Date:   Fri, 26 Aug 2022 07:39:03 +0900
Message-Id: <20220825223903.354994-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rename ATA_DFLAG_NCQ_PRIO_ENABLE to ATA_DFLAG_NCQ_PRIO_ENABLED to match
the fact that this flags indicates if NCQ priority use is enabled by the
user.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 4 ++--
 drivers/ata/libata-sata.c | 6 +++---
 include/linux/libata.h    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 864b26009eae..d343b8d37d11 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -719,7 +719,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct a=
ta_device *dev,
 		if (tf->flags & ATA_TFLAG_FUA)
 			tf->device |=3D 1 << 7;
=20
-		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE &&
+		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED &&
 		    class =3D=3D IOPRIO_CLASS_RT)
 			tf->hob_nsect |=3D ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
 	} else if (dev->flags & ATA_DFLAG_LBA) {
@@ -2171,7 +2171,7 @@ static void ata_dev_config_ncq_prio(struct ata_devi=
ce *dev)
 	return;
=20
 not_supported:
-	dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO_ENABLE;
+	dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO_ENABLED;
 	dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO;
 }
=20
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 7a5fe41aa5ae..eef57d101ed1 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -870,7 +870,7 @@ static ssize_t ata_ncq_prio_enable_show(struct device=
 *device,
 	if (!dev)
 		rc =3D -ENODEV;
 	else
-		ncq_prio_enable =3D dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE;
+		ncq_prio_enable =3D dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
 	spin_unlock_irq(ap->lock);
=20
 	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
@@ -905,9 +905,9 @@ static ssize_t ata_ncq_prio_enable_store(struct devic=
e *device,
 	}
=20
 	if (input)
-		dev->flags |=3D ATA_DFLAG_NCQ_PRIO_ENABLE;
+		dev->flags |=3D ATA_DFLAG_NCQ_PRIO_ENABLED;
 	else
-		dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO_ENABLE;
+		dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO_ENABLED;
=20
 unlock:
 	spin_unlock_irq(ap->lock);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0269ff114f5a..a505cfb92ab3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -101,7 +101,7 @@ enum {
 	ATA_DFLAG_UNLOCK_HPA	=3D (1 << 18), /* unlock HPA */
 	ATA_DFLAG_NCQ_SEND_RECV =3D (1 << 19), /* device supports NCQ SEND and =
RECV */
 	ATA_DFLAG_NCQ_PRIO	=3D (1 << 20), /* device supports NCQ priority */
-	ATA_DFLAG_NCQ_PRIO_ENABLE =3D (1 << 21), /* Priority cmds sent to dev *=
/
+	ATA_DFLAG_NCQ_PRIO_ENABLED =3D (1 << 21), /* Priority cmds sent to dev =
*/
 	ATA_DFLAG_INIT_MASK	=3D (1 << 24) - 1,
=20
 	ATA_DFLAG_DETACH	=3D (1 << 24),
--=20
2.37.2

