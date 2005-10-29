From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sat, 29 Oct 2005 16:16:26 -0400
Message-ID: <4363D89A.9080007@pobox.com>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9094 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751203AbVJ2UQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 16:16:31 -0400
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Side note: one of the downsides of the new "merge lots of stuff early in 
> the development series" approach is that the first few daily snapshots end 
> up being _huge_. 

Yeah.  Back when I did the BK snapshots, I would occasionally do a 
middle-of-the-day snapshot if there were a ton of incoming merges in a 
24-hour span.

If this "huge -git1" becomes a real problem, we could always

* give you a manual "do snapshot" button

* ask the maintainers to spread out their submits across multiple days, 
as I am doing now

* sell you on capping the daily push-to-kernel.org limit.  merge stuff 
into "day1", "day2", etc. branches when the main branch "fills up" for 
the day.

None of these are terribly painful, but none are terribly appealing either.

	Jeff


