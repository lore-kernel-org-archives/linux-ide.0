From: Marc MERLIN <marc@merlins.org>
Subject: Re: PMP SMART error recovery and failure code decoding help
Date: Wed, 29 Jun 2011 10:14:02 -0700
Message-ID: <20110629171402.GA10803@merlins.org>
References: <20110116163950.GA691@merlins.org>
 <20110117132623.GD27123@htj.dyndns.org>
 <20110117164340.GD27342@merlins.org>
 <20110117171209.GH27123@htj.dyndns.org>
 <20110117172924.GE27342@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:38007 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1F2RsK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2011 13:48:10 -0400
Content-Disposition: inline
In-Reply-To: <20110117172924.GE27342@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 17, 2011 at 09:29:24AM -0800, Marc MERLIN wrote:
> On Mon, Jan 17, 2011 at 06:12:09PM +0100, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Jan 17, 2011 at 08:43:40AM -0800, Marc MERLIN wrote:
> > > > It could be that the drives need to spin up to answer the smart
> > > > command and the timeout on the smart commands is a bit too short for
> > > > that to happen.  Forcing a disk access before issuing the smart
> > > > command could work around the problem.
> > >  
> > > Right, although the idea is of course to keep the drives spun down :)
> > > I haven't been able to find which SMART call is causing those errors yet.
> > > Does cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 translate to anything useful?
> > 
> > That's SMART ENABLE OPERATIONS.  It turns on SMART.
>  
> Haha, ok, not as useful as I thought :)

As an update for the list archives, more recent smartmontools (5.40 and
maybe older) allow this:
DEVICESCAN -n standby

This tells smartmontools not to talk to drives that are sleeping so that
it does not spin them back up.

In turn it fixed the related PMP timeout and PMP bus reset issues I was getting
from those commands.

Hope this helps someone.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/
