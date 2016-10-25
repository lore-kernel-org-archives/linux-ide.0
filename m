From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: fix the single MSI-X case in ahci_init_one
Date: Tue, 25 Oct 2016 11:43:56 -0400
Message-ID: <20161025154356.GA7026@htj.duckdns.org>
References: <1477397074-26799-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:37061 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbcJYPn7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2016 11:43:59 -0400
Received: by mail-yb0-f177.google.com with SMTP id 205so793986ybg.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2016 08:43:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1477397074-26799-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org, rrichter@cavium.com, ddaney.cavm@gmail.com

On Tue, Oct 25, 2016 at 02:04:34PM +0200, Christoph Hellwig wrote:
> We need to make sure hpriv->irq is set properly if we don't use per-port
> vectors, so switch from blindly assigning pdev->irq to using
> pci_irq_vector, which handles all interrupt types correctly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Robert Richter <robert.richter@cavium.com>
> Tested-by: Robert Richter <robert.richter@cavium.com>
> Tested-by: David Daney <ddaney.cavm@gmail.com>
> Fixes: 0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")

Applied to libata/for-4.9-fixes.

Thanks.

-- 
tejun
