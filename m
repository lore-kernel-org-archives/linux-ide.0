Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2011D6BB
	for <linux-ide@vger.kernel.org>; Fri, 13 Feb 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770942577; cv=none; b=TdwTtun3M7PLXf0N17ApWbMVhjaXA62EoVDGdG5jL3j6RJlikfsrZEjbUobaCbDbPSnZJdAgbtj0x4jlSH/pFsbLvpT74HlBlMZqsmkQuTcUX2xiy9mM4yQ1As2oapc9bdam2S++zopTvxgrbLZc2pFDxeh0/nxC8EmJfJfoEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770942577; c=relaxed/simple;
	bh=H9/IL1IvR+0UblqqJ+x6UV7ZR5/tmUpsYX4D2qGJ8Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdYFvM7/ETgjQSFPdERSiP/C1dSyWWfJI/K4rtUq69JHj8MATt6wjahCraHdOxBQ2GwCbcmGLOmOTcTGQT7mOf3Jin9eWxOyzI2+lkb2xrbHgqWaqt2wJRJwpu0QbnutCCJZCylJdh7Fgu6zNpmhJP6fDq5nrYx/tnnogwlO44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k95DgSu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k95DgSu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C922C4CEF7;
	Fri, 13 Feb 2026 00:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770942576;
	bh=H9/IL1IvR+0UblqqJ+x6UV7ZR5/tmUpsYX4D2qGJ8Wg=;
	h=From:To:Cc:Subject:Date:From;
	b=k95DgSu9/hDPl8ZVpHv8tcT2pxILVdA8S5aiQWoGgz3WojFtZqR3p531S81Q4i0mr
	 k+v4Klr7N2SFk3+DpXK2juain6rCYGnnhsB+Lbo9AJQFDGa6XoBYOGRu+nZjGgjkfq
	 GnZI3YmHoxg/9dO4KvSnRjLO5IRgqWG61K64zUt0t26FZlYtMG0qebUeubLlFSB+0H
	 gcmhVs2LFVg3RwZllCWkXyzG/gJ8AHUr7Qs4Fzc6OeU4mUygfHwl8kW4atqSkaSso3
	 0HO2ow24GGeUn4k67VYHitiQhFsg8/Nnl5mL4ascHJp3GoPoxKB/8/FmR4f1dbcLqI
	 ZKaXt5B2eV7lw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.20-rc1
Date: Fri, 13 Feb 2026 09:24:25 +0900
Message-ID: <20260213002425.113971-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.20-rc1

for you to fetch changes up to ff4a46c278ac6a4b3f39be1492a4568b6dcc6105:

  ata: pata_ftide010: Fix some DMA timings (2026-02-04 12:23:23 +0100)

Note that this pull request generates a conflict with the scsi changes. This
conflict is starightforward to resolve. Here is the resulotion applied to
linux-next by Mark Brown:

diff --cc drivers/ata/libata.h
index 9b4e578ad07ec,0e48bd1c0c206..0000000000000
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@@ -165,9 -164,8 +165,10 @@@ extern int ata_scsi_user_scan(struct Sc
  void ata_scsi_sdev_config(struct scsi_device *sdev);
  int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
  		struct ata_device *dev);
- int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
+ enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
+ 					struct ata_device *dev);
 +void ata_scsi_deferred_qc_work(struct work_struct *work);
 +void ata_scsi_requeue_deferred_qc(struct ata_port *ap);

  /* libata-eh.c */
  extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);


----------------------------------------------------------------
ATA changes for 6.20

 - Cleanup IRQ masking in the handling of completed report zones
   commands (Niklas).

 - Improve the handling of Thunderbolt attached devices to speed up
   device removal (Henry).

 - Several patches to generalize the existing max_sec quirks to
   facilitates quirking the maximum command size of buggy drives, many
   of which have recently showed up with the recent increase of the
   default max_sectors block limit (Niklas).

 - Cleanup the ahci-platform and sata dt-bindings schema (Rob,
   Manivannan).

 - Improve device node scan in the ahci-dwc driver (Krzysztof).

 - Remove clang W=1 warnings with the ahci-imx and ahci-xgene drivers
   (Krzysztof).

 - Fix a long standing potential command starvation situation with
   non-NCQ commands issued when NCQ commands are on-going (me).

 - Limit max_sectors to 8191 on the INTEL SSDSC2KG480G8 SSD (Niklas).

 - Remove Vesa Local Bus (VLB) support in the pata_legacy driver
   (Ethan).

 - Simple fixes in the pata_cypress (typo) and pata_ftide010 (timing)
   drivers (Ethan, Linus W.)

----------------------------------------------------------------
Damien Le Moal (2):
      ata: libata-scsi: refactor ata_scsi_translate()
      ata: libata-scsi: avoid Non-NCQ command starvation

Ethan Nelson-Moore (2):
      ata: pata_legacy: remove VLB support
      ata: pata_cypress: fix typo in error message

Henry Tseng (1):
      ata: libata: avoid long timeouts on hot-unplugged SATA DAS

Krzysztof Kozlowski (3):
      ata: ahci-dwc: Simplify with scoped for each OF child loop
      ata: ahci-imx: Fix Wvoid-pointer-to-enum-cast warning
      ata: ahci-xgene: Fix Wvoid-pointer-to-enum-cast warning

Linus Walleij (1):
      ata: pata_ftide010: Fix some DMA timings

Manivannan Sadhasivam (1):
      dt-bindings: ata: sata: Document the graph port

Niklas Cassel (8):
      ata: libata-scsi: Remove superfluous local_irq_save()
      ata: libata: Add ATA_QUIRK_MAX_SEC and convert all device quirks
      ata: libata: Add ata_force_get_fe_for_dev() helper
      ata: libata: Change libata.force to use the generic ATA_QUIRK_MAX_SEC quirk
      ata: libata: Add support to parse equal sign in libata.force
      ata: libata: Add libata.force parameter max_sec
      ata: libata: Allow more quirks
      ata: libata-core: Quirk INTEL SSDSC2KG480G8 max_sectors

Rob Herring (Arm) (1):
      dt-bindings: ata: ahci-platform: Drop unnecessary select schema

 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 .../devicetree/bindings/ata/ahci-platform.yaml     |  20 -
 .../devicetree/bindings/ata/sata-common.yaml       |   3 +
 drivers/ata/Kconfig                                |  17 +-
 drivers/ata/ahci_dwc.c                             |  10 +-
 drivers/ata/ahci_imx.c                             |   2 +-
 drivers/ata/ahci_xgene.c                           |   2 +-
 drivers/ata/libata-core.c                          | 237 ++++--
 drivers/ata/libata-eh.c                            |   9 +-
 drivers/ata/libata-scsi.c                          | 182 ++++-
 drivers/ata/libata.h                               |   3 +
 drivers/ata/pata_cypress.c                         |   2 +-
 drivers/ata/pata_ftide010.c                        |   6 +-
 drivers/ata/pata_legacy.c                          | 867 +--------------------
 include/linux/ata.h                                |   3 -
 include/linux/libata.h                             |  73 +-
 16 files changed, 402 insertions(+), 1039 deletions(-)
