From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_mv: Replacing dma_pool_alloc and memset with a
 single call  dma_pool_zalloc.
Date: Tue, 20 Sep 2016 16:08:23 -0400
Message-ID: <20160920200823.GD17513@htj.duckdns.org>
References: <1474400680-12254-1-git-send-email-harman4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35867 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753696AbcITUIZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2016 16:08:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id v2so1146952ywg.3
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2016 13:08:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1474400680-12254-1-git-send-email-harman4linux@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harman Kalra <harman4linux@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Sep 21, 2016 at 01:14:40AM +0530, Harman Kalra wrote:
> Replacing dma_pool_alloc and memset with a single call to dma_pool_zalloc
> 
> Signed-off-by: Harman Kalra <harman4linux@gmail.com>

Applied to libata/for-4.9.

Thanks.

-- 
tejun
