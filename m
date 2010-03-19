From: Tejun Heo <tj@kernel.org>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Fri, 19 Mar 2010 11:26:48 +0900
Message-ID: <4BA2E0E8.1050001@kernel.org>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B9D0772.4080306@teksavvy.com> <4B9D7924.1020908@kernel.org> <201003181716.00173.suse-linux@ml082.pinguin.uni.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33936 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab0CSC1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Mar 2010 22:27:00 -0400
In-Reply-To: <201003181716.00173.suse-linux@ml082.pinguin.uni.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Bogner <suse-linux@ml082.pinguin.uni.cc>
Cc: Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

(cc'ing Daniel, Hi)

Hello,

On 03/19/2010 01:15 AM, Al Bogner wrote:
> WD said to me I can send them the disk, but didn't accept, that this is a 
> firmware bug.
> 
> Today I got a brandnew WD20EARS (2TB) and it is the same. After about an 1/2 
> hr. I had 12 cycles with an _un_formatted disk.

That would reach 1.43 years of operation hour w/ 300k limit.  Maybe
that's the number they are aiming for?  I don't know.  I haven't heard
from WDC yet.

> I cannot accept, that it should be a warranty issue, because this
> reduces the lifetime _after_ the warranty and increases the
> possibility to loose data, at least for those who don't use a raid.
>
> I would be happy to have a native linux utility to change this.

Yeah, that will be nice but it's of very limited use.  How many would
look that up, install it and use it to adjust the parameter?  For it
to have meaningful effect, it should be applied automatically, and at
that point, I'm not sure it's a good idea because I don't want to
unconditionally disable power saving feature without a very good
rationale.

If WDC thinks < 1.5 years of uptime is good enough for those products
in exchange of lowered power consumption, which I think might be
acceptable for certain products considering that most people don't use
their computers 24/7 and the load/unload cycle limit isn't exactly an
accurate timebomb like limit.  Well, then, that's the trade off WDC
made and the consumers can choose accordingly.

And, if that's the case, I think we can and probably should try to let
people know about the particular tradeoff of those drives and if
possible provide a utility to adjust that but I'm still kind of
against automatically disabling it because it doesn't help solving the
situation in the long run while forcing us to apply a sub-optimal
workaround without knowing whether it's really necessary.

Daniel, I think we really need some clarification from WDC at this
point.  I'm sure WDC wouldn't want Linux distros to go ahead and
disable powersaving feature unconditionally, so please let us know.

Thanks.

-- 
tejun
