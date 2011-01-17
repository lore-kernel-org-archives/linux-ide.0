From: Marc MERLIN <marc@merlins.org>
Subject: Re: PMP SMART error recovery and failure code decoding help
Date: Mon, 17 Jan 2011 08:43:40 -0800
Message-ID: <20110117164340.GD27342@merlins.org>
References: <20110116163950.GA691@merlins.org> <20110117132623.GD27123@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:60225 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab1AQQnm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2011 11:43:42 -0500
Content-Disposition: inline
In-Reply-To: <20110117132623.GD27123@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 17, 2011 at 02:26:23PM +0100, Tejun Heo wrote:
> Hello,

Hi (sorry that got cut out of my original message :) ).

> On Sun, Jan 16, 2011 at 08:39:50AM -0800, Marc MERLIN wrote:
> > Anyway, the problem happens with both drives that I manually spin down and
> > drives that spin down on their own. I think it's not actually a 'real',
> > error but more an issue where drives cannot answer some SMART error when
> > they are spun down.
> 
> It could be that the drives need to spin up to answer the smart
> command and the timeout on the smart commands is a bit too short for
> that to happen.  Forcing a disk access before issuing the smart
> command could work around the problem.
 
Right, although the idea is of course to keep the drives spun down :)
I haven't been able to find which SMART call is causing those errors yet.
Does cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 translate to anything useful?

> > That said, is it normal/expected for the PMP code to do a full bus reset
> > because of a SMART command that couldn't go through?
> 
> Yeah, after a timeout, the driver doesn't know what state the
> controller / PMP / devices are in, so it's kind of forced to do full
> reset.

Fair enough. I guess it's one of the downsides of PMP.

Thanks for the answer,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
