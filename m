Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2DC433FE
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 06:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJQG0M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Oct 2022 02:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJQG0L (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2022 02:26:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D338BA
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665987970; x=1697523970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZSXgG5RSjashEB86Ki2HLpcpKHo+S/SYoPRwz9EFoo=;
  b=OY/aDzVIewVurKbjbVGmk2X4L1V/2sjyNWB4v8cjTLZ045KhaQPbWX0M
   VH/dqzcxXUu5gkd6MzPpys/r6fYXd0eTL+QgJ6aqf3pk6sl5vKRPJpllV
   So5dr0IHbXoci3xAEKZtlhBVW+iF5We6bDrrgizqSeziuKPv9l2A2xynU
   cukKZj3XFMTA7QucNCnLzXQS9tsKl5MDcHgGDqkYp+HKatWVAuiYT61um
   WWGiMb7g3F1yKsjqcn53QYS7AkSSMBYGQIqVIaW2VW9vX464Mn34WA+B2
   iGVwCBQXfGVHX7g/OH8xf2WEBzFYv6BUjL7ZW145RkHNqFlsBqlrlSLgZ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="212316362"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 14:26:09 +0800
IronPort-SDR: do4sKsyI7GeP0AnCslLKpKq2ZkaF4dfQkQb+2dHfjmFHNvJV9KubUR71PnZPHlkhepqOUpSWah
 hwjwsv5l9qcx4+r9iCb4wlEBdwGKWf3jDuTC8oSHqJEM3YgZ2DfAGSh3bQpAwxcmz9qmHjW2NI
 MIod4WAZqVFISQTyaXc7iBizTeGgQ/DKUSf8WaEJLO6Wp4w2PtSiCq/cD8TcaOPaVIJqFEiD5V
 dqgUdgREPFxO5eHKN2dzBKKBk1O//2FgQ6mhS+qCJONQhP8Xd2znfp/AD48gDgJ3AUDmsSswOi
 x+MA4LMeG+PyvArSaBg0AvxO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 22:40:04 -0700
IronPort-SDR: 2F6X0EXBapq7lqzMOmt/ZMUwYKziqs+ViRkY6LqJ4Q4or7TX+9sK9u6+B/cZ0IbQMTQAf/DYW6
 udVTMYGu7Ckw9ypAHygoH90KBcveUaVGE3Iwb1WUoLA1YXYhtCQKNSx58KTdG0LjYkzHcS/ioq
 H3XiYRfxLLDxhKN+0C+btROmEX7HiV788RqW11RNx6VRRMaTjbfPiMsTny3cV8lwWgEHWBupJK
 96SBUETZrlwxlFycnQS0wOIq5LwuE94QClfKEh/8YSPmx93pQZuuy4202ASVDwJLgr5MDvFo5X
 ZXY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 23:26:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrRp90Vznz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 23:26:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1665987962;
         x=1668579963; bh=rZSXgG5RSjashEB86Ki2HLpcpKHo+S/SYoPRwz9EFoo=; b=
        sKXFEb0iyWyj76nhzcf/vDbSLblcLfAEoNzKaHc3nd1Rl5Spe7DkyMM2UpSvNRFd
        /r7HFQ6cMl6P+1pJ2foOFFaku4kGCESQ7oxIeTko5PJZPUCLlqe1QaXg/lJpSlRq
        JYFDKjyXAM/wTL2qlCf3R0f9P/vdGvG1rV06C/TcPEYVh8HPmzCQGX8c/GNFIiPT
        iaYumAXPbMaxBAGY61+5tHnmuZk2/bzivsJDIhxqO6C9Abc0hPUaAiD9WY/cfX3K
        Kv4angfQMnPowOJ988lMWPA6Ty3VTZ4eI2F8GOWONOkEx3pxxdw/vKxy+mF45XVt
        0dV9/Rism48k1MvmwPaPNQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iNSnD_U6-Y59 for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 23:26:02 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrRp14BNkz1RvLy;
        Sun, 16 Oct 2022 23:26:01 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 0/2] Cleanup build dependencies
Date:   Mon, 17 Oct 2022 15:25:57 +0900
Message-Id: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Cleanup build dependencies on CONFIG_OF for the pata_ftide010 and
sata_gemini drivers.

Damien Le Moal (2):
  ata: sata_gemini: Remove dependency on OF for compile tests
  ata: pata_ftide010: Remove build dependency on OF

 drivers/ata/Kconfig         | 3 +--
 drivers/ata/pata_ftide010.c | 2 +-
 drivers/ata/sata_gemini.c   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

--=20
2.37.3

