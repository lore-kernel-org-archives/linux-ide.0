From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA link power management issues
Date: Tue, 21 Apr 2015 16:56:08 -0400
Message-ID: <20150421205608.GF9455@htj.duckdns.org>
References: <3352987.ugV1Ipy7Z5@xps13>
 <2356903.cA2H5W8V2D@xps13>
 <20150421153121.GD9455@htj.duckdns.org>
 <9107428.nVaRUddl4K@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:32804 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694AbbDUU4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2015 16:56:12 -0400
Content-Disposition: inline
In-Reply-To: <9107428.nVaRUddl4K@xps13>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stripathi@apm.com

Hello,

On Tue, Apr 21, 2015 at 10:29:38PM +0200, Gabriele Mazzotta wrote:
> Doing some quick tests I found that in some cases it takes 5 or 6
> seconds for the first interrupt to arrive, so I'd have to use a quite
> long interval to completely prevent errors.

Hmm...

> I am wondering if it would be better using my original solution
> (i.e. ignore first event), but make it device specific given that it
> might make no sense on other systems and seems to be more reliable than
> the time-based one.

I'm not sure.  What if the extra PHY event isn't that reliable.  It'd
be pretty confusing if it ends up ignoring a legitimate PHY event
after, say, two hours, so one way or the other, we'd need to cap how
long we're gonna be ignoring the event.  Ignore the first PHY event
for 10s after LPM state change?

Thanks.

-- 
tejun
