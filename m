From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [git patches] libata fixes
Date: Wed, 28 Mar 2007 17:33:09 -0400
Message-ID: <460ADF15.4060803@redhat.com>
References: <20070328073219.GA26024@havoc.gtf.org>	<460A1A3D.6050501@garzik.org>	<Pine.LNX.4.64.0703281346060.6730@woody.linux-foundation.org> <20070328141539.353203a1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbXC1VdP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 17:33:15 -0400
In-Reply-To: <20070328141539.353203a1.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Andrew Morton wrote:
> 
> There is another metric to look at, too: the number of fixes which are
> going into 2.6.x.y.  If that fix count is high, and if those fixes fix bugs
> which were not present in 2.6.x-1 then this is an indication that something
> is wrong - many regressions are sneaking through the -rc process.
> 
> And I haven't run the numbers, but I get the impression that 2.6.20.x has
> an unusually large number of fixes in it.

That could be because people are getting better at actually fixing bugs
in the previous release. :)

