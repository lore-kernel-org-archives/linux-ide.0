Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B16360745
	for <linux-ide@vger.kernel.org>; Tue, 16 Jun 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620354; cv=none; b=TpDNIX98VlGng2feY1Qg7dRcZYLy1PYRVvMpZdySoygVdBwIxutqwARGB1xmoUDk+6ha0cBw0WzgedBt3WmTR5AVuNoWQgHH+axdhqqrC3DEuxL39hQVpyYtuOdTx8b+aGQhhJyJpnlN90eTYbK53zVuiKavGCugLnotVfOzBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620354; c=relaxed/simple;
	bh=pG1UGyXN5JyrOok0Ggca7TsHLZZfkf+Vn49G5j+Gzlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OB3i/n+Kzr8TxQHnolxczQpHnalg61odzkQzMWNdo2c88qZpGoYCfWwMF58Z5iNDE7sp+LQJyl9fZEEgmqh6rnLd3B5ON6Ku/5vL96N57cmah0hVrgTe1xoDRtcib7DO6U96+rx0APHFzZ2jPmU6cIsEMtdCZauW6oWIl2ySlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+ro06xZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+ro06xZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC0B1F000E9;
	Tue, 16 Jun 2026 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781620353;
	bh=b8NA5Y1mKCXV9JASLrhlhomEktgPZcRu3wDOjFYQkDA=;
	h=From:To:Cc:Subject:Date;
	b=T+ro06xZdbfrie7m1NBlDumZFq5764iSEjS2sRxX9bIXOuVGSD4IqPpZVEo98YGkE
	 Wg6UYD+r2wjdASGT9mTop9LKZl4K1A8ayckfjyUJ4uD62C3kR41bZttwjMcMnrzJFI
	 5RZqva1donE5w49q1Ej/QhZvaAf+HRqrf8UdO3wkWKbu+q33a9PRsIWJV+DRzXLdmN
	 VjbHGiQHtm2g+xAwItrsPa8KWZ3sL8WXSbVCdIGpS39WlLW1+bJ5evhB+TY85snSFV
	 3x2Au81+J83/9ve9ONAX7fHPcN4LGiFLgLMvdx5Tl+C/vzAS6t+f9cmH/ewL/6LdQB
	 vGxBx0VAbMT/Q==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 7.2-rc1
Date: Tue, 16 Jun 2026 16:32:21 +0200
Message-ID: <20260616143223.1829869-1-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc1

for you to fetch changes up to 21e7b9710a24bd7688c02f136923c89bee2fda5a:

  ata: Use named initializers for pci_device_id arrays (2026-06-12 11:44:30 +0200)

----------------------------------------------------------------
ata changes for 7.2-rc1

 - Bump required Clang version to 23 (Marco)
   NOTE: This commit was merged from an immutable branch from the tip
   tree, and is carried both in the tip tree and the libata tree (with
   the approval of tip maintainers) to avoid dependency problems [0].

 - Add Clang context analysis annotations (Bart)

 - Use the ahci_nr_ports() helper in libahci (me)

 - Fail to probe the ahci driver if the BAR size is smaller than the
   required size to support CAP.NP (Number of Ports) (liyouhong)

 - Move EXPORT_SYMBOL_GPL(ahci_do_softreset) to be just below the
   function definition (Bart)

 - Make ata_scsi_scan_host() schedule hotplug work on the
   system_dfl_long_wq workqueue so that it can benefit from scheduler
   task placement (Marco)

 - Make ata_scsi_port_error_handler() schedule hotplug work on the
   system_dfl_long_wq workqueue, such that the work always uses the same
   workqueue (me)

 - Use devm_platform_get_and_ioremap_resource() in pata_arasan_cf driver
   (Rosen)

 - Fix ata_exec_internal() to only release and acquire the EH mutex if
   the calling function is the one holding the EH mutex (Bart)

 - Use hweight_long() to count the port_map bits (TanZheng)

 - Add COMPILE_TEST support for pata_ep93xx driver (Rosen)

 - Drop unused assignments from pata_isapnp driver (Uwe)

 - Extend existing JMicron PMP quirk to include JMicron JMS562 (Xu)

 - Drop unused assignments of pci_device_id driver data (Uwe)

 - Use named initializers for pci_device_id arrays (Uwe)

[0]: https://lore.kernel.org/all/20260528111518.GJ343181@noisy.programming.kicks-ass.net/

----------------------------------------------------------------
Bart Van Assche (6):
      ata: ahci: Move EXPORT_SYMBOL_GPL(ahci_do_softreset)
      ata: libata: Fix ata_exec_internal()
      ata: libata: Add an argument to ata_eh_reset()
      ata: libata: Document when host->eh_mutex should be held
      ata: libata: Pass ap parameter directly to functions in the issuing path
      ata: Annotate functions in the issuing path with __must_hold()

Marco Crivellari (1):
      ata: libata-scsi: Move long delayed work on system_dfl_long_wq

Marco Elver (1):
      compiler-context-analysis: Bump required Clang version to 23

Niklas Cassel (3):
      ata: libahci: use ahci_nr_ports() helper
      ata: libata-eh: queue hotplug work on the system_dfl_long_wq workqueue
      Merge remote-tracking branch 'tip/locking/context' into for-7.2

Rosen Penev (4):
      ata: pata_arasan_cf: simplify ioremap
      ata: pata_ep93xx: avoid asm on non ARM
      ata: pata_ep93xx: use unsigned long for data
      ata: pata_ep93xx: add COMPILE_TEST support

TanZheng (1):
      ata: ahci: use hweight_long() to count port_map bits

Uwe Kleine-König (The Capable Hub) (3):
      ata: pata_isapnp: Drop unused assignments from pnp_device_id array
      ata: Drop unused assignments of pci_device_id driver data
      ata: Use named initializers for pci_device_id arrays

Xu Rao (1):
      ata: libata-pmp: add JMicron JMS562 quirk

liyouhong (1):
      ata: ahci: fail probe if BAR too small for claimed ports

 Documentation/dev-tools/context-analysis.rst |    2 +-
 drivers/ata/Kconfig                          |    2 +-
 drivers/ata/Makefile                         |    2 +
 drivers/ata/acard-ahci.c                     |    8 +-
 drivers/ata/ahci.c                           | 1654 ++++++++++++++++++++------
 drivers/ata/ahci.h                           |    3 +-
 drivers/ata/ahci_imx.c                       |    1 +
 drivers/ata/ata_piix.c                       |  532 ++++++---
 drivers/ata/libahci.c                        |   11 +-
 drivers/ata/libata-core.c                    |   28 +-
 drivers/ata/libata-eh.c                      |   13 +-
 drivers/ata/libata-pmp.c                     |   12 +-
 drivers/ata/libata-sata.c                    |    3 +-
 drivers/ata/libata-scsi.c                    |   21 +-
 drivers/ata/libata-sff.c                     |    2 +
 drivers/ata/libata.h                         |   21 +-
 drivers/ata/pata_acpi.c                      |    5 +-
 drivers/ata/pata_amd.c                       |   88 +-
 drivers/ata/pata_arasan_cf.c                 |   25 +-
 drivers/ata/pata_artop.c                     |   11 +-
 drivers/ata/pata_atp867x.c                   |    6 +-
 drivers/ata/pata_cmd640.c                    |    4 +-
 drivers/ata/pata_cmd64x.c                    |   11 +-
 drivers/ata/pata_ep93xx.c                    |    7 +-
 drivers/ata/pata_isapnp.c                    |    4 +-
 drivers/ata/pata_jmicron.c                   |    7 +-
 drivers/ata/pata_macio.c                     |   12 +-
 drivers/ata/pata_ninja32.c                   |   14 +-
 drivers/ata/pata_opti.c                      |    7 +-
 drivers/ata/pata_pdc2027x.c                  |   30 +-
 drivers/ata/pata_pdc202xx_old.c              |   13 +-
 drivers/ata/pata_sch.c                       |    2 +-
 drivers/ata/pata_serverworks.c               |   24 +-
 drivers/ata/pata_sis.c                       |    1 -
 drivers/ata/pata_via.c                       |   19 +-
 drivers/ata/pdc_adma.c                       |    3 +-
 drivers/ata/sata_dwc_460ex.c                 |    1 +
 drivers/ata/sata_fsl.c                       |    1 +
 drivers/ata/sata_inic162x.c                  |    1 +
 drivers/ata/sata_mv.c                        |   35 +-
 drivers/ata/sata_nv.c                        |   60 +-
 drivers/ata/sata_promise.c                   |   39 +-
 drivers/ata/sata_qstor.c                     |    4 +-
 drivers/ata/sata_sil.c                       |   15 +-
 drivers/ata/sata_sil24.c                     |   16 +-
 drivers/ata/sata_sis.c                       |   32 +-
 drivers/ata/sata_svw.c                       |   15 +-
 drivers/ata/sata_sx4.c                       |    4 +-
 drivers/ata/sata_uli.c                       |    7 +-
 drivers/ata/sata_via.c                       |   39 +-
 drivers/ata/sata_vsc.c                       |   14 +-
 include/linux/compiler-context-analysis.h    |   30 +-
 include/linux/libata.h                       |   18 +-
 lib/Kconfig.debug                            |    4 +-
 lib/test_context-analysis.c                  |   24 +
 55 files changed, 2161 insertions(+), 806 deletions(-)
