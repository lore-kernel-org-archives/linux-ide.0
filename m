From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3 2.6.24-git] PPC/LIBATA: Select HAVE_PATA_PLATFORM
	for ARCH_PPC
Date: Sat, 2 Feb 2008 13:12:39 -0600
Message-ID: <20080202191239.GA29039@lixom.net>
References: <20080202162133.678366209@fluff.org.uk> <20080202162232.212855590@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:37749 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbYBBTME (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Feb 2008 14:12:04 -0500
Content-Disposition: inline
In-Reply-To: <20080202162232.212855590@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com, linuxppc-dev@ozlabs.org

On Sat, Feb 02, 2008 at 04:21:36PM +0000, Ben Dooks wrote:
> Use the new HAVE_PATA_PLATFORM to select PATA_PLATFORM
> driver.
> 
> CC: linuxppc-dev@ozlabs.org
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

What tree is this against? It doesn't apply to current mainline nor
jgarzik's libata-dev upstream branch.

Anyway: NACK: I like this approach but this needs to be added to
arch/powerpc as well.

It's actually more needed there than arch/ppc, I don't personally care
if arch/ppc can't use pata_platform for the last couple of months it's
still around (it's getting deleted this summer, all platforms should
have moved to powerpc by then).


-Olof

