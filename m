From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Tue, 6 Sep 2016 12:39:46 -0400
Message-ID: <20160906163946.GB24268@htj.duckdns.org>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33837 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756084AbcIFQjt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2016 12:39:49 -0400
Received: by mail-yw0-f195.google.com with SMTP id j1so2899273ywb.1
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2016 09:39:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1473088905-27670-2-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: dan.j.williamps@intel.com, rrichter@cavium.com, linux-ide@vger.kernel.org

On Mon, Sep 05, 2016 at 05:21:45PM +0200, Christoph Hellwig wrote:
> Use the new pci_alloc_irq_vectors API to allocate MSI-X and MSI vectors.
> The big advantage over the old code is that we can use the same API for
> MSI and MSI-X, and that we don't need to store the MSI-X vector mapping
> in driver-private data structures.
> 
> This first conversion keeps the probe order as-is: MSI-X multi vector,
> MSI multi vector, MSI single vector, MSI-X single vector and last a
> single least legacy interrupt line.  There is one small change of
> behavior: we now check the "MSI Revert to Single Message" flag for
> MSI-X in addition to MSI.
> 
> Because the API to find the Linux IRQ number for a MSI/MSI-X vector
> is PCI specific, but libahaci is bus-agnostic I had to a
> get_irq_vector function pointer to struct ahci_host_priv.  The
> alternative would be to move the multi-vector case of ahci_host_activate
> to ahci.c and just call ata_host_activate directly from the others
> users of ahci_host_activate.

Applied to libata/for-4.9 after pulling in the mainline.

Thanks.

-- 
tejun
