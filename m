From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3 2.6.24-git] PPC/LIBATA: Select HAVE_PATA_PLATFORM
	for ARCH_PPC
Date: Sat, 2 Feb 2008 18:23:43 -0600
Message-ID: <20080203002343.GA1372@lixom.net>
References: <20080202162133.678366209@fluff.org.uk> <20080202162232.212855590@fluff.org.uk> <20080202191239.GA29039@lixom.net> <20080202194102.GJ26792@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:58122 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765907AbYBCAXH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Feb 2008 19:23:07 -0500
Content-Disposition: inline
In-Reply-To: <20080202194102.GJ26792@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com, linuxppc-dev@ozlabs.org

On Sat, Feb 02, 2008 at 07:41:02PM +0000, Ben Dooks wrote:
> On Sat, Feb 02, 2008 at 01:12:39PM -0600, Olof Johansson wrote:
> > On Sat, Feb 02, 2008 at 04:21:36PM +0000, Ben Dooks wrote:
> > > Use the new HAVE_PATA_PLATFORM to select PATA_PLATFORM
> > > driver.
> > > 
> > > CC: linuxppc-dev@ozlabs.org
> > > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > 
> > What tree is this against? It doesn't apply to current mainline nor
> > jgarzik's libata-dev upstream branch.
> 
> It is a series that i've just sent to the linux-ide list, only the ppc
> part was cc'd to the ppc list.

D'oh. Ok, makes more sense now.

Are you planning on adding HAVE_PATA_PLATFORM to the other archs that
use it as well, or keep it under EMBEDDED there?


> > Anyway: NACK: I like this approach but this needs to be added to
> > arch/powerpc as well.
> 
> I can add that to the series.

Ok, cool. We can probably move it in under the relevant powerpc
sub-platforms over time, and that's a powerpc-specific change anyway,
no need to get that through linux-ide.

> > It's actually more needed there than arch/ppc, I don't personally care
> > if arch/ppc can't use pata_platform for the last couple of months it's
> > still around (it's getting deleted this summer, all platforms should
> > have moved to powerpc by then).
> 
> Thanks, didn't know that.

No problem. :)


-Olof
