Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21798C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 08:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC58E61208
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 08:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhKKIsp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:48:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3122 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKKIsp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2021 03:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636620357; x=1668156357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HetiWGxR6G+7dZSBcZSILOkrrHR6BuX76NGA/Kht+Uc=;
  b=NV/Jhf7kN71bI8K2TpUdV3hcJEYwD5VvIHQ75Dd+fEchUJpJkVIgNKrJ
   eNU71NQTuojNF+pDE8pB+8Lgm2DrODNVYhM0OqIgFyQ4NmlJLFFQOqEwI
   kUptlnQySD1Q1QtAp2363Dqb3v9X/5S/pdNSLxCJKUdOUbTkk7yDtcedd
   933o3Z6FLstc9bah4JegweyBWOxVxkPpG91RDYMEwSL/KcVp7JFPJuhaY
   QKAdejh3PC5SL4SJ8NlwY50PYKXAi8yidRApUJIbQsS+k+QH9x+WyQZKm
   ncimvtodi84pSqyAmq2ts8K/e9f139Arjsr1ocH+MDr4ZxJ3G4d8vBwc5
   g==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="186327695"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 16:45:56 +0800
IronPort-SDR: Pfm5P9oBcbljjgM3jCyzQA+bU8ONpJkqWfguD1C3qWRTC7g1m4LdFwmLFc2qZ9cTP5Q/3ynTEZ
 1MHUY0hTlb6/try6rmwAMkznf93tXVzOVLrqIiOKc2Da92b7GPNNEFbVzhhFa9d99SeAaAWGNh
 ++B+oL/ANWTFiHzeE14BpPHI+NLfcSj+ulepRO0WZ8yBHQgjK/3ZRp3PA1jUTyXQeqnfmvVwVQ
 dKFVSCZSIbMJknFdHkJ+5ryfttmtiSkdc4Jw0JHj3HDouLE2jknuzfLlioLvizSVPBZBtIxmOV
 4MnIDAzJoF/oAa9+uFc8cQvV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:21:06 -0800
IronPort-SDR: yu0ou2j62uu2CffyQ76XKAx4sc9UZIp7zjTR4m+L6KAE5gHMH2iAAUWc/4h4yfdRk4ZefBlfye
 cleej2N6wnAeW8Xxwu1kGMXKp5crzPREOlNqVcBOlnJPMBdXV4ftcFzH1y/CTlh2gPpTyO+AK6
 z2jzXx05KXVLJPeObpDvUzvyKliaTM0gEJFir6s+IPKJ7n7Lv9eZ8LUKezRYg82dmQywTpuAcJ
 mt5UKtJzCI8zrGX3z1SKqCE9UjMcXrHG0dl9sdFnKXIDEhtvAtj+u6SfYKsmtHyzJ+jGjElK0u
 G68=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:45:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hqb0N09Vcz1RtVm
        for <linux-ide@vger.kernel.org>; Thu, 11 Nov 2021 00:45:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636620355;
         x=1639212356; bh=HetiWGxR6G+7dZSBcZSILOkrrHR6BuX76NGA/Kht+Uc=; b=
        d6Z81Z+W6m8om/Lma2KEvIAK/xvi+UkgpoVX4KEb8IT7v1oC5EmytIlrJk6cpJQY
        8TmrvyxOUWwQ66wTiD00o0ygOSuJofR/+7083778PtRzTivoaicUlo7nVyCq0d3x
        rWcC7eUHFxJgsosQ+Rg7donVWds39s/jw8BU1+lZlRYn689tibkk7+B9rOeoGJnJ
        1eKQbI/Eid8OiPRRYraXmMkCZ1xKM3weDzWoj11CrE+2EvdAgusF9IM2vF7rammC
        FrFXr2aohrfjdFl2Sb+19dn1PuQC4qg4YK3kB2kb5IhBXwgCLBW5ib6Kr58rNJoR
        tdl3waIeD6MrbJRUjhisvA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t-ke98mH7dzV for <linux-ide@vger.kernel.org>;
        Thu, 11 Nov 2021 00:45:55 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hqb0L6XLjz1RtVl;
        Thu, 11 Nov 2021 00:45:54 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] scsi: fix scsi device attributes registration
Date:   Thu, 11 Nov 2021 17:45:51 +0900
Message-Id: <20211111084551.446548-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Since the sdev_gendev device of a scsi device defines its attributes
using scsi_sdev_attr_groups as the groups field value of its device
type, the execution of device_add() in scsi_sysfs_add_sdev() register
with sysfs only the attributes defined using scsi_sdev_attr_groups. As
a results, the attributes defined by an LLD using the scsi host
sdev_groups attribute groups are never registered with sysfs and not
visible to the users.

Fix this problem by removing scsi_sdev_attr_groups and manually setting
the groups field of a scsi device sdev_gendev to point to the scsi
device gendev_attr_groups. As the first entry of this array of
attribute groups is scsi_sdev_attr_group, using gendev_attr_groups as
the gendev groups result in all defined attributes to be created in
sysfs when device_add() is called.

Fixes: 92c4b58b15c5 ("scsi: core: Register sysfs attributes earlier")
cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/scsi_sysfs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index d3d362289ecc..92c92853f516 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1301,11 +1301,6 @@ static struct attribute_group scsi_sdev_attr_group=
 =3D {
 	.is_bin_visible =3D scsi_sdev_bin_attr_is_visible,
 };
=20
-static const struct attribute_group *scsi_sdev_attr_groups[] =3D {
-	&scsi_sdev_attr_group,
-	NULL
-};
-
 static int scsi_target_add(struct scsi_target *starget)
 {
 	int error;
@@ -1575,7 +1570,6 @@ int scsi_sysfs_add_host(struct Scsi_Host *shost)
 static struct device_type scsi_dev_type =3D {
 	.name =3D		"scsi_device",
 	.release =3D	scsi_device_dev_release,
-	.groups =3D	scsi_sdev_attr_groups,
 };
=20
 void scsi_sysfs_device_initialize(struct scsi_device *sdev)
@@ -1601,6 +1595,7 @@ void scsi_sysfs_device_initialize(struct scsi_devic=
e *sdev)
 		}
 	}
 	WARN_ON_ONCE(j >=3D ARRAY_SIZE(sdev->gendev_attr_groups));
+	sdev->sdev_gendev.groups =3D sdev->gendev_attr_groups;
=20
 	device_initialize(&sdev->sdev_dev);
 	sdev->sdev_dev.parent =3D get_device(&sdev->sdev_gendev);
--=20
2.31.1

