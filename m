From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 9 Apr 2009 13:53:23 +0100
Message-ID: <20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
	<49DDEF02.7090004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38781 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759951AbZDIMxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 08:53:17 -0400
In-Reply-To: <49DDEF02.7090004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, 09 Apr 2009 08:50:10 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > Something like this then ?
> > 
> > 
> > The legacy old IDE API for this is a bit primitive so we try and map stuff
> > sensibly onto it.
> > 
> > - Add flags2 as we ran out of flags
> > - Set PIO over DMA devices to report 32bit
> > - Add ability to change the PIO32 settings if the controller permits it
> > - Add that functionality into the sff drivers
> > - Add that functionality into the VLB legacy driver
> > - Turn on the 32bit PIO on the ninja32 and add support there
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> I think the flag2 stuff needs a closer look WRT driver setup, but 
> overall looks good.
> 
> Consider it ACK'd, if I cannot come up with anything better for flags2 

The alternative would be to remove the private 8 flags from flags but
that means fairly excessive changes to all the devices

[Looks smug and notes that he pointed out that driver private flags in
the same field would turn out to be a bad idea early on ...]
