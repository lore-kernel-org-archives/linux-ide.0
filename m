From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: always fall back to single-MSI mode
Date: Mon, 21 Nov 2016 11:08:08 -0500
Message-ID: <20161121160808.GA20883@htj.duckdns.org>
References: <1479474546-4413-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36348 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbcKUQIK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Nov 2016 11:08:10 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so28098553ywb.3
        for <linux-ide@vger.kernel.org>; Mon, 21 Nov 2016 08:08:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1479474546-4413-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: michael@michaelmarley.com, linux-ide@vger.kernel.org

On Fri, Nov 18, 2016 at 02:09:06PM +0100, Christoph Hellwig wrote:
> Don't try to guess what the errors from pci_irq_alloc_vectors mean, as
> that's too fragile.  Instead always try allocating a single vector
> when multi-MSI mode fails.  This makes various intel Desktop and
> Laptop CPUs use MSI again.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Michael Marley <michael@michaelmarley.com>
> Tested-by: Michael Marley <michael@michaelmarley.com>
> Fixes: 0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")

Applied to libata/for-4.9-fixes.

Thanks.

-- 
tejun
