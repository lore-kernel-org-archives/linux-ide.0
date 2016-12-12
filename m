From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] libata changes for v4.10-rc1
Date: Mon, 12 Dec 2016 14:27:37 -0500
Message-ID: <20161212192737.GI13864@htj.duckdns.org>
References: <20161212183209.GE13864@htj.duckdns.org>
 <20161212190402.GA8592@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36637 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbcLLT1i (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2016 14:27:38 -0500
Content-Disposition: inline
In-Reply-To: <20161212190402.GA8592@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 12, 2016 at 11:04:02AM -0800, Christoph Hellwig wrote:
> I wish that was the case.  We've pretty much agreed that we'll want
> to implement it as a virtual PCIe root bridge, similar to Intels other
> "innovation" VMD that we work around that way.  But Intel management
> has apparently decided that they don't want to spend more cycles on
> this now that Lenovo has an optional BIOS that doesn't force this
> broken mode anymore, and no one outside of Intel has enough information
> to implement something like this.
> 
> So for now I guess this warning is it, until Intel reconsideres and
> spends resources on fixing up the damage their Chipset people caused.

Dang, ah well, this is it then.

Thanks for explaining the situation.

-- 
tejun
