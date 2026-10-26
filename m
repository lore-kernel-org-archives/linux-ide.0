Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008470;
	b=ObofyTwCKE2OGiQ/Pq7yiLkOLpYRJBh3aMyQluffXvoRDzXQUFIIARc5CmNYyrT87xIS
	 IGCFcgC1/a5i5T0vvz6UtcXBrpLuQlhZMb3dJPG/prTNbEhusxRvwcbOdqPcx6NcU5gIa
	 lMNe+ozmB/ZoT8S6xf4tlj49d2Tq9znfYYL/UZsm+h7OGaokF0G3g7AlnmLQYvRBdnP9v
	 CRtwa/55djKaAODEyDbZGC29RNp91sPTXwdJTOMXy1H8/M0vlyr+BxkAPIFpMEPdxhIQN
	 wH78T/cktsP1M0lK6+eMDWCVcZGmT1yuLAllnfzqH6/ZqZr4DfdTjIC1kUIqdpN0rRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8wmMBFP3qtjQoW09p3O1nesuJW382jh9zthL3JAc5d0=;
	b=XdBm3IPAqVWCqphOWsw+hjkvHln0MGrq71hpRh2X4QSF1ibYoSxXKXVKpW4/7TW0WhrW
	 RKVeHOdvnizQrb8dIgJf8cNkc5XEogJaQ11+7anQWRPkGkl/ckBx22FUygjpKSg8fntiD
	 PNDT5HtQtetc0ojx7tgqJT3U0WMf94aDalFkhHPrbudL4+DnVw4160ZSSepSC+tKAWc9/
	 gKvZT9m9ipj1ayIafkdyTRQxZ6ajOsZKXQuBaO3yWstG82PscNvbmwKaxvqlcrq3dIK67
	 naunbqDZxYvmb6ly8I+JzwvA3EysccCRZKwvEsjgVyJRoF4gxP2avGbVCVKT40trwXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOsKldfP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE6606A32C
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOsKldfP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4A61F031E2;
	Mon, 26 Oct 2026 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008469;
	bh=8wmMBFP3qtjQoW09p3O1nesuJW382jh9zthL3JAc5d0=;
	h=From:To:Cc:Subject:Date;
	b=EOsKldfPbWVIVqp2x0vU8rojRjpo5UQeIEIV6wB6gMz8HGZ/asejracNbusmofQm9
	 w/QI6+ue6T5e69EqEeP2FG0zKVF0MIqqCju9hbW80vWfcPjUgo+fqBo56ve0fTP5Kv
	 G7zAnA9Ygo8P1721QwhmmRsMMctstHRXHy2bniDIgODWSjD+eRPVlzrCkd8DfvO7RT
	 /rmJkgLKil1iSFGHvQ0WYaYljcl6QWatHiOPC2zx5g/Us9gQsMkiUZqWrdIPdMUZSG
	 WKwKO05hb7J0f9X9h+1+cfAiSl881C8LHWYh3QCBJQguTaPFAMKmOkzqZnM/JC+FUo
	 BuPhXsT5u4K2Q==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 7.4-rc1
Date: Mon, 26 Oct 2026 10:54:18 +0100
Message-ID: <20261026095418.3270238-1-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

There is a semantic conflict with the SCSI tree: the merge is clean,
but it does not build. Commit c44f095a9d17 ("scsi: ata: libata: Use
combined sense codes") changed ata_scsi_set_sense() to take a single
combined sense code, and commit 3bab8c7e0c6b ("ata: libata-scsi: abort
multi-sector pass-through commands when multi_count is 0") in this pull
adds a new caller using the old calling convention.

Resolution (same fix as in linux-next):

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3583,7 +3583,8 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		unsigned int multi_count = 1 << (cdb[1] >> 5);
 
 		if (!dev->multi_count) {
-			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0);
+			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
+					   NO_ADDITIONAL_SENSE_INFORMATION);
 			return 1;
 		}
 

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc1

for you to fetch changes up to 69be770908ae57354a41d7e1cc99ab46278d2e86:

  ata: libata-sff: fix race between IRQ deferral and ata_sff_flush_pio_task() (2026-10-22 10:12:24 +0200)

----------------------------------------------------------------
ata changes for 7.4-rc1

 - Make ata_generic refuse to bind to non-IDE devices (me)

 - Add missing <linux/pm_runtime.h> includes (Vladimir)

 - Add pata_cswarp driver for the Amiga CS-Lab Warp card (Paolo)

 - Fix a use-after-free and a parport attach bug in pata_parport (Pei)

 - Switch ahci_da850 to DEFINE_SIMPLE_DEV_PM_OPS() (Li)

 - Documentation and kernel-doc fixes (Karl, Bart, me)

 - Remove the broken sata_inic162x driver (Ethan)

 - Fix probe() error paths in libata, libahci and several drivers (me)

 - Fail probe in sata_dwc_460ex if host activation fails (Nikolay)

 - Use the standard DMA engine API in pata_arasan_cf (Frank)

 - Abort multi-sector pass-through commands when multi_count is 0 (Hui)

 - Replace kmap_atomic() with kmap_local_page() in libata-sff (Danish)

 - Revert the no longer needed JMB582/JMB585 32-bit DMA quirk (Mario)

 - Enable SATA LED presence indication in sata_mv (Carlos)

 - Re-enable FBS after error handling on a port multiplier (Kyrylo)

 - Fix NO_FUA quirks shadowed by earlier quirk entries (me)

 - Do not overwrite the Marvell PATA quirk port mask in ahci (zhoumin)

 - Ignore libata.force transfer modes the host does not support (Rand)

 - Fix a race between IRQ deferral and ata_sff_flush_pio_task() (me)

----------------------------------------------------------------
Bart Van Assche (1):
      ata: libata: Fix scsi_done() documentation

Carlos Junior (1):
      ata: sata_mv: enable SoC SATA LED presence indication

Danish Khateeb (1):
      ata: libata-sff: replace kmap_atomic() with kmap_local_page()

Ethan Nelson-Moore (1):
      ata: sata_inic162x: remove dangerous broken driver

Frank Li (1):
      ata: pata_arasan_cf: use standard DMA engine API

Hui Peng (1):
      ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0

Karl Mehltretter (1):
      ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc

Kyrylo Biryuk (1):
      ata: libahci: re-enable FBS after error handling on a port multiplier

Li Jun (1):
      ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS

Mario Limonciello (1):
      Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"

Niklas Cassel (9):
      ata: ata_generic: Do not bind to devices that are not IDE controllers
      ata: ahci_st: Do not ignore errors when getting the reset controls
      ata: ahci_st: Assert the power down reset in the probe() error path
      ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
      ata: libahci: Free the IRQs when activating a multi-IRQ host fails
      ata: libata: Do not leave ata_host_stop() registered when activation fails
      ata: libata-core: Fix the ata_host_register() kdoc
      ata: libata-core: Fix NO_FUA quirks shadowed by earlier quirk entries
      ata: libata-sff: fix race between IRQ deferral and ata_sff_flush_pio_task()

Nikolay Borisov (1):
      ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails

Paolo Pisati (1):
      ata: pata_cswarp: Add Amiga cslab ata support

Pei Xiao (2):
      ata: pata_parport: Fix use-after-free in new_device_store
      ata: pata_parport: fix parport attach idr_alloc for

Rand Deeb (1):
      ata: libata-core: Ignore forced transfer modes the host does not support

Vladimir Oltean (1):
      ata: add <linux/pm_runtime.h> where missing

zhoumin (1):
      ata: ahci: preserve preset port masks

 Documentation/driver-api/libata.rst     |   4 +-
 drivers/ata/Kconfig                     |  17 +-
 drivers/ata/Makefile                    |   2 +-
 drivers/ata/ahci.c                      |  50 +-
 drivers/ata/ahci_brcm.c                 |   1 +
 drivers/ata/ahci_ceva.c                 |   1 +
 drivers/ata/ahci_da850.c                |   6 +-
 drivers/ata/ahci_qoriq.c                |   1 +
 drivers/ata/ahci_st.c                   |  78 +--
 drivers/ata/ata_generic.c               |  16 +
 drivers/ata/libahci.c                   |  44 +-
 drivers/ata/libahci_platform.c          |   4 +
 drivers/ata/libata-core.c               | 102 +++-
 drivers/ata/libata-scsi.c               |   7 +-
 drivers/ata/libata-sff.c                |  45 +-
 drivers/ata/pata_arasan_cf.c            |   6 +-
 drivers/ata/pata_cswarp.c               | 183 +++++++
 drivers/ata/pata_parport/pata_parport.c |   9 +-
 drivers/ata/sata_dwc_460ex.c            |   5 +-
 drivers/ata/sata_fsl.c                  |  24 +-
 drivers/ata/sata_inic162x.c             | 903 --------------------------------
 drivers/ata/sata_mv.c                   |  10 +-
 drivers/ata/sata_qstor.c                |   8 +-
 include/linux/libata.h                  |   1 +
 24 files changed, 495 insertions(+), 1032 deletions(-)
 create mode 100644 drivers/ata/pata_cswarp.c
 delete mode 100644 drivers/ata/sata_inic162x.c
