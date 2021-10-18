Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9529FC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 18 Oct 2021 01:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB52610E5
	for <linux-ide@archiver.kernel.org>; Mon, 18 Oct 2021 01:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbhJRB4c (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:56:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62019 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhJRB4b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 17 Oct 2021 21:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634522062; x=1666058062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2+WgSLvAXOHau0uysg4YIJK+5Vcius+hLEnH9VTwGc=;
  b=HBu3MFe6PEDc7Hkx5OKk6liA7MuM//jqq4GWDoKrllCkQ/QMP5evhtCz
   Ml47TTd45opm/8QTtASFscDdD8Y/3Vt+yfcpKWxF9dHV6ebdupoYi1YXe
   l8P+wMYWW3aWc11nVBesZjBMypYq/7/trrmbZkgzBrRVOfo0sP+MPpGqU
   U0Zxt/fxLOlOt4sBsQqo9wihlld88H/Sc29SIy5CFb9VwKfYuCvViWg6I
   DxE8X34WBByoGIYiIWGtfyf/LfEa6+s5bLjWuo+keAkqXgf276zCYBDlS
   zOGK9ptzYy5wPdjnamw/oYzGuQ/QkLu3U/LRY3BjvPUYz5OqrlNAHPH/8
   w==;
X-IronPort-AV: E=Sophos;i="5.85,380,1624291200"; 
   d="scan'208";a="184080494"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2021 09:54:21 +0800
IronPort-SDR: zcrldA2wkpD/cbN51GZCYBNcqTk8icG6R19PvMlmd0V4cFrbODF98TbFyNbJk0vqxMU2j7FFJ+
 sJVDeLX2Jwd9n2X8JoHl7ZU9ULYKATZeJ96nYDIaKnaCOwl1KOtgoIzZ3H5Uu2RGF4AXwmpfUP
 f559dOnPwVKk1J48Tubx1yzEymxBa6FpBiig2TWRSuZ4AgvXEyABJVkusvmyRE5C/JBGJap0nQ
 qP6WugD+KKS/yJ3L4H/Iy+RcDoRrV964XCFqdXNwNHV0aL6XHaXmIen3/pT25FNr23UDpF1YqF
 NQDXOOJr1cHdK86hr70/WnYz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 18:30:01 -0700
IronPort-SDR: S3Uc/nGE/bbn4w/JRDoMXcQQjz5Hios99ybr1W7Y7MYLCEWtTdJtZjEXnmDNRZoN5R2FOJH8nZ
 HbRm/Wj8Ia8LleAzkTeU4VKQ0xzb8flf0DD1Tin8gCtfCWoO8SqiVU9a0gw1lAuIddmQefTPeJ
 kzUKL/kXTwbaZc14bjTOQZFP+t5H0cL3yrKWH87GpSkm9sjeb4Sk0FMFgD3v1zcIR4avH6gW/m
 Ai7JGohz08k60tLkxs3IXymXolWrOjC9tAdKE+dCarN+k7RnRetE3ngcomI+LDFftZ+c9InLFe
 8bc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 18:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HXg0X6frPz1RvlM
        for <linux-ide@vger.kernel.org>; Sun, 17 Oct 2021 18:54:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634522060;
         x=1637114061; bh=g2+WgSLvAXOHau0uysg4YIJK+5Vcius+hLEnH9VTwGc=; b=
        Ua+iRqCUZb2cQHpspNaa4uu6+mevfKNWaIZb/cmSk0gJwniTnQ4PEUNAodp5/s0v
        EmySSgTc8F6GtG+Ir9NOZqw074Efc1QkqLQ/oFfheCxMKVr2ngJRXZfi1abZv8sz
        YduExlIkQiQogkZqMeXnYVOMONEJ+KGw08fDAY/lcZ9x5exJhRC87H6u9uSzlCx2
        SX6hkWsp8no+Ugkz2DfSXmv4AajHlSD1bL6dUdu2a/ygTkmnlDOaNn19akc5ZtR2
        pNZELyRLFmk67Uj14ZxsG3NqMTRZWjDN+u/WrsW1UQQiE9E65WjuU2SCf41QHkrV
        ndclwNwDAxpVA/nYhvB+Hg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lvT5ylC1fKeE for <linux-ide@vger.kernel.org>;
        Sun, 17 Oct 2021 18:54:20 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HXg0X0nLcz1RvlJ;
        Sun, 17 Oct 2021 18:54:19 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.15-rc6
Date:   Mon, 18 Oct 2021 10:54:18 +0900
Message-Id: <20211018015418.11674-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2=
cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.15-rc6

for you to fetch changes up to 776c75010803849c1cc4f11031a2b3960ab05202:

  ata: ahci_platform: fix null-ptr-deref in ahci_platform_enable_regulato=
rs() (2021-10-14 12:22:47 +0900)

----------------------------------------------------------------
libata fixes for 5.15-rc6

2 fixes for this cycle:
* Fix a null pointer dereference in ahci-platform driver (from Hai)
* Fix uninitialized variables in pata_legacy driver (from Dan)

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

----------------------------------------------------------------
Dan Carpenter (1):
      pata_legacy: fix a couple uninitialized variable bugs

Wang Hai (1):
      ata: ahci_platform: fix null-ptr-deref in ahci_platform_enable_regu=
lators()

 drivers/ata/libahci_platform.c | 5 +----
 drivers/ata/pata_legacy.c      | 6 ++++--
 2 files changed, 5 insertions(+), 6 deletions(-)
