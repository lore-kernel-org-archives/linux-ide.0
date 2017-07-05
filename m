From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.13-rc1
Date: Wed, 5 Jul 2017 15:22:59 -0400
Message-ID: <20170705192259.GB26340@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36377 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdGETXC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2017 15:23:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Christoph Hellwig <hch@lst.de>, Minwoo Im <dn3108@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

Hello, Linus.

* Christoph added support for TCG OPAL self encrypting disks.

* Minwoo added support for ATA PASS-THROUGH(32).

* Linus Walleij removed spurious drvdata assignments in some drivers.

* Support for a few new device and other fixes.

Thanks.

The following changes since commit a95cfad947d5f40cfbf9ad3019575aac1d8ac7a6:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-05-15 15:50:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.13

for you to fetch changes up to d80210f25ff0050245556bb8ce84d280d8fa4ca7:

  sd: add support for TCG OPAL self encrypting disks (2017-06-29 10:21:15 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      ata: ftide010: fix resource printing

Arvind Yadav (2):
      ata: pata_octeon_cf: make of_device_ids const.
      ata: sata_rcar: make of_device_ids const.

Bhumika Goyal (1):
      ata: declare ata_port_info structures as const

Christoph Hellwig (6):
      libata: move ata_read_log_page to libata-core.c
      libata: factor out a ata_log_supported helper
      libata: clarify log page naming / grouping
      libata: factor out a ata_identify_page_supported helper
      libata: implement SECURITY PROTOCOL IN/OUT
      sd: add support for TCG OPAL self encrypting disks

Doug Berger (3):
      libata: Add the AHCI_HFLAG_YES_ALPM flag
      libata: Add the AHCI_HFLAG_NO_WRITE_TO_RO flag
      ata: ahci_brcm: Avoid writing to read-only registers

Joe Perches (1):
      libata: Convert bare printks to pr_cont

Linus Walleij (9):
      ata: bf54x: cut drvdata assignment
      ata: ep93xx: cut drvdata assignment
      ata: dwc_460ex: cut drvdata assignment
      ata: rb532_cf: cut drvdata assignment
      ata: samsung_cf: cut drvdata assignment
      ata: sata_fsl: cut drvdata assignment
      ata: Add DT bindings for Faraday Technology FTIDE010
      ata: Add DT bindings for the Gemini SATA bridge
      ata: Add driver for Faraday Technology FTIDE010

Mauro Carvalho Chehab (2):
      libata: fix identation on a kernel-doc markup
      ata: update references for libata documentation

Minwoo Im (3):
      libahci: wrong comments in ahci_do_softreset()
      libata: make the function name in comment match the actual function
      libata: Support for an ATA PASS-THROUGH(32) command.

Ondrej Zary (1):
      sata_via: Enable optional hotplug on VT6420

Shawn Lin (1):
      ahci: Add Device ID for ASMedia 1061R and 1062R

Tejun Heo (1):
      libata: fix build warning from unused goto label

Tycho Andersen (1):
      ata-sff: always map page before data transfer

Yuantian Tang (1):
      ahci: qoriq: add ls1088a platforms support

 .../bindings/ata/cortina,gemini-sata-bridge.txt    |  55 ++
 .../devicetree/bindings/ata/faraday,ftide010.txt   |  38 ++
 MAINTAINERS                                        |   9 +
 drivers/ata/Kconfig                                |  21 +
 drivers/ata/Makefile                               |   2 +
 drivers/ata/acard-ahci.c                           |   2 +-
 drivers/ata/ahci.c                                 |   4 +-
 drivers/ata/ahci.h                                 |   5 +-
 drivers/ata/ahci_brcm.c                            |  12 +-
 drivers/ata/ahci_qoriq.c                           |  14 +
 drivers/ata/ata_piix.c                             |   2 +-
 drivers/ata/libahci.c                              |  14 +-
 drivers/ata/libata-core.c                          | 216 +++++---
 drivers/ata/libata-eh.c                            |  66 +--
 drivers/ata/libata-scsi.c                          | 202 ++++++--
 drivers/ata/libata-sff.c                           |  46 +-
 drivers/ata/libata.h                               |   6 +-
 drivers/ata/pata_bf54x.c                           |   2 -
 drivers/ata/pata_ep93xx.c                          |   1 -
 drivers/ata/pata_ftide010.c                        | 567 +++++++++++++++++++++
 drivers/ata/pata_octeon_cf.c                       |   2 +-
 drivers/ata/pata_pdc2027x.c                        |   2 +-
 drivers/ata/pata_rb532_cf.c                        |   2 -
 drivers/ata/pata_rdc.c                             |   2 +-
 drivers/ata/pata_samsung_cf.c                      |   2 -
 drivers/ata/pata_sch.c                             |   2 +-
 drivers/ata/pdc_adma.c                             |   2 +-
 drivers/ata/sata_dwc_460ex.c                       |   1 -
 drivers/ata/sata_fsl.c                             |   2 -
 drivers/ata/sata_gemini.c                          | 438 ++++++++++++++++
 drivers/ata/sata_gemini.h                          |  21 +
 drivers/ata/sata_inic162x.c                        |   2 +-
 drivers/ata/sata_nv.c                              |   2 +-
 drivers/ata/sata_promise.c                         |   2 +-
 drivers/ata/sata_promise.h                         |   2 +-
 drivers/ata/sata_qstor.c                           |   2 +-
 drivers/ata/sata_rcar.c                            |   2 +-
 drivers/ata/sata_sil.c                             |   2 +-
 drivers/ata/sata_sis.c                             |   2 +-
 drivers/ata/sata_svw.c                             |   2 +-
 drivers/ata/sata_sx4.c                             |   2 +-
 drivers/ata/sata_uli.c                             |   2 +-
 drivers/ata/sata_via.c                             |  25 +-
 drivers/ata/sata_vsc.c                             |   2 +-
 drivers/scsi/sd.c                                  |  53 +-
 drivers/scsi/sd.h                                  |   2 +
 include/linux/ata.h                                |  13 +-
 include/linux/libata.h                             |   3 +-
 include/scsi/scsi_device.h                         |   1 +
 include/scsi/scsi_proto.h                          |   1 +
 50 files changed, 1618 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt
 create mode 100644 drivers/ata/pata_ftide010.c
 create mode 100644 drivers/ata/sata_gemini.c
 create mode 100644 drivers/ata/sata_gemini.h

-- 
tejun
