From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/2] ahci per-port msix support
Date: Sun, 01 Nov 2015 13:43:35 -0500
Message-ID: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbbKAStR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2015 13:49:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Changes since v1 [1]:

1/ Clean up "nvec = min(nvec, n_ports);" statement (Tejun)

2/ Drop threaded interrupt handling option for now.

[1]: http://marc.info/?l=linux-ide&m=144623970817213&w=2


---

A series of small fixups for ahci implementations that provide multiple
msi-x vectors.  The notable changes are needing to maintain support for
the current single-vector msix implementation and disabling threaded
irqs by default.

---

Dan Williams (2):
      ahci: per-port msix support
      ahci: switch from 'threaded' to 'hardirq' interrupt handling


 drivers/ata/ahci.c    |   68 +++++++++++++++++++++++++++++++++----------------
 drivers/ata/ahci.h    |    2 +
 drivers/ata/libahci.c |   44 ++++++++++++++++++++++++++------
 3 files changed, 84 insertions(+), 30 deletions(-)
