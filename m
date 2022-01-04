Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69613C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiADJFM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:12 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:17495 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229884AbiADJFL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:11 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsg1qYwz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1641287110;
         x=1643879111; bh=B4Lnf2JtsfvDLYoHF6Ucaod9B/PgS3lvS3U49Ruhn/M=; b=
        CYYedQZfnXyfmYw0Mr9UPtPkIW9gBEZ90ehoPH92cwb8bgCW4sfRYaIOtpL3WTpK
        BH/OOWbt/EMtSbE8uEd+V3+On7OCytR6e3iJg+sFvRzcBPPq/dtBleJQtSj8TvJF
        +rwpC1A0EcasK9dLE0eCxItKzVTMRkwaeD6E33LP0kTZGH135ekjHif2vjZyH0vp
        5BGhpP3FQsbNfBTsZDh5wqrQRkf2lyTxVns8cbFs2PU3raY+nRc4uTfkwvGze7hX
        BkIDMljeO1Ewg9gCjkF8tRaDgfVzImmvOn1LLmSNcdttpUn3By7QqpNl73DBZOND
        R/Rnckv7K3jL4RTuu6yWKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fG0LcUczMc1h for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsd6wlgz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 00/21] Improve compile test coverage                    
Date:   Tue,  4 Jan 2022 18:04:47 +0900
Message-Id: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Patches 1 to 18 enable the compilation of all ata drivers that can be  =20
compiled with CONFIG_COMPILE_TEST to improve compile test coverage.    =20
The last 3 patches fix compilation and sparse warnings found by enabling
COMPILE_TEST on a x86_64 host.

Damien Le Moal (21):
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
  ata: ahci_xgene: use correct type for port mmio address
  ata: ahci_xgene: Fix id array access in xgene_ahci_read_id()

 drivers/ata/Kconfig      | 38 +++++++++++++++++++-------------------
 drivers/ata/ahci_xgene.c |  9 +++++----
 drivers/ata/sata_fsl.c   |  3 +--
 include/linux/libata.h   | 11 +++++++++++
 4 files changed, 36 insertions(+), 25 deletions(-)

--=20
2.31.1

