Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B3C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiAEFRk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:40 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:14990 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236195AbiAEFRk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:40 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmh2v2Pz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1641359859;
         x=1643951860; bh=+f2KgKCRg4NfbU2UmB2nvT0EVwUiF2bPJkS3Jh+hk9g=; b=
        uQRWlQdgSeYUx5NoV+03LH75DBZkdZG3T3SNMKqH3NcN7vsMNAqrOR6TebGadpxo
        2Yn7OsrB/HA0+3JAK23/yhI7zbSVlDHZuGnkh+CCN0c/22ZRbyS7jySe1ovlsWk8
        ZZWu+cSw5zqSzEniJuefpiXwQO5equIMMIpF4AuADEzSRYYwF97A0W1aDgFgx5ti
        prg/hgdiX/z9UI5CZnbec4iHa9tGGdoAhGt/7/1VN7FMawZ3NqbxP58OVUR1mR7Y
        Poa/w+ThRdy5aDtUA15ucSYUDGxXTLoJd+Hrgg5PL54mQjpJNZ9+LuStnkS9T+hj
        OxS8lV3wIf1Qvowf2HVCCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lyDD_eBAltfn for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:39 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmg1fp2z1VSkV;
        Tue,  4 Jan 2022 21:17:39 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 00/22] Improve compile test coverage
Date:   Wed,  5 Jan 2022 14:17:13 +0900
Message-Id: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
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

Changes from v2:
* Change patch 22 to fix read_id() port operation interface instead
* Added review tags

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
  ata: fix read_id() ata port operation interface

 drivers/ata/Kconfig        | 38 +++++++++++++++++++-------------------
 drivers/ata/ahci_brcm.c    |  2 +-
 drivers/ata/ahci_ceva.c    |  5 ++---
 drivers/ata/ahci_xgene.c   |  8 ++++----
 drivers/ata/libata-core.c  |  6 +++---
 drivers/ata/pata_it821x.c  | 23 +++++++++++------------
 drivers/ata/pata_netcell.c |  5 +++--
 drivers/ata/sata_fsl.c     | 23 +++++++++++------------
 include/linux/libata.h     | 16 ++++++++++++++--
 9 files changed, 68 insertions(+), 58 deletions(-)

--=20
2.31.1

