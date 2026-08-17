Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C2265606
	for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2026 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939608; cv=none; b=WWMTRNhwM92HaKH/O7xA8AAlNlRpzKDk7sNZ1ioZlmmgKOgtfSwFKJqkQSjFVXQuYIlBfnXY8vGKap/QTZPpmyAQBaSWmVSR2dua9P+qSiCsowgd4pYMaUrXSTwIcCqMUSzWtWMAxQNHbnVMP+5mIKk/074CtLGASkUyDOe8z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939608; c=relaxed/simple;
	bh=UYzrnnBMCCMo9Rn+46RZE+peYTOs0red8aB+jUpwk0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJSYjwFH92BGUnmeUV7x9gfklUyJiZkIJXPpFsUhYsJZ2yzKAxiKTguu1Jk4ROASyjbLu1xAE+geKPSsv83ODqzrHY0mQG5SDoK5Nr4IY/EpG3Kth0wEQtTjynv0Ulzomr84Mu1VVtw2WK7Lsl1cNBYlI7iPi0pY8AyHqCbzRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8sS+0rX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8sS+0rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1421F000E9;
	Mon, 17 Aug 2026 04:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939607;
	bh=dhEDsojqmk14K726rzOmbhkfZ2QStg18FDq3mEtt39A=;
	h=From:To:Cc:Subject:Date;
	b=D8sS+0rXgsMYSGU8Sd0Hk+7LJr9jRqlly6CWPCDSy1TzKr7EErOzcWD5DmK0HYXFI
	 nAFdPqlIEoHlN6bwngMQntoaXbiIIAZG5/8pd2oEu4apo06FJcI+QATTxtqSJ+UPEH
	 4smu2gsyhfch5Fmop8eHPNmQpMvNd+sWwSCMfuLOkFYilxCsVUDaIbvYtb+QJcsKSi
	 gWoohuovLXbj7i+IDUGvE1yK0kM5OH6524CGg0XYuyn1rf2BDevITuGI8MDFXtc87W
	 Krky5veKHD/COn3/aIVcaBki2rgcYBSIm8yeJqaqujgQTeie2IraniPF2fVcAZzWgJ
	 FOgBWQi9spzGg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 7.3
Date: Mon, 17 Aug 2026 13:06:35 +0900
Message-ID: <20260817040635.133736-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3

for you to fetch changes up to 73b6bf3c314ad34a9fd389f84de6e8dbfc204880:

  ata: use named initializers for acpi_device_id (2026-08-04 18:48:43 +0900)

----------------------------------------------------------------
ata changes for 7.3

 - Some code cleanups to rename the function used to identify ZAC
   devices and declare some local functions static (me).

 - Refactoring and improvement of the translation of the SCSI
   REPORT SUPPORTED OPCODES command to allow users access to the entire
   list of supported commands (me).

 - Fix the translation of the WRITE SAME command with UNMAP bit set (DSM
   TRIM) for devices with a sector size larger than 2K and devices that
   support multiple TRIM segments (Niklas).

 - Add support detecting support for and translating the SCSI commands
   related to the storage elements depopulation feature (GET PHYSICAL
   ELEMENT STATUS, REMOVE ELEMENT AND TRUCATE, REMOVE ELEMENT AND MODIFY
   ZONES and RESTORE ELEMENTS AND REBUILD) (me).

 - Improvements to the sata_mv driver probe code (clocks and IRQ
   initialization) (Rosen).

 - Improve resource initialization in the pata_rb532_cf, pata_pxa,
   sata_highbank and ahci_da850 drivers (Rosen).

 - Improve PIO data-in command completions to better hndle slow devices,
   e.g. CF cards (Richard).

 - Improve the DMA channel management using device resources in the
   pata_pxa driver (Rosen).

 - Fix the pata_ep93xx driver to correctly fallback to PIO mode if DMA
   initialization fails (Rosen).

 - Use named initializers to define the match tables of the ahci_xgene,
   ahci_qoriq and ahci_platform drivers (Pawel).

----------------------------------------------------------------
Damien Le Moal (15):
      ata: libata: rename ata_dev_is_zac()
      ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
      ata: libata-scsi: improve service action support in ata_scsi_report_supported_opcodes()
      ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION CODES
      ata: libata-scsi: support the all command format for reporting supported commands
      scsi: scsi_debug: move ASC and ASCQ definitions to scsi_proto.h
      scsi: define depopulation capabilities related service actions
      ata: libata: improve the definition of device flags
      ata: libata-scsi: improve ata_get_xlat_func
      ata: libata-core: detect support for depopulation capabilities
      ata: libata-scsi: add support for the GET PHYSICAL ELEMENT STATUS command
      ata: libata-scsi: add support for the REMOVE ELEMENT AND TRUNCATE command
      ata: libata-scsi: add support for the RESTORE ELEMENTS AND REBUILD command
      ata: libata-scsi: add support for the REMOVE ELEMENT AND MODIFY ZONES command
      ata: libata-eh: make ata_eh_qc_complete() and ata_eh_qc_retry() static

Niklas Cassel (2):
      ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
      ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND

Pan Chuang (1):
      ata: pata_mpc52xx: Remove redundant dev_err()

Pawel Zalewski (The Capable Hub) (1):
      ata: use named initializers for acpi_device_id

Richard Weinberger (1):
      ata: libata-sff: don't busy-wait for PIO data-in command completion

Rosen Penev (8):
      ata: sata_mv: Use platform_get_irq() to get interrupt
      ata: sata_mv: use devm clock helpers
      ata: pata_rb532_cf: use devm_platform_ioremap_resource()
      ata: pata_pxa: use devm_platform_ioremap_resource
      ata: sata_highbank: use devm_platform_ioremap_resource
      ata: ahci_da850: use devm_platform_ioremap_resource()
      ata: pata_pxa: use devres for DMA channel management
      ata: pata_ep93xx: fix PIO fallback when DMA init fails

 drivers/ata/ahci_da850.c    |  17 +-
 drivers/ata/ahci_platform.c |   4 +-
 drivers/ata/ahci_qoriq.c    |   2 +-
 drivers/ata/ahci_seattle.c  |   4 +-
 drivers/ata/ahci_xgene.c    |   6 +-
 drivers/ata/libata-core.c   |  79 ++++-
 drivers/ata/libata-eh.c     |   6 +-
 drivers/ata/libata-scsi.c   | 714 +++++++++++++++++++++++++++++++++++++-------
 drivers/ata/libata-sff.c    |  24 +-
 drivers/ata/libata.h        |   2 +-
 drivers/ata/pata_ep93xx.c   |  30 +-
 drivers/ata/pata_mpc52xx.c  |   4 +-
 drivers/ata/pata_pxa.c      |  52 +---
 drivers/ata/pata_rb532_cf.c |  16 +-
 drivers/ata/sata_highbank.c |  18 +-
 drivers/ata/sata_mv.c       |  52 +---
 drivers/scsi/scsi_debug.c   |  46 ---
 include/linux/ata.h         |  17 ++
 include/linux/libata.h      |  93 +++---
 include/scsi/scsi_proto.h   |  74 +++++
 20 files changed, 915 insertions(+), 345 deletions(-)
