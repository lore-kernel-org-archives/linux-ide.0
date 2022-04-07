Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B797C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiDGMbB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiDGMbA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 08:31:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED932EE2
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649334539; x=1680870539;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YxmYIQnAcUV0QD5JfubvnxJxwl/LqZvuPbj1DPNnZ0Y=;
  b=WzuZ+9v8Sb0XsqChipV1i/L+jGMV4hfhwhMbgQO+Ooz/b8y7PEwCY3a0
   RI9Cjgm6MaVTnSInskm1cr6n7pUK9v478n8xxnb6aSNaRWnqB3tqzhkW5
   hhETvepB5UwIlTUCew09CSER8O5qiKM42h6kFl9k2OnMjoXKWor1WsEsy
   +VW8iPde3g0l+4vN5E4JWn8TchjCnayjIgvQNcmTGBt5sxGrr9XHy7Qcm
   BQlnV8e8SAq9f5LF21B9J8U+G7HIfQS/u5Z4qGKVxIVh0lgKwaprv0cGb
   kEYRPsCFBQgLSH3QdKrvUd6CsnZlplsGc/dd+ZXW3PByFuvvy/EjDEUBu
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643644800"; 
   d="scan'208";a="196214796"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 20:28:59 +0800
IronPort-SDR: IPmhFss2go4hKaFsl88vECBeVBAU5YW3sc6/jaX/S2PWT413+bkt0DBPX3je/ME9gJmuOBtBh0
 ODEmxCWEM73sfV17BUlAs1eA8HigxO/1hBPvAHcZ02AclniCMgfNrcSAo2tL1L5rl4i+Z6Vmwe
 yThZVb3+18yVWJdNzGBlvMdcpR5KUqudsUIp6jDPK6WOwCR1xOYHbMQ1pVT3IO/UBVkqEjK8KF
 iVmKm0Zms5yWidK6hhvmnpSwnlMeFXq03dDTI2e0ZkKBYzgrYXPOxfIM38e3+7vCWWRtGCZC5C
 55h8v5H7uj6l8JgeELop4kCB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 04:59:40 -0700
IronPort-SDR: ikjX3hMlhu48nOaCC64H+rhuxwhr7x94Xu5+ncz9oOtzAGHvqZNBE+nQrRspOm243p2yfbPEt3
 MbnUnlEye8faEbDTRWZ8g2DsOJQoi9jvAEphLoa/TWF9PBzWnZu8tMdewaOeETDIhhEZHUOk8i
 NPD89US+hM73VHlYyVsKBNODijWGpxtb7xwZd/UO3XYIiLRtdc/Fo2igVrKS0I2cYyIoGZJOt7
 66PJSVGqDhCumt4I4QTB6l4gko3lkHUsV+pU2WIJ15gGQ/JJ+wbKOpkAiH6EV7PrqNONGBTGYg
 4uU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:28:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KZ0zv08F9z1Rwrw
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:28:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1649334538;
         x=1651926539; bh=YxmYIQnAcUV0QD5JfubvnxJxwl/LqZvuPbj1DPNnZ0Y=; b=
        VRZpN2Mr5mCqlf48NHpi4ceq5HuDAeXuCto4I/n+fTALVthzecCO9VGOkuWyiZ9P
        X0b6J+5aJTzgEebiM2P3eE3rCZY/5tCcvvENuQ2PO88OCuuBSLwr2jrh9TPou9NA
        xJG+MVH/Lczny2zfbaI2VKEWYssTaJh1WuOulzgac+Q43meXtgYv1e5GRj8/zfU9
        ct3bUUgUFACNzt5lr7mSs2Btmi5Cj3KlMieSPBgSRaug2GfjSljm5Gi1G+7JTis1
        QzC1+tS6PG/xj7rVG8OJm84iO1Peb4r+SxWHjbvuj2EkjplCHmJa6TPzUWmsdycQ
        JO49Oeh6jIVRmvyHl1tOiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fM1U_UVAR7jz for <linux-ide@vger.kernel.org>;
        Thu,  7 Apr 2022 05:28:58 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KZ0zt1vtsz1Rvlx;
        Thu,  7 Apr 2022 05:28:58 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.18-rc2
Date:   Thu,  7 Apr 2022 21:28:56 +0900
Message-Id: <20220407122856.1170057-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc=
17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.18-rc2

for you to fetch changes up to 55b014159ee7af63770cd7f2b6fe926f6dd99335:

  ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back (2022-=
04-06 11:08:04 +0900)

----------------------------------------------------------------
ata fixes for 5.18-rc2

A small set of fixes for 5.18-rc2:

* Fix a compilation warning due to an uninitialized variable in
  ata_sff_lost_interrupt(), from me.

* Fix invalid internal command tag handling in the sata_dwc_460ex
  driver, from Christian.

* Disable READ LOG DMA EXT with Samsung 840 EVO SSDs as this command
  causes the drives to hang, from Christian.

* Change the config option CONFIG_SATA_LPM_POLICY back to its original
  name CONFIG_SATA_LPM_MOBILE_POLICY to avoid potential problems with
  users losing their configuration (as discussed during the merge
  window), from Mario.

----------------------------------------------------------------
Christian Lamparter (2):
      ata: sata_dwc_460ex: Fix crash due to OOB write
      ata: libata-core: Disable READ LOG DMA EXT for Samsung 840 EVOs

Damien Le Moal (1):
      ata: libata-sff: Fix compilation warning in ata_sff_lost_interrupt(=
)

Mario Limonciello (1):
      ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back

 drivers/ata/Kconfig          | 6 ++++--
 drivers/ata/ahci.c           | 2 +-
 drivers/ata/ahci.h           | 2 +-
 drivers/ata/libata-core.c    | 3 +++
 drivers/ata/libata-sff.c     | 2 +-
 drivers/ata/sata_dwc_460ex.c | 6 +++++-
 6 files changed, 15 insertions(+), 6 deletions(-)
