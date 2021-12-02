Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DBC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbhLBIlH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:41:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26399 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhLBIlH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434265; x=1669970265;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hgnhIhkhfBU/6h13l7b/hlktsXSVTj7ds9uCAcZ1Nn0=;
  b=BN2395pzg/CHZSL/DwkvSI/zLIijtKEj6SVskCCssfSset8bgSLRwKdJ
   LLD95bzQkruT6WKxMjRwbUSfWmVLrN8Zn8Y1f1Yiuq/n0XpRC+p8cD+fo
   sj//42o+AetKuM2rue3Sb05rKqC+qEXrimK+29hTHD6eAOeQe0mVJ6F+a
   5wFt9QABGeA6wXbL/qCuz2P8i2FvbDoU9u24KYrBBbvL1OKxqeKZ5R8pg
   CO7z5jXLrEt6s6TTZBGl5YBj/i4lqvH9+nsHwT/hVtJV9xzgQtL97PU+T
   ML/sKsCh+cF36jTFG3PZbqC4+f+PujkaQlUGIWk/BjjnsPb0kv1iynviL
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299105711"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:37:45 +0800
IronPort-SDR: /9X06lmglhFSb9qewHDNYkFTqn4JX12rQkq4o3WLwupTAnylj2xcDAKl9zWsPESmVu/zcFU6lO
 MudqRThNvtaZ2oLSWAnhM+2klyIKKRx6wfSei0B0yD4g+mIIwL0JUUeQDHUcrcViThRTJTRqja
 L5Xls5AtSGwx+qOevPoTLmq2C/9MJtOq0SpbG6WFCq+oq7YP+hOhlsR9Lm/vtxFiQVoVOsYneQ
 dnWEqEp/GB68VpF1QKpU+HSbIr5WraNCxDQCStXUeXnxM+ia99ypVvK5E3wHrlaGWePkJMX0cc
 fxAGOHhVYEps+WNdSJpm/syk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:12:28 -0800
IronPort-SDR: Kk2JWuK8AKfupPCs2o04HbR59ONl8zN/ylf2Fjv2zNlKNrf6Qvc6oYEbOi9RuIynaZurcnnLrQ
 Fw6u/AHRsm4n2Owm7efZvjlZvJtbagzTeV5WJrrhIfgbwCGvNZ0GwvlqD7gxojFlQxf0t2uVgk
 q/tMIsprkjCZjedsVdOLOtoXVtIv9/BPhAlKPdF8Tg77biQoUgclRvk0hZJKJTPpwoMb+bioVr
 2dfHmLAAa/bLzfK44b6j4J/9rTVI9oS24jDz7o+1hsygZHnDOz2CvGMA5X/hse1S+iv3vTqQa0
 IqU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:37:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4TqF1Phzz1RtVp
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1638434264;
         x=1641026265; bh=hgnhIhkhfBU/6h13l7b/hlktsXSVTj7ds9uCAcZ1Nn0=; b=
        bumeQryQbm9gMpmq/BVUB4CN5vaaBXYsO6PdLYKAky5eWRT/2KH9qDlSVFRMJ+uR
        cALXSP8K2m26rEN7IMwYqrQNE6Z3LVDbDpzAaDXcRJ5Q56D7XcXMJD3TgB2uC7xX
        mGKKChLMutia1t3ULr/SkzK90xrfoscGExQsss8LAYHZM+hj/TIHAjkHcSSqbVf9
        O7+ILUZhDB8L3uUFp11oKrscb8guymC7xPLU1R/4oE0s8n7gzkmcYyKqZkD9gl1j
        0J6q06FNwj4s7Rfh0Poqmwm/iEtATdXGRqsLv8ef1u712luD2G2GDVjIcTYSWASa
        hDHhYVDfQhRHkNzXJjcdtQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iORZ02FbEAY1 for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:37:44 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4TqD3p0Yz1RtVm
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:44 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 0/4] Cleanup ATA sysfs attribute show functions
Date:   Thu,  2 Dec 2021 17:37:38 +0900
Message-Id: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert remaining sysfs attribute show() functions to use sysfs_emit()
instead of s[n]printf().

Damien Le Moal (4):
  ata: libata-sata: use sysfs_emit()
  ata: libata-scsi: use sysfs_emit()
  ata: ahci: use sysfs_emit()
  ata: sata_fsl: use sysfs_emit()

 drivers/ata/ahci.c        | 2 +-
 drivers/ata/libata-sata.c | 4 ++--
 drivers/ata/libata-scsi.c | 2 +-
 drivers/ata/sata_fsl.c    | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

--=20
2.31.1

