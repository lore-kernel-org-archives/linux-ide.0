From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Libata PATA status
Date: Wed, 4 Jul 2007 15:02:58 +0200
Message-ID: <20070704130258.GA10904@one.firstfloor.org>
References: <20070703185116.59c8f5f5@the-village.bc.nu> <p73k5tg2uj9.fsf@bingen.suse.de> <20070704131746.4bbe4d0e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:32905 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759339AbXGDNDA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 09:03:00 -0400
Content-Disposition: inline
In-Reply-To: <20070704131746.4bbe4d0e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

On Wed, Jul 04, 2007 at 01:17:46PM +0100, Alan Cox wrote:
> On 04 Jul 2007 15:00:26 +0200
> Andi Kleen <andi@firstfloor.org> wrote:
> 
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > 
> > > Post SRST 
> > What is SRST?
> > 
> > My personal wish list feature would be a little forwarder driver
> > to forward /dev/hd* to /dev/sd* for this; then old IDE could be
> > disabled without risking breaking old root file systems.
> 
> That would be udevd for new systems or "ln -s" for old ones ? 

Then old kernels couldn't be booted anymore.

> 
> I don't see a way to build that "simple" forwarder because the device
> allocation is now dynamic rather than tied to specific device on specific
> port - a concept with really no meaning any more.

Sure for SATA. But surely for PATA it would be possible to fake
the mapping of the old driver? Doing it simple minded (e.g. only
for the builtin devices) would be probably sufficient.

-Andi

