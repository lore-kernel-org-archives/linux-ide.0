From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Mon, 3 Feb 2014 13:43:12 -0500
Message-ID: <20140203184312.GF8533@titan.lakedaemon.net>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
 <20140130221228.GB1063@localhost>
 <20140131105411.GC26003@lunn.ch>
 <52EFB69E.2000800@free-electrons.com>
 <20140203165012.GE8533@titan.lakedaemon.net>
 <20140203173240.GF30250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41118 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbaBCSnT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 13:43:19 -0500
Content-Disposition: inline
In-Reply-To: <20140203173240.GF30250@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Kevin Hilman <khilman@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Mon, Feb 03, 2014 at 12:32:40PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 03, 2014 at 11:50:12AM -0500, Jason Cooper wrote:
> > > Andrew, could you post a new version?
> > > if you add the explanation you gave inside a comment just before the check,
> > > I am sure it will be perfectly acceptable.
> > 
> > Tejun,
> > 
> > This patch is needed for our arm-soc bootfarms to continue testing.  It
> > would be helpful if, once you're ok with the patch, we took it through
> > arm-soc.  Would you mind Ack'ing it once you're happy with it?
> 
> The other patches fix the same issue and should be good for -rc2,
> right?

Yes, they weren't in my inbox at the time of writing.  Sorry for the
noise.  Thanks for the Ack.

thx,

Jason.
