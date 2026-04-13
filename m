Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601D35028D
	for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094028; cv=none; b=FNFY81t24ppHsy4rLAjenfxgpEOuntE8egpY1LnmPRbI1aHzmN9vF6iMntFMHMachQNUcjxv1j9vKjR5sV5U+w8J2U1m51mKEXcALM5P5/Kfj6qDdrQ79VmS6gQePfm5261EJthbDDEDuCY/0WqLXAIEC+vFFQrPSQQ+jhHQQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094028; c=relaxed/simple;
	bh=DOHOBuDU6l7jBw2LZ4PyDffaa0AsEaAw+WXgLPoN1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAbP87O5b0EAQfCp6dvEfr/XBoTu2XDqS/iRy1DTOUqZMyVc4TVTDQiznpVNETx05Qg1rW/G0Mup//P48plMgf0wYoXd76MZOfMCkhORfpLsE6ECbE8hhNLtWcFer0sYNXU7YkGC2iqaPY0crKKdnj+bnh2rLiHmw2A2zvUO62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqZWOwTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqZWOwTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AC4C2BCAF;
	Mon, 13 Apr 2026 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776094027;
	bh=DOHOBuDU6l7jBw2LZ4PyDffaa0AsEaAw+WXgLPoN1cU=;
	h=From:To:Cc:Subject:Date:From;
	b=KqZWOwTqjDZ8rChMC+5FKfrteFvrSHRlwMHtSZk1edq5JKj79SbvtcFj48Kneic6S
	 ZWj+amyU3wvhANTefbIIw+ITtRy5o5ka2gkTkDLLg/DojeUukn2yPEWcPfxc9IEQCW
	 eRoMMxhpcuFIMAU7F/yZzvOKqbbR+PvCvKGmVt7mSAdyq42yPXk1elMLsKFdKcCq5w
	 K9ban6akr6+J1C6ipqj3zkg8VoiIow9ORnNs2U831e9oana0cbMO+HWCldozr8OGki
	 CLltZRA6fZM3pX1uh/rVt3r8e+/yKttyZpdA63FfMbOaVzd5fWATbYbrq4P2yY3fHa
	 RHqXeS4Nxom5g==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 7.1-rc1
Date: Mon, 13 Apr 2026 17:27:00 +0200
Message-ID: <20260413152700.2656409-1-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e6d7eba23b666d85cacee0643be280d6ce1ebffc:

  ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in() (2026-03-20 09:59:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc1

for you to fetch changes up to 8ebf408e7d463eee02c348a3c8277b95587b710d:

  ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands (2026-04-12 19:57:59 +0200)

----------------------------------------------------------------
ata changes for 7.1-rc1

 - Misc code cleanups related to tag checking and tag command completion
   (Damien)

 - Remove Baikal bt1-ahci DT binding since the upstreaming for this SoC is
   not going to be finalized (Andy)

 - Only call the libata port error handler from the SCSI error handler if
   there were command timeouts or if EH was scheduled for the port
   (Damien)

 - Refactor ata_scsiop_maint_in() to more clearly show that there is only
   one service action implemented for the MAINTENANCE IN command (me)

 - Clean up the handling of sysfs attributes exposed by libata (Heiner)

 - Let libahci_platform use a flexible array member for platform PHYs to
   avoid multiple allocations (Rosen)

 - Do not retry reset if the device has been removed/hot-unplugged (Igor)

 - Add missing newlines to error prints in pata_arasan_cf driver (Haoyu)

 - Use the correct SCSI host byte when completing deferred ATA
   PASS-THROUGH commands, to avoid the SCSI mid-layer from failing the
   commands instead of requeuing (Igor)

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: ahci-dwc: Remove not-going-to-be-supported code for Baikal SoC

Damien Le Moal (6):
      ata: libata-core: improve tag checks in ata_qc_issue()
      ata: libata-sata: simplify ata_sas_queuecmd()
      ata: libata-scsi: simplify ata_scsi_requeue_deferred_qc()
      ata: libata-scsi: make ata_scsi_simulate() static
      ata: libata-scsi: rename and improve ata_qc_done()
      ata: libata-eh: avoid unnecessary calls to ata_scsi_port_error_handler()

Haoyu Lu (1):
      ata: pata_arasan_cf: fix missing newline in dev_err() messages

Heiner Kallweit (6):
      ata: libata-transport: remove redundant dynamic sysfs attributes
      ata: libata-transport: instantiate struct ata_internal statically
      ata: libata-transport: inline ata_attach|release_transport
      ata: libata-transport: use static struct ata_transport_internal to simplify match functions
      ata: libata-transport: split struct ata_internal
      ata: libata-transport: remove static variable ata_scsi_transport_template

Igor Pylypiv (2):
      ata: libata-eh: Do not retry reset if the device is gone
      ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands

Niklas Cassel (2):
      Merge branch 'for-7.0-fixes' into for-7.1
      ata: libata-scsi: refactor ata_scsiop_maint_in()

Rosen Penev (1):
      ata: libahci_platform: use flex array for platform PHYs

 .../devicetree/bindings/ata/baikal,bt1-ahci.yaml   | 115 -----------
 drivers/ata/Kconfig                                |   1 -
 drivers/ata/ahci.h                                 |   3 +-
 drivers/ata/ahci_dwc.c                             |  55 -----
 drivers/ata/libahci_platform.c                     |  33 ++-
 drivers/ata/libata-core.c                          |  20 +-
 drivers/ata/libata-eh.c                            |  30 ++-
 drivers/ata/libata-sata.c                          |  14 +-
 drivers/ata/libata-scsi.c                          | 227 +++++++++++----------
 drivers/ata/libata-transport.c                     | 224 ++++++++------------
 drivers/ata/libata-transport.h                     |   5 +-
 drivers/ata/pata_arasan_cf.c                       |   4 +-
 include/linux/libata.h                             |   4 +-
 13 files changed, 258 insertions(+), 477 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
