From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a
 SoC"
Date: Thu, 29 Sep 2016 10:55:25 +0200
Message-ID: <20160929085525.GE11087@mtj.duckdns.org>
References: <1475027172-21012-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33761 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcI2Izg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Sep 2016 04:55:36 -0400
Received: by mail-yb0-f193.google.com with SMTP id e2so1617634ybi.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2016 01:55:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1475027172-21012-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: linux-ide@vger.kernel.org

Hello,

On Wed, Sep 28, 2016 at 09:46:12AM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> This reverts commit 640847298e2b7f19 ("ahci: qoriq: Disable NCQ
> on ls2080a SoC")
> 
> The erratum has been fixed in ls2080a v2.0 and later soc.
> Since ls2080a v1.0 has rarely been released, it can be safely
> reverted.

Hmm... going by the description, I'm not sure whether this is a good
idea.  What's "rarely been released"?  Are there chips out in the
wild?  Can't we blacklist v2.0+ only?

Thanks.

-- 
tejun
