From: John Bucy <bucy@gloop.org>
Subject: Re: sata_promise on alpha, Promise SATAII TX4?
Date: Sat, 12 Feb 2005 23:45:10 -0500
Message-ID: <20050213044510.GA32569@tellurium.club.cc.cmu.edu>
References: <1106167255.25628.68.camel@catalepsy.pdl.cmu.edu> <41EEE18E.307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from SILICON.CLUB.CC.cmu.edu ([128.2.4.170]:5135 "HELO
	silicon.club.cc.cmu.edu") by vger.kernel.org with SMTP
	id S261243AbVBMEwb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Feb 2005 23:52:31 -0500
Content-Disposition: inline
In-Reply-To: <41EEE18E.307@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jan 19, 2005 at 05:39:10PM -0500, Jeff Garzik wrote:
> John Bucy wrote:
> >1.  Are Promise SATA cards known to work (or not work) on Alpha-based
> >systems?
> 
> I'm not sure if anybody has tested, but they work just fine.
> 
> 
> >2.  I saw the patch posted here to make sata_promise work for 
> >the PDC20518/SATAII150TX4 ... what's the experience with this like to
> >date?  Is it stable?
> 
> I'm interested in feedback on this question as well.  The few reports 
> I've seen just say "it works" and that's about it.

We're starting to get this working now.  We had to get 2.6.11-rc3 to
fix some alpha problems, apply an additional patch from -bk8 to setup
dma_mapping_error for alpha and the patch for this card posted here before.  

We immediately noticed that the port mapping seems to be wrong:

Physical Port    Registers as 
1             -> 4
2             -> 2
3             -> 1
4             -> 3


Also, it doesn't seem to be in pci.ids yet.  

We'll be doing a lot more testing in the meantime... we'll let you all
know what we see.


thanks!
john



