From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Mon, 21 Feb 2005 08:27:49 +0400
Message-ID: <42196345.5040501@wasp.net.au>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <42158774.9030406@wasp.net.au> <4216BD10.2070008@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:2499 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261790AbVBUE2C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2005 23:28:02 -0500
In-Reply-To: <4216BD10.2070008@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Andy Warner <andyw@pobox.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Brad Campbell wrote:

> 
> Have been unable to hit the bug with SMART disabled (Kernel unchanged). 
> So...... Pass through (or SMART in particular) is not really safe on UP 
> either, you just have to work really hard at it to hit the corner cases.

I tried it last night with the latest and greatest Vanilla BK + libata + libata-dev and really 
pounded the poor machine hard with very rude bash scripts doing SMART polling from two separate 
tasks (so randomly I would poll the same drive with two different queries simultaneously) and I 
could certainly fail drives out of the array, but no oops.

So yes, SMART is causing timeouts but no longer causing an oops here.

Now I have also replaced the PSU with a much better specced unit, so that may have also been a 
contributing factor to the oops. (The 12v rail was running on the edge).

If this rebuild this morning gets through then I'll go back to the old kernel that was oopsing and 
try it again to compare.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
