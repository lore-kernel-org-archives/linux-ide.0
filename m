From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.16-rc1
Date: Tue, 30 Jan 2018 10:16:16 -0800
Message-ID: <20180130181616.GH1121507@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42558 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752867AbeA3SQU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2018 13:16:20 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Linus.

Nothing too interesting.  Several patches to convert mdelay() to
usleep_range(), removal of unused pata_at32, and other low level
driver specific changes.

Thanks.

The following changes since commit 2dc0b46b5ea30f169b0b272253ea846a5a281731:

  libata: sata_down_spd_limit should return if driver has not recorded sstatus speed (2017-12-04 13:57:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.16

for you to fetch changes up to b3506c7ed216dd2db1f06c2845da45018e2c508d:

  ata: pata_pdc2027x: Replace mdelay with msleep (2018-01-25 07:28:31 -0800)

----------------------------------------------------------------
Arnd Bergmann (1):
      phy: brcm-sata: remove unused variable

Arvind Yadav (1):
      ata_piix: constify pci_bits

Corentin Labbe (1):
      ata: remove pata_at32

Darren Stevens (1):
      libata:pata_atiixp: Don't use unconnected secondary port on SB600

Fengguang Wu (1):
      phy: brcm-sata: fix semicolon.cocci warnings

Florian Fainelli (3):
      ata: ahci_brcm: Avoid clobbering SATA_TOP_CTRL_BUS_CTRL
      phy: brcm-sata: Implement calibrate callback
      ata: ahci_brcm: Recover from failures to identify devices

Hans de Goede (3):
      ahci: Annotate PCI ids for mobile Intel chipsets as such
      ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
      ahci: Allow setting a default LPM policy for mobile chipsets

Jia-Ju Bai (3):
      ata: sata_mv: Replace mdelay with usleep_range in mv_reset_channel
      ata: pata_it821x: Replace mdelay with usleep_range in it821x_firmware_command
      ata: pata_pdc2027x: Replace mdelay with msleep

Mika Westerberg (1):
      ahci: Add Intel Cannon Lake PCH-H PCI ID

 drivers/ata/Kconfig                  |  28 ++-
 drivers/ata/Makefile                 |   1 -
 drivers/ata/ahci.c                   |  94 ++++----
 drivers/ata/ahci.h                   |   3 +
 drivers/ata/ahci_brcm.c              | 120 +++++++++--
 drivers/ata/ata_piix.c               |   2 +-
 drivers/ata/pata_at32.c              | 400 -----------------------------------
 drivers/ata/pata_atiixp.c            |   4 +
 drivers/ata/pata_it821x.c            |   2 +-
 drivers/ata/pata_pdc2027x.c          |   4 +-
 drivers/ata/sata_mv.c                |   2 +-
 drivers/phy/broadcom/phy-brcm-sata.c |  31 +++
 12 files changed, 221 insertions(+), 470 deletions(-)
 delete mode 100644 drivers/ata/pata_at32.c

-- 
tejun
