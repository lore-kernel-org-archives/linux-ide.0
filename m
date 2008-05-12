From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: libata NCQ implementation questions
Date: Mon, 12 May 2008 21:17:11 +0200
Message-ID: <18472.38839.647001.510236@alkaid.it.uu.se>
References: <18471.32504.953679.399689@harpo.it.uu.se>
	<48286938.1090301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:59710 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbYELTWq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 15:22:46 -0400
In-Reply-To: <48286938.1090301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mikael Pettersson <mikpe@it.uu.se>, jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

Mark Lord writes:
 > Mikael Pettersson wrote:
 > > I've started working on NCQ support for sata_promise,
 > > and I have a few questions regarding NCQ and libata:
 > > 
 > > 1. Can I rely not seeing any non-NCQ commands while there
 > >    are uncompleted NCQ commands on a port?
 > ..
 > 
 > No, you cannot.  So you'll have to code a .qc_defer() method
 > to hold them off in that case.  For a *really* good example,
 > see my recently deployed mv_qc_defer() function in sata_mv.c
 > as of linux-2.6.26-rc2.

Hmm, so I misinterpreted ata_std_qc_defer()? Ok, I'll look
at sata_mv's version.

...

 > > 5. Does dmam_alloc_coherent() give the same alignment guarantees
 > >    that pci_alloc_consistent() does? That is, both CPU and bus
 > >    addresses will be aligned to the smallest PAGE_SIZE order that
 > >    fits the requested size.
 > ..
 > 
 > In sata_mv, I ran into those same concerns, and ended up creating
 > a couple of pools for local use by the driver.  It uses dmam_pool_create()
 > (note the extra "m" in "dmam_"), dma_pool_alloc(), and dma_pool_free().
 > 
 > If you just search for "_pool" in sata_mv, you'll find all of the calls
 > (not many).  The use of "dmam_pool_create()" assures that things will be
 > cleaned up properly/automatically if the controller ever "goes away".

Thanks, this sounds like a decent solution.

/Mikael
