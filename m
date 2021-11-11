Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09208C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 03:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62046124D
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 03:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhKKDh0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Nov 2021 22:37:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12908 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKKDhX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Nov 2021 22:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636601676; x=1668137676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+eLG0ew8fKkuzFl36Eh7RZTLe040vxndE1bYKICuEy0=;
  b=S+NVcIACKbZsqMY/N5Jg6tBZ3maMlhqe+L8juRXWv55/FY3x1+t8NOpI
   zxXf2tV0sjkrCjdOIj0MWBtTM/mOf46QBZLLqkpG+LdKA6hHU7AjtMcyf
   Ftoq6/65f0DjuRjgheFnl2dK5Fqrx+0YRvmJhRv2wGxP2gCutqt5Pg8l6
   vu3rczyzCfg0IPPhwTg3rwKhC4oNXqnQAcQN7asJjLc9WXaPmHFi0LGOT
   WTYjFWuwfEQxf5C+Aw5bAeYX+xqYs1hqPBPNlvscyVJNIZ5UTtr7XcjMa
   T1PNXrM42Oufl3YHn6fqYxWX2P7NzK3BpHS2+xpxGY8QyZFx82tQW3bQM
   g==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="186299366"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 11:34:36 +0800
IronPort-SDR: 6cIQOuyvrIOtxL20uuHNlRygkEhUT7hAqW0U4+Cj7ac8BqTdZsZ3PG0/PU29BemK9nLJn7YyHc
 jVRW5CO3sw9j4FmmTkSjnW4oeMaOQp0w/onuhsJV/Q9Ez7/EQGNbnIfmmfEpF9mcS8+gc+ouFZ
 6xrItE6vdDEY8vSrh4lCNmKIYPn7AsY/Upsu4ucy/MOE16tKwgDJbQmTyRLTf4YJNyT/OM/WgL
 YnR5CqfY0HWI6YpYiUz6wxfLT+Ye7hVm0/++HtSaSQIGvSc7gjib1eWiE53skhcpu+HN6drqnx
 BOinp7nucyRvtfPvbac+PdBW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:09:45 -0800
IronPort-SDR: DZwfPsoIJ0ipCk+92gWCuR0vp8zQMm4OYbGLZ8sIZ7JTQL55PWUuz305rZcFsdE6Pq8hUQ2dMg
 E11A491On/tHuQg3zb9U1vPm2Knhqw72DzQAP7I3EgCUfV4AzitmMmhYNmca9523JDSPctInXc
 uDdZ4vEAmjlAPaLqJF2xulJJZx9wiS2SvkpIK1D5VwVqKNYmHzN3ZKhOV7anIEWCRapcXoshtq
 9gaQ4Wy4IrbkGTVLN/MDUDUeTwuBpWSeu5GRmptiwx88Eyy2WJKSXRO0FuEEgQypnu0GXsImaT
 iwE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:34:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HqS57050Lz1RtVm
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2021 19:34:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636601674;
         x=1639193675; bh=+eLG0ew8fKkuzFl36Eh7RZTLe040vxndE1bYKICuEy0=; b=
        DWBIIH6q4sEcrUPdVgKCTCGbPMaL5oIzh93GJmDgHGgn7VlqyVl+WR/PChcDZWGc
        VYp8/O2nFJs18dLJPyYZa24xRsEA+kXqfslc0YZgGvCBkRVDH0HxaYz0E4ZSzGV0
        rn0ILRkcBNUI5Zdhi9Ihe3P+kuo35o4Q6iw5FQF5I63WGY4+Md4PMbEy2UQ6LOng
        nRTvf/BqT33BtTjeAfDpu2CXs1ZxdenqRlCgZY2ar4PCXeyd2KonJGjIQX78/4x+
        oAmx2tLDPkvW7ntamQkMQ+zBQrw0b4hjRPXHfByTb0+x7STuKidvy4833+BTJTQ6
        D1Qkb0SA/IpkTaiT8abEpg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XiTpTNbRGV3x for <linux-ide@vger.kernel.org>;
        Wed, 10 Nov 2021 19:34:34 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HqS556SMBz1RtVl;
        Wed, 10 Nov 2021 19:34:33 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] libata: libahci: declare ahci_shost_attr_group as static
Date:   Thu, 11 Nov 2021 12:34:30 +0900
Message-Id: <20211111033430.296597-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ahci_shost_attr_group is referenced only in drivers/ata/libahci.c.
Declare it as static.

Fixes: c3f69c7f629f ("scsi: ata: Switch to attribute groups")
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 28430c093a7f..8a6835bfd18a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -131,7 +131,7 @@ const struct attribute_group *ahci_shost_groups[] =3D=
 {
 };
 EXPORT_SYMBOL_GPL(ahci_shost_groups);
=20
-struct attribute *ahci_sdev_attrs[] =3D {
+static struct attribute *ahci_sdev_attrs[] =3D {
 	&dev_attr_sw_activity.attr,
 	&dev_attr_unload_heads.attr,
 	&dev_attr_ncq_prio_supported.attr,
--=20
2.31.1

