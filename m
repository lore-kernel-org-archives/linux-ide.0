From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [announce] plscsi in Linux
Date: 21 May 2004 14:05:26 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085169926.3083.89.camel@patibmrh9>
References: <1085168815.3083.43.camel@patibmrh9><1085169677.3083.79.camel@pa
	tibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:19916 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265857AbUEUUFf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 16:05:35 -0400
In-Reply-To: <1085169677.3083.79.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: dwm@austin.ibm.com
Cc: linux-ide@vger.kernel.org

Someone once said if you ask me the time I will first help you build a
clock and then I may remember to tell you the time.

> .. conceptually trivial, actually complex,
> ...
> http://plavarre.blog-city.com/read/542134.htm
> is me arguing that a C interpreter would do a better job ...
> ... 
> A tutorial is http://members.aol.com/plscsi/tutorial/
> ...
> 4) FIXME: Port back to Linux the master source last released as
> http://members.aol.com/plscsi/mac/gcsmac.tar.gz

plscsi development most recently stalled for lack of conversation over
how to express the C-struct-like idea of consciously misaligning struct/
cdb/ sense/ data.

As yet, the master Mac source is good only for writing short Mac OS X
demoes in the style of http://members.aol.com/plscsi/tools/gccscsi/

The Mac PLScsi source is NOT yet merged with the command line parser.

> Subject: pldd issues
> http://plavarre.blog-city.com/read/596492.htm
> Subject: gccscsi issues
> http://plavarre.blog-city.com/read/617727.htm

The Mac PLScsi source is NOT yet ported back to Linux, even though the o
0 not implied after y/ n/ yn bug of Linux gccscsi is fixed in the Mac
source.

Pat LaVarre


