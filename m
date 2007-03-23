From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 21:47:04 +0000
Message-ID: <20070323214704.1e8d5463@lxorguk.ukuu.org.uk>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070323112411.f6a8a762.randy.dunlap@oracle.com>
	<20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
	<20070323130315.7ed48121.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54030 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934308AbXCWUnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 16:43:35 -0400
In-Reply-To: <20070323130315.7ed48121.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

> > > What is 0x40?  can it be #defined (or enum-ed) instead of a magic
> > > value?  please?  (more of same below)
> > 
> > It's 0x40. Its a "command dependant bit" - no useful name.
> 
> dependent.  OK, thanks.

IDE is a bit like that. I'm amazed some of the command flags arent in
latin.

> Already corrected (printk types).  And putting
> 					hpa_sectors);
> on a separate line doesn't hurt readability.

Maybe

Thanks for looking over the diff.

Alan
