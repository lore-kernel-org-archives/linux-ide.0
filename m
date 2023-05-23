Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A5C7EE26
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 02:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjEWCc1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 22:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEWCcX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 22:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68ABCA
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 19:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4225F62DEC
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 02:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14224C433EF;
        Tue, 23 May 2023 02:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684809141;
        bh=OzJGr4tfMZ4vW+zjqkp7tBeM4TzZ3xbas9/OjDEkp1o=;
        h=From:To:Cc:Subject:Date:From;
        b=fq/jynzcYmLgT7iUFRTtazktq9mYijLCcDW41rca9WyGxJtVFFXRtqRgWcrGfOfwx
         HuWlr3EQhX2bl+dRKd+b0NRzMhTc7noQrYWV5E+kxKU9F97mayZ+sCd4CYJXKfoI70
         KijIEkjI9iINjM5Z5lA41jR8QLm1KWqrhSkQhBTyplv7H3i2Jp3uF9017xhr7D0eOq
         WXXUd090j4WP05eoUG7AAEvq+3BkdMEXv+v6IOO+rdmCrbLXvgh8hRZRVgJCUsLWK3
         8J2i5pu8zbKoEyW3mM/fz5AFCF7KUM3bweRmzvUcLF7crOE1+5nlkz0ibLtxsX9ASu
         FKjaRrrWFEaLQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH v2] ata: libata-scsi: Use correct device no in ata_find_dev()
Date:   Tue, 23 May 2023 11:32:19 +0900
Message-Id: <20230523023219.291253-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For devices not attached to a port multiplier and managed directly by
libata, the device number passed to ata_find_dev() must always be lower
than the maximum number of devices returned by ata_link_max_devices().
That is 1 for SATA devices or 2 for an IDE link with master+slave
devices. This device number is the scsi device ID which matches these
constraint as the ID are generated per port and so never exceed the
link maximum.

However, for libsas managed devices, scsi device IDs are assigned per
scsi host, leading to device IDs for SATA devices that can be well in
excess of libata per-link maximum number of devices. This results in
ata_find_dev() always returning NULL for libsas managed devices except
for the first device of the host with ID (device number) 0. This issue
is visible by executing hdparm command, which fails:

hdparm -i /dev/sdX
/dev/sdX:
  HDIO_GET_IDENTITY failed: No message of desired type

Fix this by rewriting ata_find_dev() to ignore the device number for
non-pmp attached devices with a link with at most 1 device, that is SATA
devices on SATA ports. For these, device number 0 is always used to
return the correct ata_device struct of the port link. This change
excludes IDE master/slave setups (maximum number of devices per link
is 2) and port-multiplier attached devices.

Reported-by: Xingui Yang <yangxingui@huawei.com>
Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---

Changes from v1:
 * Simplify code change (remove uneeded check and remove switch-case)
 * Reword and improve comments in ata_find_dev()
 * Reword commit message

 drivers/ata/libata-scsi.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..d936506a8af9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2696,16 +2696,34 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
 {
-	if (!sata_pmp_attached(ap)) {
-		if (likely(devno >= 0 &&
-			   devno < ata_link_max_devices(&ap->link)))
+	/*
+	 * For the non PMP case, link_max_devices is 1 (e.g. SATA case),
+	 * or 2 (IDE master + slave). However, the former case includes
+	 * libsas hosted devices which are numbered per host, leading
+	 * to devno potentially being larger than 0 but with each ata device
+	 * having its own ata port and ata link. To accommodate these, ignore
+	 * devno and always use device number 0.
+	 */
+	if (likely(!sata_pmp_attached(ap))) {
+		int link_max_devices = ata_link_max_devices(&ap->link);
+
+		if (link_max_devices == 1)
+			return &ap->link.device[0];
+
+		if (devno < link_max_devices)
 			return &ap->link.device[devno];
-	} else {
-		if (likely(devno >= 0 &&
-			   devno < ap->nr_pmp_links))
-			return &ap->pmp_link[devno].device[0];
+
+		return NULL;
 	}
 
+	/*
+	 * For PMP-attached devices, the device number corresponds to C
+	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link
+	 * for the device.
+	 */
+	if (devno < ap->nr_pmp_links)
+		return &ap->pmp_link[devno].device[0];
+
 	return NULL;
 }
 
-- 
2.40.1

