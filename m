From: Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [2.5.70] possible problem with /dev/diskstats
Date: Sun, 01 Jun 2003 21:23:11 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200306020423.h524NBd02594@owlet.beaverton.ibm.com>
References: <200306012131.32006.fsdeveloper@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54007 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261825AbTFBEJv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2003 00:09:51 -0400
In-reply-to: Your message of "Sun, 01 Jun 2003 21:31:31 +0200."
             <200306012131.32006.fsdeveloper@yahoo.de>
List-Id: linux-ide@vger.kernel.org
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

    I've done some disk-io (compiled some software) and the values
    now are even lower:
    
Interesting, yes, you now have 60 fewer "I/O's in flight."

    Where exactly is the code in the kernel, that produces the diskstats file,
    so I can try grepping through it?

The I/O's in flight are incremented in drive_stat_acct() (see ll_rw_blk.c)
and decremented in attempt_merge() and end_that_request_last().  My gut feel
is that end_that_request_last() is getting called more often than expected
via some interesting path, but I've nothing right now to back that up.

Rick
