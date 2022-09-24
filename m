Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9023C32771
	for <linux-ide@archiver.kernel.org>; Sat, 24 Sep 2022 06:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiIXG3N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 24 Sep 2022 02:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiIXG3M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2022 02:29:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A441811E5C1
        for <linux-ide@vger.kernel.org>; Fri, 23 Sep 2022 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664000949; x=1695536949;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ARt+xybw1ZTRIuNWQEZHUMf2M7qRGuMbQgKColji1wY=;
  b=Z/rvPIBCf0kieNimHenNh/Qt2UWmfRTOrkic1D9rsvGKWYZCc+J5ZKoo
   oWeL6m8WYV0BcLZe2EIxyrhwy3rs8b/sjuB4LMLhnhqFi1ngilb9sQUvc
   fNdn8pj1H4KWpuTeFm/45LsQHZOUiAdalw5xZG8+XHHLVz8mARqfJRxk+
   /nL5JkNk4VsxHGRejlzgANbsePGA/Hc2WoGtv8q5hqJjNVBAJbVmO4UgZ
   RF17niGpAfTQDdtr2S04/ezdn+TPLNdS8nyqYNiutBzhF4b3QnlP5P+ge
   6j6rT5zB9Zw3qjiUV0ZZTBQ/7DbmRpfJkpbb8PVEqdnnOkWXji6clIzpN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,341,1654531200"; 
   d="scan'208";a="324269411"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2022 14:29:08 +0800
IronPort-SDR: /58lfqY+/iqI9CaLOK76iO+yw3k6cQNoz/likL31s5iXuuSmV9zkmr0hC7PMeWDVKI7RO6mA8F
 vPWnOnCLvlXoI8gnscd6fqmCFg4inUzOg6RpCFtLwfsEpV+NIgZUxX/tT9wbvFuJJiV4GQlRd4
 rYOG/3spAvKuX2Bp5QVPGnhwzSNjqfGvM44ffwAK0kureivPHCuRxlDej5pJqiRhM03Mogfd1E
 lIplXfx6ZcVwB0vzQiUvks2pKScgqk9dm2fJU1ZIaf4n37SSrZBZmQYigTuQIbAQWfnKNxjf5R
 ctIfzoc0cJyCX69bRR6U08t6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 22:49:11 -0700
IronPort-SDR: BmPR6qQD58oJ5GwwYwG/nt5Ef4tUD4SMQ4fWyxGQlCZSVL7n+KxR9Jv4mVEq3Rykj10j3+Ex7h
 40tL+f2DUcZ2G8mHGuvzXnyfPod6kC0EFwx++oxF24rZOh4NfPqE59RNkjAZJGZDFTKK4lLWKo
 +A5vxWcJR2cRmUBb/MAKYRRiPNaj6Mw9UmKaxT+qZddCf0nkVqnBp8NMOlKs1OqOJiVIEpr0Z9
 Fvc1PYq9esIBkYIzcvaWQqdhXhPi0GjFA0mr7t4gaJyRvQ6pNlp6cmFCUdIt5vqxZULJ9Olydn
 W64=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 23:29:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MZJyF6pYjz1Rwt8
        for <linux-ide@vger.kernel.org>; Fri, 23 Sep 2022 23:29:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1664000949;
         x=1666592950; bh=ARt+xybw1ZTRIuNWQEZHUMf2M7qRGuMbQgKColji1wY=; b=
        XsF7CmD+1FeSl2n1M8++3d+wbATynS9tMR74JYsjhu9mZDDxlhU8pK1JETlOu/oC
        6yHubwUWajPfk84eBZKr0l2LFK1CurmOQVMSuvHk3M9zIFhKvrZYbUkgHSqk5qc7
        3kQidKIFcEtIfy+V2uJyfnVPYOcnfPha9tfC9F1BG4nMLdqILn27DlRQzQ9lZ1Vf
        LxdhiLZ2oXu1KHq7vmdX3/+PEEhhPk/pmkx3scrMnO2e9LWhsnt5mYniyENJsKt5
        gSxVYybfRGhI4Fqq2J6i0TRxk3gOv3ciF0+mqeaXVVu4bBTV+vQ22dYNckHbMKfh
        NjCmJhN0apPLFWy3ov1nAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fYCMYJSHLkhc for <linux-ide@vger.kernel.org>;
        Fri, 23 Sep 2022 23:29:09 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MZJyD5Snvz1RvLy;
        Fri, 23 Sep 2022 23:29:08 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] Fixes for ATA device queue depth control
Date:   Sat, 24 Sep 2022 15:29:05 +0900
Message-Id: <20220924062907.959856-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A couple of patches to fix maximum queue depth initialization and
control for ATA devices used through libsas.

Damien Le Moal (2):
  ata: libata-scsi: Fix initialization of device queue depth
  ata: libata-sata: Fix device queue depth control

 drivers/ata/libata-sata.c           | 24 ++++++++++++------------
 drivers/ata/libata-scsi.c           | 13 ++++++++-----
 drivers/scsi/libsas/sas_scsi_host.c |  3 ++-
 include/linux/libata.h              |  4 ++--
 4 files changed, 24 insertions(+), 20 deletions(-)

--=20
2.37.3

