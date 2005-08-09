From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Tue, 9 Aug 2005 14:02:56 -0400
Message-ID: <20050809180256.GC10315@havoc.gtf.org>
References: <200508071949.03782.inform@tiker.net> <42F6B8CD.4050100@gmail.com> <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca> <1123607133.28278.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:15750 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964903AbVHISC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2005 14:02:57 -0400
Content-Disposition: inline
In-Reply-To: <1123607133.28278.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Tue, Aug 09, 2005 at 07:05:33PM +0200, Erik Slagter wrote:
> On Tue, 2005-08-09 at 09:48 -0400, Mark Lord wrote:
> > But there's also a fix for that, again floating around only in private repositories.
> 
> Grmbl.

Mark is just working off steam.  The "fix" causes leaks, and does
not really fix what was intended.  It stops the symptoms Mark was
seeing, but eventually you'll run out of commands, or kernel memory,
and everything still stop _anyway_.

We don't apply band-aids, only fixes.

	Jeff


