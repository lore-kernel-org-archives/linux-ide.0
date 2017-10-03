From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.14-rc3
Date: Tue, 3 Oct 2017 06:16:13 -0700
Message-ID: <20171003131613.GE3301751@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35960 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdJCNQR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Oct 2017 09:16:17 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Nothing too interesting.  Arnd's gcc-7 warning fixes that slipped
through the cracks for two release cycles (my bad), and two minor low
level driver updates.

Thanks.

The following changes since commit c0da4fa0d1a54495d6055c009ac46b76d1da2c86:

  Merge tag 'media/v4.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2017-09-07 12:53:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.14-fixes

for you to fetch changes up to d312fefea8387503375f728855c9a62de20c9665:

  ahci: don't ignore result code of ahci_reset_controller() (2017-10-02 12:21:30 -0700)

----------------------------------------------------------------
Ard Biesheuvel (1):
      ahci: don't ignore result code of ahci_reset_controller()

Arnd Bergmann (1):
      ata: avoid gcc-7 warning in ata_timing_quantize

Ville Syrjälä (1):
      ata_piix: Add Fujitsu-Siemens Lifebook S6120 to short cable IDs

 drivers/ata/ahci.c        |  5 ++++-
 drivers/ata/ata_piix.c    |  1 +
 drivers/ata/libata-core.c | 20 ++++++++++----------
 3 files changed, 15 insertions(+), 11 deletions(-)

-- 
tejun
