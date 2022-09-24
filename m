Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A8C6FA83
	for <linux-ide@archiver.kernel.org>; Sat, 24 Sep 2022 06:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiIXG3Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 24 Sep 2022 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiIXG3O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2022 02:29:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A814D316
        for <linux-ide@vger.kernel.org>; Fri, 23 Sep 2022 23:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664000950; x=1695536950;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UrK46OMiqPVktHMv38BtOvMlKQ1EObJa5Sv80Q61LtE=;
  b=bvXcr1OsPe+Ixz7mEIKKtHfN5cUPhlC9RxpVsyGxCFvKjB6V2HS6NUgE
   5U+Uipj5ajbyRdN3alF4I4WAtkZ/ckYTalY5t0EshxUFQ68eIylk+jWU/
   BiHW4RQM1QXr7C9pabAKkEJG1si6esDZOHOgMFVP8ATdvB+2OPW4nbqK2
   OMsLuEwxVp9RBPJ+s/Ccfj0U4myuQ826ifkFQ0/2THitwHBwPQgPZVFfT
   5RTIWLfjA3e1fl8T9APeVrZ0bfapWDUpa+PQdwWy6IXeW9qW0LX9PY19k
   GwV6wM197akvOOXDbf+GfEhpiGNjKAWSwzwVIbgP9583JxZqN3VH1qhYg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,341,1654531200"; 
   d="scan'208";a="324269417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2022 14:29:10 +0800
IronPort-SDR: S8ZHAwHKTDipAjNNb56Po7GwNbp30ChU1wK2U9U2ojv2HdflIe9Y9i7Lg95DpKh0NimRJpeayC
 5HpyPuZQfQAO+S4UEFWTEqALJrv3HHd/ez4dsZ8TjOKhy/zroVrPiOsNyQh0ojcDJ4uqp7EPbM
 WDDdqhTe+kqJ/pd3IRtBPQQbeCsidLey0BffR/8WynbcQFUdJuHxplrcm6yEc/ITWePzkDg18x
 l+zYKtgiunVEr8z6gIrE4uc5mbp9PnPBYc6qRxD6unGK4GB74ZowOGjZZQF8BRzOtITq6uX+fK
 CwdA9LBfOiNdj6csYW//R8TK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 22:49:12 -0700
IronPort-SDR: P3qM/XRJ9TOuYBmQ1bnuB6Hzv7xiUXxxmRYrdC1d0wDTW/99DgHyGgCKMIUQ72QkY0FOiC2eYm
 SgK12DWTYtvP8pkuHbIoR9U1Cu8QgwSOGLVuGYFzZSzTkvhY9B+r483tjqgOW/j05gZF71DhS4
 STqOL2gmaP0M93g23IxOJ7JQfveVxxPhtTsbcdYTqBx844lYHrH7YoZQv+PawofUx8Eev+Aafj
 wLrpVuT72H0c7LrsdpdX9r8ixUqiep8afzSqKlYFJlqheXrE6T0Z00a1LWVWnLc/9R8hZRtFVy
 dzM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 23:29:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MZJyJ0Tc9z1RwqL
        for <linux-ide@vger.kernel.org>; Fri, 23 Sep 2022 23:29:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1664000951; x=1666592952; bh=UrK46OMiqPVktHMv38
        BtOvMlKQ1EObJa5Sv80Q61LtE=; b=jQ+Uv2qPGwxGXcuxhDY5lqTQUywsASfQJp
        zqwDnBhyetxuvM1C3O9+HJwSN/7YsAMY8UFMdRtOcyITmuUGJCjkvFXNWBv5Xf7K
        ebPbQRxMFvz4Yptu4LEvZk795KlzTLQPvNMT84xSVRrUX0kpgjnxnBeYguRBabne
        /Z5n5JpVMWhsWq796+5QU/RYoc22YZ5Su3DSGKG7SZK/E4QQEUcdEdb1YGgKmr4j
        yZAX6L0x625pObD6sDraMQGzfhmujDinUrID/JuRx0VXstuybWfY0NMdObVbV9iu
        PzjxGi6rUMVsqPTdnxeIEe6CO34FnOVHOwKOHncXd6f0jN81m6sA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SbaNRZgi-hg0 for <linux-ide@vger.kernel.org>;
        Fri, 23 Sep 2022 23:29:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MZJyG5HQZz1RvLy;
        Fri, 23 Sep 2022 23:29:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] ata: libata-sata: Fix device queue depth control
Date:   Sat, 24 Sep 2022 15:29:07 +0900
Message-Id: <20220924062907.959856-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924062907.959856-1-damien.lemoal@opensource.wdc.com>
References: <20220924062907.959856-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The function __ata_change_queue_depth() uses the helper
ata_scsi_find_dev() to get the ata_device structure of a scsi device and
set that device maximum queue depth. However, when the ata device is
managed by libsas, ata_scsi_find_dev() return NULL, turning
__ata_change_queue_depth() into a nop, which prevents the user from
setting the maximum queue depth of ATA devices used with libsas based
HBAs.

Fix this by renaming __ata_change_queue_depth() to
ata_change_queue_depth() and adding a pointer to the ata_device
structure of the target device as argument. This pointer is provided by
ata_scsi_change_queue_depth() using ata_scsi_find_dev() in the case ofi
a libata managed device and by sas_change_queue_depth() using
sas_to_ata_dev() in the case of a libsas managed ata device.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-sata.c           | 24 ++++++++++++------------
 drivers/ata/libata-scsi.c           |  5 +++++
 drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
 include/linux/libata.h              |  4 ++--
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 7a5fe41aa5ae..13b9d0fdd42c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1018,26 +1018,25 @@ DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO, ata_s=
csi_activity_show,
 EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
=20
 /**
- *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
- *	@ap: ATA port to which the device change the queue depth
+ *	ata_change_queue_depth - Set a device maximum queue depth
+ *	@ap: ATA port of the target device
+ *	@dev: target ATA device
  *	@sdev: SCSI device to configure queue depth for
  *	@queue_depth: new queue depth
  *
- *	libsas and libata have different approaches for associating a sdev to
- *	its ata_port.
+ *	Helper to set a device maximum queue depth, usable with both libsas
+ *	and libata.
  *
  */
-int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sd=
ev,
-			     int queue_depth)
+int ata_change_queue_depth(struct ata_port *ap, struct ata_device *dev,
+			   struct scsi_device *sdev, int queue_depth)
 {
-	struct ata_device *dev;
 	unsigned long flags;
=20
-	if (queue_depth < 1 || queue_depth =3D=3D sdev->queue_depth)
+	if (!dev || !ata_dev_enabled(dev))
 		return sdev->queue_depth;
=20
-	dev =3D ata_scsi_find_dev(ap, sdev);
-	if (!dev || !ata_dev_enabled(dev))
+	if (queue_depth < 1 || queue_depth =3D=3D sdev->queue_depth)
 		return sdev->queue_depth;
=20
 	/* NCQ enabled? */
@@ -1059,7 +1058,7 @@ int __ata_change_queue_depth(struct ata_port *ap, s=
truct scsi_device *sdev,
=20
 	return scsi_change_queue_depth(sdev, queue_depth);
 }
-EXPORT_SYMBOL_GPL(__ata_change_queue_depth);
+EXPORT_SYMBOL_GPL(ata_change_queue_depth);
=20
 /**
  *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
@@ -1080,7 +1079,8 @@ int ata_scsi_change_queue_depth(struct scsi_device =
*sdev, int queue_depth)
 {
 	struct ata_port *ap =3D ata_shost_to_port(sdev->host);
=20
-	return __ata_change_queue_depth(ap, sdev, queue_depth);
+	return ata_change_queue_depth(ap, ata_scsi_find_dev(ap, sdev),
+				      sdev, queue_depth);
 }
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
=20
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ff9602a0e54e..c63bb50323c1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1101,6 +1101,11 @@ int ata_scsi_dev_config(struct scsi_device *sdev, =
struct ata_device *dev)
 	if (dev->flags & ATA_DFLAG_AN)
 		set_bit(SDEV_EVT_MEDIA_CHANGE, sdev->supported_events);
=20
+	pr_info("#### can queue %d, ata qd %d, scsi qd %d\n",
+		sdev->host->can_queue,
+		ata_id_queue_depth(dev->id),
+		sdev->queue_depth);
+
 	if (dev->flags & ATA_DFLAG_NCQ)
 		depth =3D min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
 	depth =3D min(ATA_MAX_QUEUE, depth);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sa=
s_scsi_host.c
index 9c82e5dc4fcc..a36fa1c128a8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -872,7 +872,8 @@ int sas_change_queue_depth(struct scsi_device *sdev, =
int depth)
 	struct domain_device *dev =3D sdev_to_domain_dev(sdev);
=20
 	if (dev_is_sata(dev))
-		return __ata_change_queue_depth(dev->sata_dev.ap, sdev, depth);
+		return ata_change_queue_depth(dev->sata_dev.ap,
+					      sas_to_ata_dev(dev), sdev, depth);
=20
 	if (!sdev->tagged_supported)
 		depth =3D 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 698032e5ef2d..20765d1c5f80 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1136,8 +1136,8 @@ extern int ata_scsi_slave_config(struct scsi_device=
 *sdev);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
-extern int __ata_change_queue_depth(struct ata_port *ap, struct scsi_dev=
ice *sdev,
-				    int queue_depth);
+extern int ata_change_queue_depth(struct ata_port *ap, struct ata_device=
 *dev,
+				  struct scsi_device *sdev, int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_=
failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct a=
ta_port *ap);
--=20
2.37.3

