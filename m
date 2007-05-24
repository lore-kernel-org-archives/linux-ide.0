From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Wed, 23 May 2007 20:13:02 -0400
Message-ID: <20070524001302.GA18571@devserv.devel.redhat.com>
References: <20070515061239.611A2DDEE9@ozlabs.org> <1179209697.32247.153.camel@localhost.localdomain> <20070523144217.5abd9fdf@the-village.bc.nu> <1179960518.32247.948.camel@localhost.localdomain> <20070524003123.77b9c81c@the-village.bc.nu> <1179963820.32247.996.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53379 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014AbXEXANN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 20:13:13 -0400
Content-Disposition: inline
In-Reply-To: <1179963820.32247.996.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, May 24, 2007 at 09:43:39AM +1000, Benjamin Herrenschmidt wrote:
> We might have to provide an optional ->flush() that is device specific ?

Probably

> Config space access would do the job nicely in most cases though. If
> it's really only for SRST which can be slow. If it's for the 400ns of
> writing the command, then we have a deeper problem but I would expect
> MMIO chipsets to be smarter than that ...

There are errata for config space and posting in some chipsets  and as you
says its slow. The 400nS command writing bit applies too - they chipsets are
not that smart in my experience.

> Ah yes, the PRD table pointer is a good option too... We could introduce
> a ->flush() and have a default sff version that reads that pointer ?

Normal SFF is I/O cycles so the default SFF one would be NULL which is 
just perfect 8). SIL680/3112 would register a PRD read and the rest can do
whatever their non SFF design does.

