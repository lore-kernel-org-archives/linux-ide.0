From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 0/2] ahci per-port msix support
Date: Wed, 11 Nov 2015 16:27:27 -0800
Message-ID: <20151112002727.37012.65672.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21269 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbbKLA14 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Nov 2015 19:27:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: kernel test robot <ying.huang@linux.intel.com>, Ricardo Neri <ricardo.neri@intel.com>, linux-ide@vger.kernel.org

Changes since v2 [1]:

1/ Fix the thinko of converting "nvec" to an "unsigned int".  Doing that
   caused us to skip the "if (nvec < 0)" at the top of ahci_init_msix().
   This lead to messages like "ahci 0000:00:1f.2: failed to enable MSI-X
   with error -22, # of vectors: 3" as reported by 0day.

2/ Deleted ahci_port_thread_fn() and ahci_multi_irqs_intr() given ahci
   is now hardirq only.

[1]: http://marc.info/?l=linux-ide&m=144640375930878&w=2

---
A series of small fixups for ahci implementations that provide multiple
msi-x vectors.  The notable changes are needing to maintain support for
the current single-vector msix implementation and disabling threaded
irqs by default.

---

Dan Williams (2):
      ahci: per-port msix support
      ahci: switch from 'threaded' to 'hardirq' interrupt handling


 drivers/ata/ahci.c    |   67 +++++++++++++++++++++++++++++++++----------------
 drivers/ata/ahci.h    |    2 +
 drivers/ata/libahci.c |   51 +++++++++++++++----------------------
 3 files changed, 68 insertions(+), 52 deletions(-)
