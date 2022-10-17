Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320ADC433FE
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiJQDWM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiJQDWK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:22:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CDA4D83D
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665976929; x=1697512929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sLFiXeuzpBVILHKt2Dl8xMndN8iMH7sUXIAUMWnlnro=;
  b=ODST+AMr8Lw4oE2PcIFKQ38ctWenl7I9ScDW6LSqjkiMc2M7Pi/cjWQx
   SpU/zemvqBJWhj4VQchxh/UPNkNM9ArRubp1vOox8u5CuutWs17brTDsL
   +y0jOyhDN0Q5wsdKSBQo46VVxZ2iqRsqVIeO7mwTr+kfGyZ3MyDXLuV7q
   5lzcvtSyRoyhj4qTAL9V2zngWSqVLS32OYUqfKM8OPgiWz7oQPxEgXMy7
   0zBlQSts1pZRrFE8/FdPvYSg7tozuwp76AJN04BcFw/zAMtbIty7JBcqW
   8sJyUzfi2sGLfsr0KFHjq5BPF2TLfy0Fcq7ML7+Gnua6FbOqYtoxou9Lw
   w==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="219134996"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:22:09 +0800
IronPort-SDR: tFx7yuYkJw7LeCULEPuqSYolVPmfJqTQgKG3jwEOY2GP5ZXHfSks4bfRKheo/MDkvrcbwAsgUw
 TzU4jJnwj1GJsqj0Afofh4mISwXArXns05QVFlJriPHaHxbjS2nfn4Y3iXGicpZPQ/XqJttzxb
 b46AGPKATTUOEK9zOzeA6qXLVi1o+Yykn6+dn/++rMSpsI/cEQUQIdlO2go+ilU+mlFB8iIgqj
 XCqgqezXvEjkX3igYWEe16loI3ePCkPoEK9uOfxnJeHudR9bYit1UUy7742teOTcqIlNgS825N
 Oe8fOEw5RNb4e91R8l4zSxXZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:41:42 -0700
IronPort-SDR: xQl5xLXtMkL687zSKZqpbUC+Gjeigh6FKzued5uc66LzI/ndq5fHW0TwL70Jkz6DKbZn+CgHOL
 8+xJ5l55vsRRM9RJtp9T2mEsewBuAhaJ1IQSCk5Wh+2DaMd6YP5pj6i8r9ztX1s+mWepe1/mth
 Yv75hwea5o02arN10q/k2InIVQ+Ys1iedXZYWSPwKdAPxrBeiWYX8P5pmYrCOLlohVGuDuCtrM
 jgsOltUsvexlGfla516WN0vjoPmx0v7XM4Oe6sL46W7BqPplDLE2x/lbJrZhaTY0pwfKEY9VWz
 MrY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:22:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMjs0713z1RwqL
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1665976928;
         x=1668568929; bh=sLFiXeuzpBVILHKt2Dl8xMndN8iMH7sUXIAUMWnlnro=; b=
        Zlk8l8gi+Xe7rOn8ZwRo1z7U/eLsXX3QmC3tpMNUAVlpPrFjjY9NRC6Ze0DFKy6T
        Y2bwIXaVlSdZ1WEXPQJvlT3Du0Yb27XVIjNHirwiYSxMAuJrD4s1PLUWLEU790jj
        AfAwaTHRYMLagz8jdDCABZBq6PaJd7CXKGxAk9KN7YSaDfwkedYJJquw8U0xnT/J
        NWOD9+IUNOG+TmJc35hcY2xCiFgKb9iyfxm4MQPj1BYbjKVifcCOw21C7Rx1zhKj
        Q9PFeVn4yHvsA6GMSv1zlDD/gCFpLPQOzqj6eoy3KeBX9pcNbm9boChVAel/J6uY
        tA9OsZ6Tksk2reFNLLU1UQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 79ac-DsaSR0p for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:22:08 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMjq1371z1RvLy;
        Sun, 16 Oct 2022 20:22:07 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-renesas-soc@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 0/6] Fix compilation warnings
Date:   Mon, 17 Oct 2022 12:21:59 +0900
Message-Id: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Several patches for 6.1-fixes to dwiaddress fix compilation warnings
thrown with CC=3Dclang and W=3D1 and depending on CONFIG_OF settings.

Damien Le Moal (6):
  ata: ahci_st: Fix compilation warning
  ata: sata_rcar: Fix compilation warning
  ata: ahci_brcm: Fix compilation warning
  ata: ahci_xgene: Fix compilation warning
  ata: ahci_imx: Fix compilation warning
  ata: ahci_qoriq: Fix compilation warning

 drivers/ata/ahci_brcm.c  | 2 +-
 drivers/ata/ahci_imx.c   | 2 +-
 drivers/ata/ahci_qoriq.c | 2 +-
 drivers/ata/ahci_st.c    | 2 +-
 drivers/ata/ahci_xgene.c | 2 +-
 drivers/ata/sata_rcar.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--=20
2.37.3

