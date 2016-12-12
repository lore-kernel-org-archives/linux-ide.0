From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] libata changes for v4.10-rc1
Date: Mon, 12 Dec 2016 11:04:02 -0800
Message-ID: <20161212190402.GA8592@infradead.org>
References: <20161212183209.GE13864@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34935 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbcLLTED (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2016 14:04:03 -0500
Content-Disposition: inline
In-Reply-To: <20161212183209.GE13864@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 12, 2016 at 01:32:09PM -0500, Tejun Heo wrote:
> Hello, Linus.
> 
> * Adam added opt-in ATA command priority support.
> 
> * There are machines which hide multiple nvme devices behind an ahci
>   BAR.  Dan Williams proposed a solution to force-switch the mode but
>   deemed too hackishd.  People are gonna discuss the proper way to
>   handle the situation in nvme standard meetings.  For now, detect and
>   warn about the situation.

I wish that was the case.  We've pretty much agreed that we'll want
to implement it as a virtual PCIe root bridge, similar to Intels other
"innovation" VMD that we work around that way.  But Intel management
has apparently decided that they don't want to spend more cycles on
this now that Lenovo has an optional BIOS that doesn't force this
broken mode anymore, and no one outside of Intel has enough information
to implement something like this.

So for now I guess this warning is it, until Intel reconsideres and
spends resources on fixing up the damage their Chipset people caused.
