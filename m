From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: fix nvec check
Date: Thu, 20 Oct 2016 13:41:47 -0400
Message-ID: <20161020174147.GB22743@htj.duckdns.org>
References: <1476976541-14501-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35808 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755505AbcJTRlt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2016 13:41:49 -0400
Received: by mail-yw0-f195.google.com with SMTP id t193so2148036ywc.2
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2016 10:41:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476976541-14501-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: colin.king@canonical.com, linux-ide@vger.kernel.org

On Thu, Oct 20, 2016 at 05:15:41PM +0200, Christoph Hellwig wrote:
> commit 17a51f12 ("ahci: only try to use multi-MSI mode if there is more
> than 1 port") lead to a case where nvec isn't initialized before it's
> used.  Fix this by moving the check into the n_ports conditional.
> 
> Reported-by Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.9-fixes.

Thanks.

-- 
tejun
