From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 21:51:40 +0000
Message-ID: <20070323215140.6a79868c@lxorguk.ukuu.org.uk>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070323112411.f6a8a762.randy.dunlap@oracle.com>
	<20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
	<20070323.122232.85421062.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44475 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992567AbXCWUsS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 16:48:18 -0400
In-Reply-To: <20070323.122232.85421062.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Fri, 23 Mar 2007 12:22:32 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date: Fri, 23 Mar 2007 20:08:19 +0000
> 
> > u64 is always unsigned long long (and its debug anyway)
> 
> It's plain "unsigned long" on sparc64 and some other 64-bit platforms.

I stand corrected. In which case Randy is right and I do need to go fix
that formatting.

Thanks

Alan
