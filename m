Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29BFC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiADK6q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:46 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:38397 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229702AbiADK6q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:46 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNk1Sskz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1641293925;
         x=1643885926; bh=v62NX3AUItkOfCaNY3obshjmT5t/K73UDRuV8F2W0v8=; b=
        lh1nuy/BTWOBZJgKRMAoHSWgY4VCTmOmhQSvCtIoCoe+zW7ny6PgGNOtzo/Ny8l8
        ok6PIafgk1yyeqsR9qPJMkHIl+ihwn1BNRfTUmM8oI42fI7JFbhR1Qjl7hS9Q6rR
        4FbLVUbDpb4wSpmCK1hxg97FWlqxbpsHSU3qvZjYqH3gH2dRi7H4xUdpryEZW5fR
        z4YfYsWwj6in5RXqaGYqk3N7QEVfe+fA79yYmrMe29zrb5mVL9jxHk4YuL8y/T2Y
        2RuSgBV7IN4klGzNm1lRQv2XvOTPUeDXnaOcbEFeA2GOEZkJ7LUejv53pj3VuqyK
        AUFU++cr+RPekBZPC4GSqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EYoIvQpecgKS for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:45 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNj3hpXz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:45 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 00/22] Improve compile test coverage
Date:   Tue,  4 Jan 2022 19:58:21 +0900
Message-Id: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Patches 1 to 18 enable the compilation of all ata drivers that can be
compiled with CONFIG_COMPILE_TEST to improve compile test coverage.
The last 4 patches fix compilation and sparse warnings found by enabling
COMPILE_TEST on a x86_64 host.

Changes from v1:
* Added another sata_fsl warning fix (patch 20)

Damien Le Moal (22):
  ata: sata_fsl: add compile test support
  ata: ahci_brcm: add compile test support
  ata: ahci_da850: add compile test support
  ata: ahci_dm816: add compile test support
  ata: ahci_st: add compile test support
  ata: ahci_mtk: add compile test support
  ata: ahci_mvebu: add compile test support
  ata: ahci_sunxi: add compile test support
  ata: ahci_tegra: add compile test support
  ata: ahci_xgene: add compile test support
  ata: ahci_seattle: add compile test support
  ata: pata_bk3710: add compile test support
  ata: pata_cs5535: add compile test support
  ata: pata_ftide010: add compile test support
  ata: pata_imx: add compile test support
  ata: pata_pxa: add compile test support
  ata: pata_legacy: add compile test support
  ata: pata_samsung_cf: add compile test support
  ata: sata_fsl: fix scsi host initialization
  ata: sata_fsl: fix cmdhdr_tbl_entry and prde struct definitions
  ata: ahci_xgene: use correct type for port mmio address
  ata: ahci_xgene: Fix id array access in xgene_ahci_read_id()

 drivers/ata/Kconfig      | 38 +++++++++++++++++++-------------------
 drivers/ata/ahci_xgene.c |  9 +++++----
 drivers/ata/sata_fsl.c   | 15 +++++++--------
 include/linux/libata.h   | 11 +++++++++++
 4 files changed, 42 insertions(+), 31 deletions(-)

--=20
2.31.1

