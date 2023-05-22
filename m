Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F3C7EE2A
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 11:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjEVL23 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 07:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEVL2O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 07:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C697
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 04:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAF261ACC
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 11:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981EFC433EF;
        Mon, 22 May 2023 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684754873;
        bh=YlSrjjgS0ttZ0Lq06mQCanJLMeOwH4uMc1M54iSycCc=;
        h=From:To:Cc:Subject:Date:From;
        b=tDvGnpy4DgHLRtGR1dAYeyAHhIMncYJRbZCpH+Fc+LAGa1D0hed7R50SJziqo3vcS
         m78HuWyKbJ36PHcESjuayhrH3UO3lEztwt42Sq3PC9VzYsPRkGJ29O9Mw5A4QZCYYq
         PfPuSxj/KysWjRTdh1sisAvQm15Yi8irWpxfrgyKTjG9sgaoO5R54xd8z4BpEhU7ZB
         k3vkrTcWVY31PNpT9tY7JS8UMTzVaNv6+Mgnv5XEXCecjUAnV7KjcPy7aDH1XHWoQC
         YjiyAUi1bvdb1JuwllihPXYxaxruEjJncHNAk35b9dO24tsxgg5sdn1o3lJMg6XlWa
         U+ntHLs2PmuqQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH] ata: libata-scsi: Use correct device no in ata_find_dev()
Date:   Mon, 22 May 2023 20:27:51 +0900
Message-Id: <20230522112751.266505-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For non-pmp attached devices managed directly by libata, the device
number is always 0 or 1 and lower to the maximum number of devices
returned by ata_link_max_devices(). However, for libsas managed devices,
devices are numbered up to the number of device scanned on an HBA port,
while each device has a regular ata/link setup supporting at most 1
device per link. This results in ata_find_dev() always returning NULL
except for the first device with device number 0.

Fix this by rewriting ata_find_dev() to ignore the device number for
non-pmp attached devices with a link with at most 1 device. For these,
device number 0 is always used to return the correct ata_device struct
of the port link. This change excludes IDE master/slave setups (maximum
number of devices per link is 2) and port-multiplier attached devices.

Reported-by: Xingui Yang <yangxingui@huawei.com>
Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..3ba9cb258394 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2696,16 +2696,33 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
 {
-	if (!sata_pmp_attached(ap)) {
-		if (likely(devno >= 0 &&
-			   devno < ata_link_max_devices(&ap->link)))
+	if (unlikely(devno < 0))
+		return NULL;
+
+	if (likely(!sata_pmp_attached(ap))) {
+		/*
+		 * For the non PMP case, the maximum number of devices per link
+		 * is 1 (e.g. SATA case), or 2 (IDE master + slave). The former
+		 * case includes libsas hosted devices which are numbered up to
+		 * the number of devices scanned on an HBA port, but with each
+		 * ata device having its own ata port and link. To accommodate
+		 * these, ignore devno and always use device number 0.
+		 */
+		switch (ata_link_max_devices(&ap->link)) {
+		case 1:
+			return &ap->link.device[0];
+		case 2:
+			if (devno >= 2)
+				return NULL;
 			return &ap->link.device[devno];
-	} else {
-		if (likely(devno >= 0 &&
-			   devno < ap->nr_pmp_links))
-			return &ap->pmp_link[devno].device[0];
+		default:
+			return NULL;
+		}
 	}
 
+	if (devno < ap->nr_pmp_links)
+		return &ap->pmp_link[devno].device[0];
+
 	return NULL;
 }
 
-- 
2.40.1

