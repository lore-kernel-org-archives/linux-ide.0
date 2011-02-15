From: Tejun Heo <tj@kernel.org>
Subject: Re: old ide driver incompatible with new flush implementation
 (was: conflicting commits (block flush vs. ide))
Date: Tue, 15 Feb 2011 17:30:46 +0100
Message-ID: <20110215163046.GO3160@htj.dyndns.org>
References: <4D5A75650200007800031F9C@vpn.id2.novell.com>
 <20110215151314.GJ3160@htj.dyndns.org>
 <4D5AB5D0020000780003207A@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62053 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1BOQav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2011 11:30:51 -0500
Received: by bwz15 with SMTP id 15so602112bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 08:30:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5AB5D0020000780003207A@vpn.id2.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-ide@vger.kernel.org

On Tue, Feb 15, 2011 at 04:20:16PM +0000, Jan Beulich wrote:
> > Yeah, right.  blk_flush_complete_seq_end_io() is on completion path
> > and shouldn't call directly into request_fn.  Can you please test
> > whether the following patch fixes the problem?
> 
> Isn't that rather meant to deal with the first of the two cases (i.e.
> not the one above, where the problem is with the direct call to
> request_fn from __generic_unplug_device())?

Right, didn't realize there were two issues.  The following should
take care of the second one.

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 54b123d..fbaa037 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -130,7 +130,7 @@ static struct request *queue_next_fseq(struct request_queue *q)
 		BUG();
 	}
 
-	elv_insert(q, rq, ELEVATOR_INSERT_FRONT);
+	elv_insert(q, rq, ELEVATOR_INSERT_REQUEUE);
 	return rq;
 }

-- 
tejun
