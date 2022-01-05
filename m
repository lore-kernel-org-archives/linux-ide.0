Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C9C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiAEFR6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:32396 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237442AbiAEFRy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:54 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmy1x8Gz1VSkh
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359874; x=1643951875; bh=qUevm0U48ZPHeWko4E
        DayyqR3P46rFV4p0h6kkh51E0=; b=DWIPTKLtKwxf8TDgKnmIl85UfD9Xr87dq5
        gc4fXjFfxvWh+on9YlU4HqZ8lttZc4c2Tb3cXEoaXFkiQN93EDSJZx8XRohE8PZ3
        cC1APG27oOLmsxCiKXydjXhs+5mISbtuktzlRsFpdcBZ6KOAca4ae+pni0Apj1ak
        VwSnYn5NxgIKnGhRmsla6+dfQUrqKt3FSGYuBD+T9SYEpAhFwhzR5rOBuGqs0nIL
        02vLK7hU2Xg/pPUoBfAoqVr63KWpBZrINzhijqpdxp7yeUsypt+Q2e8Ss4iTzfYE
        3PXIBFTO6kj7qKBsASjEf6whowyRdKCIJ+ay7YugHKTqed+5KJdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S6o013eNFA8s for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:54 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmx3t9Qz1VSkb;
        Tue,  4 Jan 2022 21:17:53 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 19/22] ata: sata_fsl: fix scsi host initialization
Date:   Wed,  5 Jan 2022 14:17:32 +0900
Message-Id: <20220105051735.1871177-20-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compiling with W=3D1, the sata_fsl driver compilation throws the
warning:

drivers/ata/sata_fsl.c:1385:22: error: initialized field overwritten
[-Werror=3Doverride-init]
 1385 |         .can_queue =3D SATA_FSL_QUEUE_DEPTH,

This is due to the driver scsi host template initialization overwriting
the can_queue field that is already set using the ATA_NCQ_SHT()
initializer macro, resulting in the same field being initialized twice
in the host template declaration.

To remove this warning, introduce the ATA_SUBBASE_SHT_QD() and
ATA_NCQ_SHT_QD() initialization macros to allow specifying a queue depth
different from the default ATA_DEF_QUEUE using an additional argument to
the macro.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_fsl.c |  3 +--
 include/linux/libata.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 142e65d5efc7..101d4dd79f62 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1380,8 +1380,7 @@ static void sata_fsl_host_stop(struct ata_host *hos=
t)
  * scsi mid-layer and libata interface structures
  */
 static struct scsi_host_template sata_fsl_sht =3D {
-	ATA_NCQ_SHT("sata_fsl"),
-	.can_queue =3D SATA_FSL_QUEUE_DEPTH,
+	ATA_NCQ_SHT_QD("sata_fsl", SATA_FSL_QUEUE_DEPTH),
 	.sg_tablesize =3D SATA_FSL_MAX_PRD_USABLE,
 	.dma_boundary =3D ATA_DMA_BOUNDARY,
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab2d404cde08..cafe360ab3cd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1385,6 +1385,12 @@ extern const struct attribute_group *ata_common_sd=
ev_groups[];
 	.tag_alloc_policy	=3D BLK_TAG_ALLOC_RR,		\
 	.slave_configure	=3D ata_scsi_slave_config
=20
+#define ATA_SUBBASE_SHT_QD(drv_name, drv_qd)			\
+	__ATA_BASE_SHT(drv_name),				\
+	.can_queue		=3D drv_qd,			\
+	.tag_alloc_policy	=3D BLK_TAG_ALLOC_RR,		\
+	.slave_configure	=3D ata_scsi_slave_config
+
 #define ATA_BASE_SHT(drv_name)					\
 	ATA_SUBBASE_SHT(drv_name),				\
 	.sdev_groups		=3D ata_common_sdev_groups
@@ -1396,6 +1402,11 @@ extern const struct attribute_group *ata_ncq_sdev_=
groups[];
 	ATA_SUBBASE_SHT(drv_name),				\
 	.sdev_groups		=3D ata_ncq_sdev_groups,		\
 	.change_queue_depth	=3D ata_scsi_change_queue_depth
+
+#define ATA_NCQ_SHT_QD(drv_name, drv_qd)			\
+	ATA_SUBBASE_SHT_QD(drv_name, drv_qd),			\
+	.sdev_groups		=3D ata_ncq_sdev_groups,		\
+	.change_queue_depth	=3D ata_scsi_change_queue_depth
 #endif
=20
 /*
--=20
2.31.1

