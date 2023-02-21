Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F3C636D7
	for <linux-ide@archiver.kernel.org>; Tue, 21 Feb 2023 23:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBUXaa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Feb 2023 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBUXaa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2023 18:30:30 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391C422C
        for <linux-ide@vger.kernel.org>; Tue, 21 Feb 2023 15:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677022228; x=1708558228;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5panhx7ve5sAPrrCWdWE7yXnYLTh/No/p3pJFA+juWY=;
  b=GIs/PHaGvuAdFmTCdIcKG/wr/ugPT1BUvrpsep1DAAqAIkZqoXq2QiZb
   k/ArADj43ap2wVD1biaBeAuAGPSxo0K8rpf8cpPEz0qE/WFrrhts6/X7m
   XVItxPD4zb1buoVaRlzRURPzVVRukjAiQTh5sW1nuOdsWWF0acPHz0CRq
   b8XEdjAI89ve7D4Sm4WAtiH2DmtbcCHUn36InxFaHyn8Z8YliYRnDnPGO
   ItlIR/RDln/Xh8WLia/VX3cf5BFib9fGtCMCBoE4YTe5rp+MNN9vBum+f
   pNOnyBB40RkmMl2Ews2TQAs6LH/+zQ7rWHpvA3bY0v9ip1kmVmUCKBoCc
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,317,1669046400"; 
   d="scan'208";a="222138873"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 07:30:27 +0800
IronPort-SDR: e4r6VB+gKNX6SqUVf9zGVJjpfJuwwchmat0xZ3W/KvIxaH91NdXYjhgRTxeUE50XkB860LNAna
 oKBaa8HM5o3JcqDdgkk5HRHs6JCfuKjginGnYRrEFXtF712smUcCZD/NTdwz7LghGGqtu6wdn7
 pr1Tf+WvauePt6isAW64eAhXaWZODbjatZbgjB/Kiq4NJcxvoUvHit8s4mf/EY8OsLkeIA0NeN
 ErhCwJ+McOlEGhekZevAFhNtqVVaZXV1AfjwITXTbDW84rkhXmxPHZgMKlq1mfSmhRFRfuWzwg
 7E8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 14:47:26 -0800
IronPort-SDR: L4GjZb0wnINBG6/7X9Wq9ki5nzYZilcuXu8d6TSaAFN3aZmuahm3ayMvJUtHLHq/e+9ReKDgqw
 cQvkn1hFoixu3yG2x7jqJfnQ9mL/eSIhsO02huWhp0ZfsMN0DxulMgx+EkQB+/P2xAnGXi5JOh
 HjZPVXevSO+eDFmJxae5YpgEBshDCghmbeQhVKWdD8cTfzjjcAgaXQ5yk7kA3xPmRIbI9BeTQo
 UbMb3K3lnPa1qyr7XNR/Km2pQMkI1ZiMBseZ+9timSV5esDBeSmeuGP2XgYU5nfBia5bQh8Vmj
 s10=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 15:30:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PLwWR2s8zz1RvTp
        for <linux-ide@vger.kernel.org>; Tue, 21 Feb 2023 15:30:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
         t=1677022226; x=1679614227; bh=5panhx7ve5sAPrrCWdWE7yXnYLTh/No/
        p3pJFA+juWY=; b=slDHP1ZFE31e2nqZFocGwfY0OdZW2LsE2XX1TvU3IS9iiblL
        tfgV0C6lJ1eIevl0AutXIqghazlP3dTFcFcOrcLmzuPcYZP2BEe9DdKlknTCbgxA
        FhhGf+arFN/gJI9tsi4Ur8cGD+7yWY5d208ki5yKI+WJUPhbCea5xD54IRPSF1FY
        gTH2N5MDgbKvX3nwAXmhfUfXkXqMX8uJ+vzvKaaYTp2iMoJUmaLSI7f5Z0YFdP2H
        NqZaVCmLfsxHMdIkQCzEpBvgqqasJR0ebc5SFr8xsQgjWxLVRt8i8N4LoOP/2WkL
        FqA1Z4kFLMQtYparaNFpTQBz+/Hf2WUQIysoVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PfWD-GIbmCkV for <linux-ide@vger.kernel.org>;
        Tue, 21 Feb 2023 15:30:26 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PLwWQ3BVyz1RvLy;
        Tue, 21 Feb 2023 15:30:26 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.3-rc1
Date:   Wed, 22 Feb 2023 08:30:24 +0900
Message-Id: <20230221233024.927877-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f=
98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.3-rc1

for you to fetch changes up to 8844f0aa8dc42f54dc278c8d4ecbf32e92f2d6f1:

  ata: pata_parport: Fix ida_alloc return value error check (2023-02-07 0=
8:59:35 +0900)

----------------------------------------------------------------
ATA changes for 6.3-rc1

  * Small cleanup of the pata_octeon driver to drop a useless platform
    callback, from Uwe.

  * Simplify ata_scsi_cmd_error_handler() code using the fact that
    ap->ops->error_handler is NULL most of the time, from Wenchao.

  * Several patches improving libata error handling. This is in
    preparation for supporting the command duration limits (CDL)
    feature. The changes allow handling corner cases of ATA NCQ errors
    which do not happen with regular drives but will be triggered with
    CDL drives. From Niklas.

  * Simplify the qc_fill_rtf operation, from me.

  * Improve SCSI command translation for the
    REPORT_SUPPORTED_OPERATION_CODES command, from me.

  * Cleanup of libata FUA handling. This falls short of enabling FUA for
    ATA drives that support it by default as there were concerns that
    old drives would break. The series howeverfixes several issues with
    the FUA support to ensure that FUA is reported as being supported
    only for drives that can handle all possible write cases (NCQ and
    non-NCQ). A check in the block layer is also added to ensure that we
    never see read FUA commands (current behavior). From me.

  * Several patches to move the old PARIDE (parallel port IDE) driver to
    libata as pata_parport. Given that this driver also needs protocol
    modules, the driver code resides in its own pata_parport directoy
    under drivers/ata. From Ondrej.

----------------------------------------------------------------
Christoph Hellwig (1):
      block: add a sanity check for non-write flush/fua bios

Damien Le Moal (7):
      ata: libata: simplify qc_fill_rtf port operation interface
      ata: libata-scsi: improve ata_scsiop_maint_in()
      ata: libata: Introduce ata_ncq_supported()
      ata: libata: Rename and cleanup ata_rwcmd_protocol()
      ata: libata: cleanup fua support detection
      ata: libata: Fix FUA handling in ata_build_rw_tf()
      ata: libata: exclude FUA support for known buggy drives

Niklas Cassel (5):
      ata: scsi: rename flag ATA_QCFLAG_FAILED to ATA_QCFLAG_EH
      ata: libata: read the shared status for successful NCQ commands onc=
e
      ata: libata: respect successfully completed commands during errors
      ata: libata: move NCQ related ATA_DFLAGs
      ata: libata-scsi: do not overwrite SCSI ML and status bytes

Ondrej Zary (4):
      ata: pata_parport: add driver (PARIDE replacement)
      drivers/block: Remove PARIDE core and high-level protocols
      drivers/block: Move PARIDE protocol modules to drivers/ata/pata_par=
port
      ata: pata_parport: Fix ida_alloc return value error check

Uwe Kleine-K=C3=B6nig (1):
      ata: octeon: Drop empty platform remove function

Wenchao Hao (1):
      ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()

 Documentation/admin-guide/blockdev/paride.rst      |  388 ++-----
 Documentation/admin-guide/kernel-parameters.rst    |    1 -
 Documentation/admin-guide/kernel-parameters.txt    |   19 +-
 MAINTAINERS                                        |    7 -
 block/blk-core.c                                   |   14 +-
 drivers/Makefile                                   |    1 -
 drivers/ata/Kconfig                                |   14 +
 drivers/ata/Makefile                               |    2 +
 drivers/ata/acard-ahci.c                           |    8 +-
 drivers/ata/ahci_octeon.c                          |    6 -
 drivers/ata/libahci.c                              |  171 +++-
 drivers/ata/libata-core.c                          |   81 +-
 drivers/ata/libata-eh.c                            |  117 +--
 drivers/ata/libata-sata.c                          |    7 +-
 drivers/ata/libata-scsi.c                          |   41 +-
 drivers/ata/libata-sff.c                           |   10 +-
 drivers/ata/libata-trace.c                         |    2 +-
 drivers/ata/pata_parport/Kconfig                   |  141 +++
 drivers/ata/pata_parport/Makefile                  |   19 +
 drivers/{block/paride =3D> ata/pata_parport}/aten.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/bpck.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/bpck6.c |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/comm.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/dstr.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/epat.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/epia.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/fit2.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/fit3.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/friq.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/frpw.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/kbic.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/ktti.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/on20.c  |    2 +-
 drivers/{block/paride =3D> ata/pata_parport}/on26.c  |    2 +-
 drivers/ata/pata_parport/pata_parport.c            |  761 ++++++++++++++
 .../{block/paride =3D> ata/pata_parport}/ppc6lnx.c   |    0
 drivers/ata/sata_fsl.c                             |    5 +-
 drivers/ata/sata_inic162x.c                        |   14 +-
 drivers/ata/sata_promise.c                         |    2 +-
 drivers/ata/sata_sil24.c                           |    7 +-
 drivers/ata/sata_sx4.c                             |    2 +-
 drivers/block/Kconfig                              |   29 -
 drivers/block/paride/Kconfig                       |  302 ------
 drivers/block/paride/Makefile                      |   29 -
 drivers/block/paride/Transition-notes              |  128 ---
 drivers/block/paride/mkd                           |   31 -
 drivers/block/paride/paride.c                      |  479 ---------
 drivers/block/paride/paride.h                      |  172 ----
 drivers/block/paride/pcd.c                         | 1042 --------------=
-----
 drivers/block/paride/pd.c                          | 1032 --------------=
-----
 drivers/block/paride/pf.c                          | 1057 --------------=
------
 drivers/block/paride/pg.c                          |  734 --------------
 drivers/block/paride/pseudo.h                      |  102 --
 drivers/block/paride/pt.c                          | 1024 --------------=
-----
 drivers/scsi/ipr.c                                 |   11 +-
 drivers/scsi/libsas/sas_ata.c                      |   11 +-
 include/linux/libata.h                             |   61 +-
 include/linux/pata_parport.h                       |  111 ++
 58 files changed, 1483 insertions(+), 6742 deletions(-)
 create mode 100644 drivers/ata/pata_parport/Kconfig
 create mode 100644 drivers/ata/pata_parport/Makefile
 rename drivers/{block/paride =3D> ata/pata_parport}/aten.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/bpck.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/bpck6.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/comm.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/dstr.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/epat.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/epia.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/fit2.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/fit3.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/friq.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/frpw.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/kbic.c (99%)
 rename drivers/{block/paride =3D> ata/pata_parport}/ktti.c (98%)
 rename drivers/{block/paride =3D> ata/pata_parport}/on20.c (98%)
 rename drivers/{block/paride =3D> ata/pata_parport}/on26.c (99%)
 create mode 100644 drivers/ata/pata_parport/pata_parport.c
 rename drivers/{block/paride =3D> ata/pata_parport}/ppc6lnx.c (100%)
 delete mode 100644 drivers/block/paride/Kconfig
 delete mode 100644 drivers/block/paride/Makefile
 delete mode 100644 drivers/block/paride/Transition-notes
 delete mode 100644 drivers/block/paride/mkd
 delete mode 100644 drivers/block/paride/paride.c
 delete mode 100644 drivers/block/paride/paride.h
 delete mode 100644 drivers/block/paride/pcd.c
 delete mode 100644 drivers/block/paride/pd.c
 delete mode 100644 drivers/block/paride/pf.c
 delete mode 100644 drivers/block/paride/pg.c
 delete mode 100644 drivers/block/paride/pseudo.h
 delete mode 100644 drivers/block/paride/pt.c
 create mode 100644 include/linux/pata_parport.h
