Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFDC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 30 Oct 2023 06:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjJ3Gky (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Oct 2023 02:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjJ3Gkw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Oct 2023 02:40:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0FA10CA
        for <linux-ide@vger.kernel.org>; Sun, 29 Oct 2023 23:40:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58FCC433C7;
        Mon, 30 Oct 2023 06:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698648039;
        bh=HUrXK7qJRE3J/7hUkvMGZXdzQXDuT1coz5lNVosndV4=;
        h=From:To:Subject:Date:From;
        b=f9GVFu9IYeWFhzQUHKEHvoqCRBZ6TVJP9NWIsArZv1Qn1atEzxPedHQLqZroivmqy
         efFVL+PnCoYqqSDxSJl0kWUQqvPz3KhU6DgmvTopx5g0iiLSXEL3QDCop/yw2WwPPF
         Rj+gEhEdfXF7L2ZUxEPJQGycIHCkHy1rFefdeLu3x+cExkGc3Ts6f9yvICWysS8j4L
         zFMv4gvzZ//ttx76RBkk12Nu+lI8G/dWOV4026DtRn+TSuL5XO3HtAIoglxG2NJVjT
         zn/VvQ/j7wvNnVYokZ/g2DE3V7RXEgkyjhc9VEjEjeKFjRmAKr5o4FdOUnBTkwGWG5
         RMpRLL8ROQQdg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.7-rc1
Date:   Mon, 30 Oct 2023 15:40:37 +0900
Message-ID: <20231030064037.282268-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc1

for you to fetch changes up to 0e533cba38011457b51f13b3b5afd33c693bfcca:

  dt-bindings: ata: tegra: Disallow undefined properties (2023-10-18 08:07:30 +0900)

----------------------------------------------------------------
ATA changes for 6.7-rc1

 - Modify the AHCI driver to print the link power management policy used
   on scan, to help with debugging issues (Niklas).

 - Add support for the ASM2116 series adapters to the AHCI driver
   (Szuying).

 - Prepare libata for the coming gcc and Clang __counted_by attribute
   (Kees).

 - Following the recent estensive fixing of libata suspend/resume
   handling, several patches further cleanup and improve disk power state
   management (from me).

 - Reduce the verbosity of some error messages for non-fatal temporary
   errors, e.g. slow response to device reset when scanning a port, and
   warning messages that are in fact normal, e.g. disabling a device
   on suspend or when removing it (from me).

 - Cleanup DMA helper functions (from me).

 - Fix sata_mv drive handling of potential errors durring probe (Ma).

 - Cleanup the xgene and imx drivers using the functions
   of_device_get_match_data() and device_get_match_data() (Rob).

 - Improve the tegra driver device tree (Rob).

----------------------------------------------------------------
Damien Le Moal (14):
      scsi: Remove scsi device no_start_on_resume flag
      ata: libata-scsi: Cleanup ata_scsi_start_stop_xlat()
      ata: libata-core: Synchronize ata_port_detach() with hotplug
      ata: libata-core: Detach a port devices on shutdown
      ata: libata-core: Remove ata_port_suspend_async()
      ata: libata-core: Remove ata_port_resume_async()
      ata: libata-core: Do not poweroff runtime suspended ports
      ata: libata-core: Do not resume runtime suspended ports
      ata: libata-sata: Improve ata_sas_slave_configure()
      ata: libata-eh: Improve reset error messages
      ata: libata-eh: Reduce "disable device" message verbosity
      ata: libata: Cleanup inline DMA helper functions
      ata: libata-eh: Spinup disk on resume after revalidation
      ata: libata-core: Improve ata_dev_power_set_active()

Kees Cook (1):
      ata: libata: Annotate struct ata_cpr_log with __counted_by

Ma Ke (1):
      ata: sata_mv: aspeed: fix value check in mv_platform_probe()

Mika Westerberg (1):
      ata: ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list

Niklas Cassel (1):
      ata: ahci: print the lpm policy on boot

Rob Herring (3):
      ata: xgene: Use of_device_get_match_data()
      ata: imx: Use device_get_match_data()
      dt-bindings: ata: tegra: Disallow undefined properties

Szuying Chen (1):
      ata: ahci: add identifiers for ASM2116 series adapters

 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml |   2 +-
 drivers/ata/ahci.c                                 |   6 +
 drivers/ata/ahci_imx.c                             |  10 +-
 drivers/ata/ahci_xgene.c                           |  11 +-
 drivers/ata/libahci.c                              |   2 +-
 drivers/ata/libata-core.c                          | 185 +++++++++++++--------
 drivers/ata/libata-eh.c                            |  54 +++---
 drivers/ata/libata-sata.c                          |   5 +-
 drivers/ata/libata-scsi.c                          |  53 +-----
 drivers/ata/libata-sff.c                           |  10 +-
 drivers/ata/libata.h                               |   2 +
 drivers/ata/pata_cs5520.c                          |   2 +-
 drivers/ata/sata_mv.c                              |   9 +-
 drivers/scsi/sd.c                                  |   9 +-
 include/linux/libata.h                             |  25 +--
 include/scsi/scsi_device.h                         |   1 -
 16 files changed, 201 insertions(+), 185 deletions(-)
