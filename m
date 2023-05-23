Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11883C7EE23
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 08:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEWIGs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjEWIGm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 04:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA27D18F
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 01:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A886300C
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 08:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D46C433EF;
        Tue, 23 May 2023 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684829085;
        bh=q6/aNh2DuNVCocflHIlHZntcxJH3U0d/K5ai30MHFGk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZIah2cE71Q+HKofr4CmqLvX5nRKNe1jXZY2aGJ99b2WJ3kBbzbQd5akLTHJBmLgZB
         jQBbL1lyXwD0bl2/Ws+XVpEuVnOkMnj1UBLJi5KDT0tyv8GZYX0wz3Df4IQGxB04ml
         Er6LG7TZurlsmiJbv1k0u6hvxoHCPE8RvNIcL4l5paSJVYXEl8V0wZeH7axM8Us1Al
         CRN5O3PexHRYKDhFA6ANnSJ7vHSTR+6lCGZYifG0VcXhn2BLfIPXaXeBdV7EAclWwp
         WD934X8xUF7s2iDMspjyP9E8hxd99ss8EfJ73tsicj+edzVyl4UgrR66Kpm79wbP3s
         6iNS+AmP4LvBQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH v3] ata: libata-scsi: Use correct device no in ata_find_dev()
Date:   Tue, 23 May 2023 17:04:43 +0900
Message-Id: <20230523080443.398912-1-dlemoal@kernel.org>
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
is 2) and port-multiplier attached devices. Also, to be consistant with
the fact that scsi device IDs and channel numbers used as device numbers
are both unsigned int, change the devno argument of ata_find_dev() to
unsinged int.

Reported-by: Xingui Yang <yangxingui@huawei.com>
Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---

Changes from v2:
 * Change ata_find_dev() devno argument type to unsigned int

Changes from v1:
 * Simplify code change (remove uneeded check and remove switch-case)
 * Reword and improve comments in ata_find_dev()
 * Reword commit message

 drivers/ata/libata-scsi.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..6878ddf49880 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2694,18 +2694,36 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
+static struct ata_device *ata_find_dev(struct ata_port *ap, unsigned int devno)
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

