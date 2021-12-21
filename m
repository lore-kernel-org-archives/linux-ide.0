Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE91C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 16:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhLUQ0s (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:26:48 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:27173 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239734AbhLUQ0p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 11:26:45 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104724099"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2021 01:26:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CAE1B40A6498;
        Wed, 22 Dec 2021 01:26:43 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/4] ata: pata_platform: Sort the #includes alphabetically
Date:   Tue, 21 Dec 2021 16:26:13 +0000
Message-Id: <20211221162614.25308-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Sort the #includes alphabetically.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1-->v2
* New patch
---
 drivers/ata/pata_platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index d1f7f4d65316..80e5cb12707e 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -11,15 +11,15 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <scsi/scsi_host.h>
 #include <linux/ata.h>
+#include <linux/ata_platform.h>
+#include <linux/blkdev.h>
+#include <linux/kernel.h>
 #include <linux/libata.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/ata_platform.h>
+#include <scsi/scsi_host.h>
 
 #define DRV_NAME "pata_platform"
 #define DRV_VERSION "1.2"
-- 
2.17.1

