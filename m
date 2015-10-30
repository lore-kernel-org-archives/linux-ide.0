From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/4] ahci per-port msix support
Date: Fri, 30 Oct 2015 17:09:24 -0400
Message-ID: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31715 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030348AbbJ3VPH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2015 17:15:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>

A series of small fixups for achi implementations that provide multiple
msi-x vectors.  The notable changes are needing to maintain support for
the current single-vector msix implementation and disabling threaded
irqs by default.

---

Dan Williams (4):
      ahci: ahci_host_activate: kill IRQF_SHARED
      ahci: cleanup ahci_host_activate_multi_irqs
      ahci: per-port msix support
      ahci: switch from 'threaded' to 'hardirq' interrupt handling


 drivers/ata/ahci.c    |   69 ++++++++++++++++++++++++++++++++---------------
 drivers/ata/ahci.h    |    2 +
 drivers/ata/libahci.c |   72 +++++++++++++++++++++++++++++++++----------------
 3 files changed, 97 insertions(+), 46 deletions(-)
