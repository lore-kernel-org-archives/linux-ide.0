From: Christoph Hellwig <hch@lst.de>
Subject: libahci ->irq_handler vs AHCI_HFLAG_MULTI_MSI
Date: Mon, 17 Oct 2016 21:33:31 +0200
Message-ID: <20161017193331.GA25533@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60659 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758768AbcJQTdc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 17 Oct 2016 15:33:32 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Suman Tripathi <stripathi@apm.com>, Alexander Gordeev <agordeev@redhat.com>, Dan Williams <dan.j.williamps@intel.com>
Cc: linux-ide@vger.kernel.org

Hi all,

did anyone test the AHCI per-port MSI or MSI-X mode recently?

Since commit f070d671 ("libahci: Implement the capability to override the
generic ahci interrupt handler." we reject multi-msi mode when a non-zero
->irq_handler is set, but given that ahci_save_initial_config fills out
->irq_handler long before we call ahci_host_activate I can't think of
a case where it might be non-zero at all.
