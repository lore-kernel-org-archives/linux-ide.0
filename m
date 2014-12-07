From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v3.18-rc7
Date: Sun, 7 Dec 2014 09:07:46 -0500
Message-ID: <20141207140746.GC19034@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:62338 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaLGOHu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2014 09:07:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Three libata fixes for v3.18.  Nothing too interesting.  PCI ID ID and
quirk additions to ahci and an error handling path fix in sata_fsl.

Thanks.

The following changes since commit 9a23c1d6f0f5dbac4c9b73fa6cea7c9ee3d29074:

  ahci: fix AHCI parameters not taken into account (2014-11-04 12:56:25 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.18-fixes

for you to fetch changes up to 2b21ef0aae65f22f5ba86b13c4588f6f0c2dbefb:

  ahci: disable MSI on SAMSUNG 0xa800 SSD (2014-12-04 13:18:55 -0500)

----------------------------------------------------------------
Devin Ryles (1):
      AHCI: Add DeviceIDs for Sunrise Point-LP SATA controller

Dmitry Torokhov (1):
      sata_fsl: fix error handling of irq_of_parse_and_map

Tejun Heo (1):
      ahci: disable MSI on SAMSUNG 0xa800 SSD

 drivers/ata/ahci.c     | 4 ++++
 drivers/ata/sata_fsl.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
tejun
