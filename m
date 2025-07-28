Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C69461
	for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2025 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682935; cv=none; b=sEnCkEqHULNdOQAmy12yAa5G7VlDD8ryOxrpzABuPdAQivEq2A/H2nwRvYEpgi802eB83GvhDi1m6Fx8Gov/xnfe2WDCWJKn7O2OPklHNwQ6mLvjNPUXLvxVmKf4MgLoxtEXmNiH1RP11rrG/iL+1SMCjxctiUj74Oa5aJif8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682935; c=relaxed/simple;
	bh=TXJdiIY6w7n86cirf48VeHVyb8IeCx1WVIreeUwGHq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5dIQqvBt6ZEgBAxFrFUQonVlhpi7lglUUdu22Jy5/SoOglJJUOHEBKK0Wadieixx2ku1WRwBJeCQiOLXXAmQPV06MeG6oRBfCj8kbYccw+0+4fIlwzS5fXB0XT21MoUu4v3bER/KI/gifkcFdNMJ4tqHuJRxUp+NrOG0v/sxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC9/PKWO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC9/PKWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17343C4CEE7;
	Mon, 28 Jul 2025 06:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753682934;
	bh=TXJdiIY6w7n86cirf48VeHVyb8IeCx1WVIreeUwGHq4=;
	h=From:To:Cc:Subject:Date:From;
	b=KC9/PKWOAh2RwrbQjar3M4EcABSCvRDEgtlM1mY+N0U5C3wfCwjK4EiZiOoJ8XfcW
	 9PMZ6Fq/hAQ74+agoaIP7vFVFZlqQ0foszjUj3L1DuWZzUDQUJa+j/VU4rd6ML+mDM
	 WAtuzdLjy/QLDoGD79Vndy0MOLi0+UsHv31DrA9V8wUYhCGnrhJGppVNcD0+Ly0H3/
	 YMivR6RQOjWK74B3V9WtMrlpWpywaHAH82MySdnpyPhWZEnCcfWdgGYNaTbrCj/pvf
	 ZTg3x2SiGRX0M2iwmSDTWmTHV6ONsWVzsC2v0Ma5GVauzZCvuiFcpmbvvGtv91ylnG
	 NGNn2KFZdLCuA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.17-rc1
Date: Mon, 28 Jul 2025 15:06:23 +0900
Message-ID: <20250728060623.187416-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc1

for you to fetch changes up to 546527b92d7e72dcd827675a2d3e580002b09cc1:

  Documentation: driver-api: Update libata error handler information (2025-07-16 09:31:43 +0200)

----------------------------------------------------------------
ata changes for 6.17-rc1

 - Replace the ATA_DFLAG_ZAC device flag with the helper function
   ata_dev_is_zac() testing directly the device class and device zoned
   mode (me).

 - Some small cleanup of ata_scsi_offline_dev() code (me).

 - Improve the description of the link power management (LPM) policies
   in Kconfig and in the comments defining these. Together with this,
   clarify the description of the ahci driver mobile_lpm_policy module
   parameter (me).

 - Various code refactoring of libata LPM handling (ata_eh_set_lpm()
   renaming, introduce ata_dev_config_lpm(), LPM related quirk handling,
   and LPM related feature advertizing on device scan) (me).

 - Avoid unnecessary device reset when revalidating after an error when
   LPM is used (me).

 - Do not allow setting a port/link LPM policy if LPM is not supported,
   either because the controller does not support partial, slumber nor
   devsleep, or when the port is an external port with hotplug
   capability (me).

 - Make sure that device initiated power management (DIPM) is not
   enabled if the host (controller) lacks support for this feature (me).

 - Improve messages and debug messages related to LPM, in particular,
   reduce the number of messages signaling the lack of LPM support (me).

 - Cache in memory a device general purpose log directory to avoid
   having to access this log for every log page access. The intent here
   is to reduce the number of read log commands when scanning or
   revalidating a device (me).

 - Change ata_dev_cleanup_cdl_resources() to be a static function (me).

 - Rename and simplify the mode setting functions (me).

 - Introduce the helper function ata_port_eh_scheduled() to check if EH
   is pending or running for a port (me)

 - Improve ata_eh_set_pending() (return bool instead of int) (me).

 - Use sysfs_emit() instead of scnprintf() for libata-transport
   attributes (Jonathan).

 - Use the existing macro definiton of RDC vendor ID instead of
   hardcoding it in the pata_rdc driver (Andy).

 - Rework how EH is called for a port to avoid needing to pass along the
   prereset, softreset, hardreset and postreset operations. The
   driver API documentation for this is also updated  (me).

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: pata_rdc: Use registered definition for the RDC vendor

Damien Le Moal (26):
      ata: libata: Remove ATA_DFLAG_ZAC device flag
      ata: libata-scsi: Cleanup ata_scsi_offline_dev()
      ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
      ata: libata: Improve LPM policies description
      ata: ahci: Clarify mobile_lpm_policy description
      ata: libata-eh: Move and rename ata_eh_set_lpm()
      ata: libata-core: Introduce ata_dev_config_lpm()
      ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()
      ata: libata-core: Advertize device support for DIPM and HIPM features
      ata: libata-eh: Avoid unnecessary resets when revalidating devices
      ata: libata-sata: Disallow changing LPM state if not supported
      ata: ahci: Disable DIPM if host lacks support
      ata: ahci: Disallow LPM policy control for external ports
      ata: ahci: Disallow LPM policy control if not supported
      ata: libata-core: Reduce the number of messages signaling broken LPM
      ata: libata_eh: Add debug messages to ata_eh_link_set_lpm()
      ata: libata-core: Cache the general purpose log directory
      ata: libata-core: Make ata_dev_cleanup_cdl_resources() static
      ata: libata-eh: Rename and make ata_set_mode() static
      ata: libata-core: Rename ata_do_set_mode()
      ata: libata: Introduce ata_port_eh_scheduled()
      ata: libata-eh: use bool for fastdrain in ata_eh_set_pending()
      ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
      ata: libata-eh: Remove ata_do_eh()
      ata: libata-eh: Simplify reset operation management
      Documentation: driver-api: Update libata error handler information

Jonathan Velez (1):
      ata: libata-transport: replace scnprintf with sysfs_emit for simple attributes

 Documentation/driver-api/libata.rst     |  25 +-
 drivers/ata/Kconfig                     |  36 ++-
 drivers/ata/ahci.c                      |  25 +-
 drivers/ata/ahci_da850.c                |   6 +-
 drivers/ata/ahci_dm816.c                |   2 +-
 drivers/ata/ahci_imx.c                  |  13 +-
 drivers/ata/ahci_qoriq.c                |   4 +-
 drivers/ata/ahci_xgene.c                |   8 +-
 drivers/ata/ata_piix.c                  |   4 +-
 drivers/ata/libahci.c                   |  10 +-
 drivers/ata/libata-core.c               | 137 +++++++---
 drivers/ata/libata-eh.c                 | 433 ++++++++++++++++----------------
 drivers/ata/libata-pmp.c                |  26 +-
 drivers/ata/libata-sata.c               |   7 +-
 drivers/ata/libata-scsi.c               |  25 +-
 drivers/ata/libata-sff.c                |  18 +-
 drivers/ata/libata-transport.c          |   4 +-
 drivers/ata/libata.h                    |  24 +-
 drivers/ata/pata_acpi.c                 |   2 +-
 drivers/ata/pata_ali.c                  |  10 +-
 drivers/ata/pata_amd.c                  |   4 +-
 drivers/ata/pata_artop.c                |   4 +-
 drivers/ata/pata_atiixp.c               |   2 +-
 drivers/ata/pata_efar.c                 |   2 +-
 drivers/ata/pata_ep93xx.c               |   4 +-
 drivers/ata/pata_hpt366.c               |   2 +-
 drivers/ata/pata_hpt37x.c               |   4 +-
 drivers/ata/pata_hpt3x2n.c              |   2 +-
 drivers/ata/pata_icside.c               |   2 +-
 drivers/ata/pata_it8213.c               |   2 +-
 drivers/ata/pata_jmicron.c              |   2 +-
 drivers/ata/pata_marvell.c              |   2 +-
 drivers/ata/pata_mpiix.c                |   2 +-
 drivers/ata/pata_ns87410.c              |   2 +-
 drivers/ata/pata_octeon_cf.c            |   2 +-
 drivers/ata/pata_oldpiix.c              |   2 +-
 drivers/ata/pata_opti.c                 |   2 +-
 drivers/ata/pata_optidma.c              |   6 +-
 drivers/ata/pata_parport/pata_parport.c |   4 +-
 drivers/ata/pata_pcmcia.c               |   4 +-
 drivers/ata/pata_pdc2027x.c             |   4 +-
 drivers/ata/pata_rdc.c                  |   6 +-
 drivers/ata/pata_sis.c                  |   2 +-
 drivers/ata/pata_sl82c105.c             |   2 +-
 drivers/ata/pata_triflex.c              |   2 +-
 drivers/ata/pata_via.c                  |   2 +-
 drivers/ata/pdc_adma.c                  |   2 +-
 drivers/ata/sata_dwc_460ex.c            |   2 +-
 drivers/ata/sata_fsl.c                  |   6 +-
 drivers/ata/sata_highbank.c             |   2 +-
 drivers/ata/sata_inic162x.c             |   2 +-
 drivers/ata/sata_mv.c                   |  10 +-
 drivers/ata/sata_nv.c                   |   2 +-
 drivers/ata/sata_promise.c              |   4 +-
 drivers/ata/sata_qstor.c                |   4 +-
 drivers/ata/sata_rcar.c                 |   2 +-
 drivers/ata/sata_sil.c                  |   2 +-
 drivers/ata/sata_sil24.c                |   8 +-
 drivers/ata/sata_svw.c                  |   4 +-
 drivers/ata/sata_sx4.c                  |   2 +-
 drivers/ata/sata_uli.c                  |   2 +-
 drivers/ata/sata_via.c                  |   4 +-
 drivers/scsi/libsas/sas_ata.c           |   4 +-
 include/linux/libata.h                  |  54 ++--
 64 files changed, 565 insertions(+), 444 deletions(-)
