From: Marc MERLIN <marc@merlins.org>
Subject: Re: decoding PMP errors with Marvel SATA controller
Date: Tue, 28 Jun 2011 22:03:41 -0700
Message-ID: <20110629050341.GB10580@merlins.org>
References: <20110626070820.GC24867@merlins.org> <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com> <20110629034125.GC32153@merlins.org> <4E0AA1C1.6020406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:49010 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab1F2FDr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2011 01:03:47 -0400
Content-Disposition: inline
In-Reply-To: <4E0AA1C1.6020406@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On Tue, Jun 28, 2011 at 11:53:37PM -0400, Mark Lord wrote:
> On 11-06-28 11:41 PM, Marc MERLIN wrote:
> ..
> > So it seems it was a false alarm after all, I'll report back if I have
> > problems again, but it looks like it's working solidly and for what it's
> > worth with 5 drives and software raid 5, I can both read and write files
> > at about 115MB/s, which isn't too shabby :)
> 
> Mmm.. power everything OFF, wait a few seconds,
> then power on and verify that it all still works.

Yep, it does (even powered off the power supply to the MB that isn't truly
off otherwise).

I've backed away slowly, sealed the cabinet it's in, and will leave things
running :)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
