Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE4CEB64D7
	for <linux-ide@archiver.kernel.org>; Tue, 27 Jun 2023 00:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjF0AhB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Jun 2023 20:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjF0AhA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2023 20:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F0EAB
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2023 17:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC6460FBC
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2023 00:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A02AC433C0;
        Tue, 27 Jun 2023 00:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687826218;
        bh=O6jRcozmFPChe9MpvzmhMrBauC6eEghEYTAaokyhiX0=;
        h=From:To:Subject:Date:From;
        b=cpn0bLvu6klehwhjmkqg2kckoJ6gFqgq323/sjsjbRNUVm5VIyuSCrv2QGm8VuXNV
         Uw1uyhJbcYQsWv9ltYkLMyr3/SNGHR30zVo4BHtrjeXZXVzCN7GjVTLrA4/dTYShAR
         eA1ja0Nm+5TXSWvLYyEaea/7lOE76nL/47vON5Nos7jZIV7PyjmO3wc30yYwepKaba
         TQ5+jP7OrLueEM+RtFyQqTYuWbBITKZ0FSg2C7f+MsMzR7ZootuPsUrzEje29y0ZSL
         +IMEDtIZ0TZadqxnefSqacULAJgSUyYSZpcTjrKxHhArYqgYcmC7hT3/gt+ygIXceK
         5ZIUXmHAP1rgg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.5-rc1
Date:   Tue, 27 Jun 2023 09:36:56 +0900
Message-Id: <20230627003656.1963466-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc1

for you to fetch changes up to fd3ac6e8049799ca7dbd2738de8e149536e92a5e:

  dt-bindings: phy: rockchip: rk3588 has two reset lines (2023-06-23 09:33:53 +0900)

----------------------------------------------------------------
ata changes for 6.5-rc1

 - Add support for the .remove_new callback to the ata_platform code to
   simplify device removal interface (Uwe).

 - Code simplification in ata_dev_revalidate() (Yahu)

 - Fix code indentation and coding style in the pata_parport protocol
   modules to avoid warnings from static code analyzers (me)

 - Clarify ata_eh_qc_retry() behavior with better comments (Niklas)

 - Simplify and improve ata_change_queue_depth() behavior to have a
   consistent behavior between libsas managed devices and libata managed
   devices (e.g. AHCI connected devices) (me).

 - Cleanup libata-scsi and libata-eh code to use the ata_ncq_enabled()
   and ata_ncq_supported() helpers instead of open coding flags tests
   (me)

 - Cleanup ahci_reset_controller() code (me).

 - Change the pata_octeon_cf and sata_svw drivers to use
   of_property_read_reg() to simplify the code (Rob, me).

 - Remove unnecessary include files from ahci_octeon driver (me)

 - Modify the DesignWare ahci dt bindings to add support for the
   Rockchip RK3588 AHCI (Sebastian).

----------------------------------------------------------------
Damien Le Moal (22):
      ata: pata_parport: Fix bpck module code indentation and style
      ata: pata_parport: Fix frpw module code indentation and style
      ata: pata_parport: Fix aten module code indentation and style
      ata: pata_parport: Fix bpck6 module code indentation and style
      ata: pata_parport: Fix comm module code indentation and style
      ata: pata_parport: Fix dstr module code indentation and style
      ata: pata_parport: Fix epat module code indentation and style
      ata: pata_parport: Fix epia module code indentation and style
      ata: pata_parport: Fix fit2 module code indentation and style
      ata: pata_parport: Fix fit3 module code indentation and style
      ata: pata_parport: Fix friq module code indentation and style
      ata: pata_parport: Fix kbic module code indentation and style
      ata: pata_parport: Fix ktti module code indentation and style
      ata: pata_parport: Fix on20 module code indentation and style
      ata: pata_parport: Fix on26 module code indentation and style
      ata: libata-sata: Simplify ata_change_queue_depth()
      ata: libata-sata: Improve ata_change_queue_depth()
      ata: libata-eh: Use ata_ncq_enabled() in ata_eh_speed_down()
      ata: libata-scsi: Use ata_ncq_supported in ata_scsi_dev_config()
      ata: ahci: Cleanup ahci_reset_controller()
      ata: pata_octeon_cf: Add missing header include
      ata: ahci_octeon: Remove unnecessary include

Niklas Cassel (1):
      ata: libata-eh: Clarify ata_eh_qc_retry() behavior at call site

Rob Herring (1):
      ata: Use of_property_read_reg() to parse "reg"

Sebastian Reichel (3):
      dt-bindings: ata: dwc-ahci: add PHY clocks
      dt-bindings: ata: dwc-ahci: add Rockchip RK3588
      dt-bindings: phy: rockchip: rk3588 has two reset lines

Uwe Kleine-König (1):
      ata: libata: Make ata_platform_remove_one return void

Yahu Gao (1):
      ata: libata-core: Simplify if condition in ata_dev_revalidate()

 .../devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 124 ++++++
 .../bindings/ata/snps,dwc-ahci-common.yaml         |   8 +-
 .../devicetree/bindings/ata/snps,dwc-ahci.yaml     |  13 +-
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  |  34 +-
 drivers/ata/ahci_brcm.c                            |   6 +-
 drivers/ata/ahci_ceva.c                            |   2 +-
 drivers/ata/ahci_da850.c                           |   2 +-
 drivers/ata/ahci_dm816.c                           |   2 +-
 drivers/ata/ahci_dwc.c                             |   2 +-
 drivers/ata/ahci_imx.c                             |   2 +-
 drivers/ata/ahci_mtk.c                             |   2 +-
 drivers/ata/ahci_mvebu.c                           |   2 +-
 drivers/ata/ahci_octeon.c                          |   1 -
 drivers/ata/ahci_platform.c                        |   2 +-
 drivers/ata/ahci_qoriq.c                           |   2 +-
 drivers/ata/ahci_seattle.c                         |   2 +-
 drivers/ata/ahci_st.c                              |   2 +-
 drivers/ata/ahci_sunxi.c                           |   2 +-
 drivers/ata/ahci_tegra.c                           |   2 +-
 drivers/ata/ahci_xgene.c                           |   2 +-
 drivers/ata/libahci.c                              |  61 ++-
 drivers/ata/libata-core.c                          |  10 +-
 drivers/ata/libata-eh.c                            |  21 +-
 drivers/ata/libata-sata.c                          |  50 ++-
 drivers/ata/libata-scsi.c                          |   2 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   2 +-
 drivers/ata/pata_octeon_cf.c                       |  27 +-
 drivers/ata/pata_of_platform.c                     |   2 +-
 drivers/ata/pata_parport/aten.c                    | 103 ++---
 drivers/ata/pata_parport/bpck.c                    | 466 ++++++++++++---------
 drivers/ata/pata_parport/bpck6.c                   |  67 +--
 drivers/ata/pata_parport/comm.c                    | 238 ++++++-----
 drivers/ata/pata_parport/dstr.c                    | 285 +++++++------
 drivers/ata/pata_parport/epat.c                    | 320 +++++++-------
 drivers/ata/pata_parport/epia.c                    | 442 +++++++++----------
 drivers/ata/pata_parport/fit2.c                    | 131 +++---
 drivers/ata/pata_parport/fit3.c                    | 206 ++++-----
 drivers/ata/pata_parport/friq.c                    | 292 ++++++-------
 drivers/ata/pata_parport/frpw.c                    | 322 +++++++-------
 drivers/ata/pata_parport/kbic.c                    | 314 +++++++-------
 drivers/ata/pata_parport/ktti.c                    |  85 ++--
 drivers/ata/pata_parport/on20.c                    | 149 ++++---
 drivers/ata/pata_parport/on26.c                    | 414 +++++++++---------
 drivers/ata/pata_platform.c                        |   2 +-
 drivers/ata/sata_highbank.c                        |   2 +-
 drivers/ata/sata_svw.c                             |   8 +-
 drivers/scsi/libsas/sas_scsi_host.c                |   3 +-
 include/linux/libata.h                             |   6 +-
 48 files changed, 2317 insertions(+), 1927 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml
