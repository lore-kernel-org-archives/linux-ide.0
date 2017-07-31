From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.13-rc3
Date: Mon, 31 Jul 2017 08:21:52 -0700
Message-ID: <20170731152152.GB447614@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

libata fixes for v4.13-rc3.  Dan found a really old bug where libata
hotplug code wasn't sanitizing index value from userland and may end
up indexing with a negative number.  It is scary but fortunately can
only be triggered by root.  Other than that, minor fixes.

The following changes since commit af3c8d98508d37541d4bf57f13a984a7f73a328c:

  Merge tag 'drm-for-v4.13' of git://people.freedesktop.org/~airlied/linux (2017-07-09 18:48:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.13-fixes

for you to fetch changes up to 2f60e1ab2f0e148e82cb53c539ad003ffc9b9bd0:

  libata: fix a couple of doc build warnings (2017-07-31 08:03:06 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      ata: fix gemini Kconfig dependencies

Damien Le Moal (1):
      libata: Cleanup ata_read_log_page()

Dan Carpenter (1):
      libata: array underflow in ata_find_dev()

Jonathan Corbet (1):
      libata: fix a couple of doc build warnings

Kefeng Wang (1):
      libata: remove unused rc in ata_eh_handle_port_resume

Simon Horman (1):
      ata: sata_rcar: add gen[23] fallback compatibility strings

 Documentation/devicetree/bindings/ata/sata_rcar.txt | 14 +++++++++++---
 drivers/ata/Kconfig                                 |  4 ++--
 drivers/ata/libata-core.c                           |  6 +++---
 drivers/ata/libata-eh.c                             |  7 +++----
 drivers/ata/libata-scsi.c                           |  6 ++++--
 drivers/ata/sata_rcar.c                             |  8 ++++++++
 include/linux/libata.h                              |  2 +-
 7 files changed, 32 insertions(+), 15 deletions(-)

-- 
tejun
