Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC95196438
	for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133128; cv=none; b=l2TLmLbTKBXoTt6Ci5ooLTveNQ6hwjzX7efDi3fYF6OyMuw5pXZaSCq0Pdgt7Pk+GtYUqYLdOtQNfv7yx5gulWGh7G6YsyS+531c4+P3LqQjJYYANRk8yXdTnXm3D3nSsODOpNK+M7sFigWdc1kDKsJrYmbfsS71qOButrT5ecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133128; c=relaxed/simple;
	bh=NREwO0/4qSBCP4RaEhpacbGoODw+w55RyQ8E3gWrX74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBqSwrqzfNc7Lahgqkj9hFktT1xQZc2MIqzk80c7G0B/GxUCzynXOYr58ieT/qmJ5h4OSbaHXnCdYW0NaRctQog8NqsP0om8Yvde+oE86dhg/JVUpCVG0z06oPxpODsXZlieibOqwPcPonTLGhFlMUdcgiIlPnS3vcm1SyqSNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqIobzUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqIobzUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23886C4AF0D;
	Tue, 16 Jul 2024 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721133128;
	bh=NREwO0/4qSBCP4RaEhpacbGoODw+w55RyQ8E3gWrX74=;
	h=From:To:Cc:Subject:Date:From;
	b=SqIobzUSX9Lxxji26xzYwdSd3xDF8zg4C99nvZ0vIMrZZxifSZdZn+znr0jKSs4Dm
	 tbYV5m4i+VVo09knOOw54zGQXXx6ElHcaTFOenCk5+JTTLs45MhOUijSvYoTCdZ1um
	 eO7OUTzBxbAnqJiL+6w/GSC8bEc9Bm09kJ4r4oHS5bFMxi7/DqUURndXAaFx4tfNPG
	 /VruvRY0eKDLVYmz2UWBANkek24KbuSSY26brjSF4ypXmPRlf8QOKGrdEj4LJSflbK
	 3Bujcxu9XIHmc04GriR0u5V/eF20iB2JafRf2Dbn+SrnpRfbocPOuWF1IyvxY9aBYZ
	 cmTT3LYW+wEnQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.11-rc1
Date: Tue, 16 Jul 2024 14:32:01 +0200
Message-ID: <20240716123201.145960-1-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit eeb25a09c5e0805d92e4ebd12c4b0ad0df1b0295:

  ata: ahci: Clean up sysfs file on error (2024-06-30 22:23:39 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc1

for you to fetch changes up to 6739fad42af2e5eb87417283278a13a57f69c0de:

  dt-bindings: ata: ahci-fsl-qoriq: add fsl,ls1046a-ahci and fsl,ls1012a-ahci (2024-07-12 22:54:33 +0200)

----------------------------------------------------------------
ata changes for 6.11-rc1

 - ATA PASS-THROUGH sense data cleanups and fixes. (from Igor Pylypiv)
   Highlights:

   Store the sense data for ATA PASS-THROUGH commands at the correct offset
   in the sense buffer when using fixed format sense data.

   Cleanup the logic related to generating sense data for PASS-THROUGH
   commands. Generating sense data for PASS-THROUGH commands would
   overwrite any eventual (real) sense data received from the device.

   Honor the D_SENSE bit when generating sense data for PASS-THROUGH
   commands. (The D_SENSE bit can be set by the user, and determines if
   the returned sense data should be in fixed format or descriptor format.)

 - ata port allocation cleanups. (from me)
   Highlights:

   Assign the ata port print_id at port allocation time, such that the
   ata_port_* print functions can be used earlier in the init call chain.

   Change the ata port port print_id to use ida_alloc(), such that
   print_ids will get reused on rmmod + modprobe, instead of being
   incremented indefinitely.

   Remove wrappers that only existed in order to export the internal libata
   functions which they wrapped, and instead export the libata functions
   directly.

 - Update SATA_MOBILE_LPM_POLICY Kconfig default to med_power_with_dipm.
   Using this default was not always a good idea before, because it would
   break hot plug support. However, with LPM changes in recent kernels,
   a port marked as external will not enable LPM (in order to not break hot
   plug), so it is now safe to change the default value of this Kconfig.
   All major Linux distros have had SATA_MOBILE_LPM_POLICY set to
   med_power_with_dipm for quite a long time. (from Mario Limonciello)

 - Convert ahci-fsl-qoriq device tree binding to yaml format.
   (from Frank Li)

----------------------------------------------------------------
Frank Li (2):
      dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format
      dt-bindings: ata: ahci-fsl-qoriq: add fsl,ls1046a-ahci and fsl,ls1012a-ahci

Igor Pylypiv (7):
      ata: libata-scsi: Fix offsets for the fixed format sense data
      ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
      ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error
      ata: libata-scsi: Remove redundant sense_buffer memsets
      ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
      ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
      ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

Mario Limonciello (1):
      ata: Kconfig: Update SATA_MOBILE_LPM_POLICY default to med_power_with_dipm

Niklas Cassel (10):
      Merge remote-tracking branch 'libata/for-6.10-fixes' into for-6.11
      ata,scsi: Remove wrappers ata_sas_tport_{add,delete}()
      ata: libata: Remove unused function declaration for ata_scsi_detect()
      ata: libata-core: Remove support for decreasing the number of ports
      ata: libata-sata: Remove superfluous assignment in ata_sas_port_alloc()
      ata: libata-core: Remove local_port_no struct member
      ata: libata: Assign print_id at port allocation time
      ata: libata-core: Reuse available ata_port print_ids
      ata,scsi: Remove wrapper ata_sas_port_alloc()
      ata: ahci: Add debug print for external port

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |  21 ---
 .../devicetree/bindings/ata/fsl,ahci.yaml          |  64 +++++++
 drivers/ata/Kconfig                                |   2 +-
 drivers/ata/ahci.c                                 |   4 +-
 drivers/ata/libahci.c                              |  12 +-
 drivers/ata/libata-core.c                          |  49 +++--
 drivers/ata/libata-sata.c                          |  49 -----
 drivers/ata/libata-scsi.c                          | 209 ++++++++++++---------
 drivers/ata/libata-transport.c                     |   5 +-
 drivers/ata/libata-transport.h                     |   3 -
 drivers/ata/libata.h                               |   2 -
 drivers/scsi/libsas/sas_ata.c                      |  22 +--
 drivers/scsi/libsas/sas_discover.c                 |   2 +-
 include/linux/libata.h                             |  11 +-
 14 files changed, 230 insertions(+), 225 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,ahci.yaml
