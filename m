From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: quirk read log on no-name M.2 SSD
Date: Tue, 29 Aug 2017 08:41:48 -0700
Message-ID: <20170829154147.GP491396@devbig577.frc2.facebook.com>
References: <20170828062808.20717-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:37647 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdH2Plw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2017 11:41:52 -0400
Received: by mail-qt0-f181.google.com with SMTP id h15so1195126qta.4
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2017 08:41:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170828062808.20717-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: idosch@mellanox.com, linux-ide@vger.kernel.org

On Mon, Aug 28, 2017 at 08:28:08AM +0200, Christoph Hellwig wrote:
> Ivo reported that reading the log page on his systems fails,
> so quirk it as it won't support ZBC or security protocols.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Ido Schimmel <idosch@mellanox.com>
> Tested-by: Ido Schimmel <idosch@mellanox.com>

Ido, I've reverted this patch in favor of the following one.

 https://marc.info/?l=linux-ide&m=150401053011956&q=raw

Can you please verify whether the above patch works?  You can either
remove the horkage patch and apply the above one or test the following
git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.13-fixes

Thanks.

-- 
tejun
