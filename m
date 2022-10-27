Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DA9FA373D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 07:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiJ0Hue (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiJ0Hud (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 03:50:33 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0B13AE78
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666857030; x=1698393030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ghntvAtt4GawdRO63wcP/NrrHVwvVpsYqhyS6SWaG6s=;
  b=YhdjUoezkoP1VKE6NeHIoNk2d/60AFXToENdqN2Db4MpXfCENTUDkr1k
   c0690YazFtB+H4lA7nWi9ryszZzDWEpoYY7+Fukwla5e4SfYfUq7+eg1K
   CnyEVZJrgkaf2kBc64/Uha1WFz1mIFSeFouZ9ubLvroDpaJ6bbQX7QAOK
   Lct4bREK9v7KT/L5I47VImpET+Nav5L22KBHgdrNCJuV9R1oG06pWQZEM
   m8NG5j9VlUFUnbSV7+wTUFJ43T6Xl73WydFRQ4CPSHgMqT+0bbTz/JXXw
   /9XlPAEh4HAqDFTdASHBDS4kEytFYX/kz5PncrxSrKZiOxtnnxjtHRbSS
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214853389"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:50:30 +0800
IronPort-SDR: PUpibVMCURANsy8oHRmsLgxx2dzQE8ewPznHMB4pQQ4A/QQEOPCXxxDyLfS9CDr7pYpsj2Znwp
 a+ijoGNaUIUcnakrsGhKqMDZbZ5WXJmRO+GoYeq/Fa8wRNrARbvUnFA1yc6vuhfI2t7DOFoTYU
 GbB6Nh89yx6+pp1x/i3WqhCPXKjWj08Kqyp6hgSLKQCGN+FrG/C1EG55yi2qYUGjyrr5YSm9if
 P+i14ocWEdO8kCuNc4oVo5cDen6i4w5XrCKyEa9iDJkLXHJaEip0DRRNujDrpvAnkmarZpzZZo
 fDNsl7xPj6SOfQOl6Qk/um16
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:09:50 -0700
IronPort-SDR: ZqmMa1OaTPouVEgS1W8Bs2uxlkx+GtU1DEFpNHtWqV+kBcE5N+KIcw607fkyGxNEEknIQUTOfp
 YTClD8HhnjA59f4DdL1Fj1VVqWy6gtkdKBCITdC8ul095oSiVYIxukOqNlZ2HGcQSkX/8Vaqr/
 gzwPrWcnhia2NjxXVjrQrh9m8sFDiU1ro/nTvQRPxoOEPgbfzmZNrKwAjvAMSn+eQUjiK+6DbT
 tPSe8N94f5GD2D6A6C8+gOl+XobSXTru59AUaUOGzOtI+bLB0vQT6wP9iTnJGsYumplP3aIWNZ
 m1s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:50:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MydBs1tHvz1RwqL
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1666857028;
         x=1669449029; bh=ghntvAtt4GawdRO63wcP/NrrHVwvVpsYqhyS6SWaG6s=; b=
        NHZA5j7uqMMlRx6UvzMAJ9exq1FbQs3URX4f2aw7RP2smW8mjVrAJn7xn2azUCKd
        1hC05B4RF0la3yVryfTbAA4HMR+LbdlnAlxNa4/Qf0ixwyC//XrlEAEbnxLKvXLL
        olKU7KHkUj80qteo2g6jv4Y1F6YIftMqwSs5bRv+3geLo5NP/iHDCIrjDfpv6z1n
        4tbA13JJO3h01h+bvwl6X1iAaeoosLtBt8bVy7izFDomIQbK8HzlJLLI79NL6FLh
        cWvbbUMxqa6JoSHtyOwzVucT/SBNMFxoU3HABKTNoccm30XGfRpfDOl5uFX1QXNe
        zF6vSdF8EXupr6NR15QWYg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s8ogU92GSXRF for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 00:50:28 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MydBr0Wwtz1RvLy;
        Thu, 27 Oct 2022 00:50:27 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 0/6] Improve libata support for FUA
Date:   Thu, 27 Oct 2022 16:50:20 +0900
Message-Id: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

These patches cleanup and improve libata support for the FUA device
feature. Patch 6 enables FUA support by default for any drive that
reports supporting the feature as well as NCQ.

Changes from v2:
 - Added patch 1 and 2 as preparatory patches
 - Added patch 4 to fix FUA writes handling for the non-ncq case. Note
   that it is possible that the drives blacklisted in patch 5 are
   actually OK since the code back in 2012 had the issue with the wrong
   use of LBA 28 commands for FUA writes.

Changes from v1:
 - Removed Maciej's patch 2. Instead, blacklist drives which are known
   to have a buggy FUA support.

Damien Le Moal (6):
  ata: libata: Introduce ata_ncq_supported()
  ata: libata: Rename and cleanup ata_rwcmd_protocol()
  ata: libata: cleanup fua handling
  ata: libata: Fix FUA handling in ata_build_rw_tf()
  ata: libata: blacklist FUA support for known buggy drives
  ata: libata: Enable fua support by default

 .../admin-guide/kernel-parameters.txt         |  3 +
 drivers/ata/libata-core.c                     | 80 +++++++++++++++----
 drivers/ata/libata-scsi.c                     | 30 +------
 include/linux/libata.h                        | 34 +++++---
 4 files changed, 93 insertions(+), 54 deletions(-)

--=20
2.37.3

