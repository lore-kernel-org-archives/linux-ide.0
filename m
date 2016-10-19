From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: only try to use multi-MSI mode if there is more
 than 1 port
Date: Wed, 19 Oct 2016 13:19:38 -0400
Message-ID: <20161019171938.GC18532@htj.duckdns.org>
References: <1476774052-12662-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36018 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941153AbcJSRTl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2016 13:19:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id e5so1053077ywc.3
        for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2016 10:19:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476774052-12662-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: benisty.e@gmail.com, linux-ide@vger.kernel.org

On Tue, Oct 18, 2016 at 09:00:52AM +0200, Christoph Hellwig wrote:
> We should only try to allocate multiple MSI or MSI-X vectors if the device
> actually has multiple ports.  Otherwise pci_alloc_irq_vectors will return
> a single vector due to n_ports = 1, in which case we shouldn't set the
> AHCI_HFLAG_MULTI_MSI flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixes: 0b9e2988 ("ahci: use pci_alloc_irq_vectors")
> Reported-by: Emmanuel Benisty <benisty.e@gmail.com>
> Tested-by: Emmanuel Benisty <benisty.e@gmail.com>

Applied to libata/for-4.9-fixes.

Thanks.

-- 
tejun
