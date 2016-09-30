From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on
 ls2080a SoC"
Date: Fri, 30 Sep 2016 10:30:02 +0200
Message-ID: <20160930083002.GA29207@mtj.duckdns.org>
References: <1475215993-329-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35890 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbcI3IaM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2016 04:30:12 -0400
Received: by mail-yb0-f195.google.com with SMTP id t5so1339607yba.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2016 01:30:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1475215993-329-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: linux-ide@vger.kernel.org

On Fri, Sep 30, 2016 at 02:13:13PM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> This reverts commit 640847298e2b7f19 ("ahci: qoriq: Disable NCQ
> on ls2080a SoC")
> 
> The erratum has been fixed in ls2080a v2.0 and later soc.
> In reality, customer will not get any ls2080a v1.0 soc. Neither apply
> to any products. So reverting this commit won't create any side effect.
> 
> Blacklisting v2.0 could also be a option, but that needs to check the
> soc version which is not suitable in the driver.
>
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied to libata/for-4.9.

Thanks.

-- 
tejun
