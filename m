From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and	performance
 tests
Date: Thu, 02 Dec 2004 02:11:29 -0500
Message-ID: <41AEC021.8040000@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>	 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>	 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>	 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>	 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>	 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>	 <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>	 <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>	 <41AEBD95.7030804@pobox.com> <1101971149.5593.64.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261570AbULBHLm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Dec 2004 02:11:42 -0500
In-Reply-To: <1101971149.5593.64.camel@gaston>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, list linux-ide <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> They may not end up in order if they are stores (the stores to the
> taskfile may be out of order vs; the loads/stores to/from the data
> register) unless you have a spinlock protecting both or a full sync (on
> ppc), but then, I don't know the ordering things on x86_64. This could
> certainly be a problem on ppc & ppc64 too.


Is synchronization beyond in[bwl] needed, do you think?

This specific problem is only on Intel ICHx AFAICS, which is PIO not 
MMIO and x86-only.  I presumed insw() by its very nature already has 
synchronization, but perhaps not...

	Jeff


