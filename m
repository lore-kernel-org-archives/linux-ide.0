From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.1-rc3
Date: Mon, 11 May 2015 11:14:41 -0400
Message-ID: <20150511151441.GG11388@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34599 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbEKPOp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2015 11:14:45 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

libata fixes for v4.1-rc3.  Rather big for fixes pull.

* SCC controllers never lived to see the light of the day.  Both
  libata and ide drivers removed.

* In some configurations, link power management policy changes
  sometimes cause delayed spurious PHY events which can develop into
  noticeable failures.  This has been reported several times over the
  years.  Gabriele's patches suppress PHY events for a while after LPM
  policy changes which should help most of these failures without
  causing too much problem for hotplug use cases.

* A few controller specific fixes.

Thanks.

The following changes since commit 31f7dc796998d2967e999a0f9229d8a50c7b348d:

  ACPI / battery: Fix doubly added battery on system suspend (2015-04-14 09:03:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.1-fixes

for you to fetch changes up to dbfe8ef5599a5370abc441fcdbb382b656563eb4:

  ahci: avoton port-disable reset-quirk (2015-05-10 11:39:16 -0400)

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: select DW_DMAC in case of SATA_DWC

Dan Williams (1):
      ahci: avoton port-disable reset-quirk

Daniel Axtens (1):
      Remove celleb-only SCC PATA drivers

Gabriele Mazzotta (2):
      libata: Add helper to determine when PHY events should be ignored
      libata: Ignore spurious PHY event on LPM policy change

Martin K. Petersen (1):
      libata: Blacklist queued TRIM on all Samsung 800-series

Peter Griffin (1):
      ata: ahci_st: fixup layering violations / drvdata errors

 drivers/ata/Kconfig       |   10 +-
 drivers/ata/Makefile      |    1 -
 drivers/ata/ahci.c        |  103 ++++-
 drivers/ata/ahci_st.c     |   49 +-
 drivers/ata/libahci.c     |    3 +-
 drivers/ata/libata-core.c |   34 +-
 drivers/ata/libata-eh.c   |    3 +
 drivers/ata/pata_scc.c    | 1110 ---------------------------------------------
 drivers/ide/Kconfig       |    9 -
 drivers/ide/Makefile      |    1 -
 drivers/ide/scc_pata.c    |  887 ------------------------------------
 include/linux/libata.h    |   10 +
 12 files changed, 167 insertions(+), 2053 deletions(-)
 delete mode 100644 drivers/ata/pata_scc.c
 delete mode 100644 drivers/ide/scc_pata.c

-- 
tejun
