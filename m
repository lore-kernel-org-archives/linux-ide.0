From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/14] block: implement blk_rq_map_kern_prealloc()
Date: Fri, 27 Mar 2009 11:26:35 +0900
Message-ID: <49CC395B.20003@gmail.com>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <1237910776-10983-4-git-send-email-tj@kernel.org> <49CA4B4B.50408@panasas.com> <49CAE425.5050009@kernel.org> <49CB31DB.2040608@gmail.com> <49CB3765.4070406@panasas.com> <49CB387A.3000006@panasas.com> <49CB56AD.3080101@gmail.com> <49CB65CB.1030905@panasas.com> <49CB6FF8.7050701@gmail.com> <49CB94E9.5040808@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:25432 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbZC0C0n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 22:26:43 -0400
In-Reply-To: <49CB94E9.5040808@panasas.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello,

Boaz Harrosh wrote:
> Yes sure, I'll be thinking about this some more too. Once your patch
> pile settles we can sort out an additional cleanup that unifies some
> of today's exported functions, just like you did with the blk_end_request.

I'm currently looking at the mapping API.  It's actually the final
obstacle.  It seems scsi_req_map_sg() should really be in blk-map and
doing that would solve most issues we've been talking about, right?
Anyways, I'll take deeper look and see whether I can clean this up.

> Do you have a public tree I can inspect the all lot in one central
> place? That should be the IDE tree you published few days ago
> right? I'll look for it.

I have ~40 more patches on top of those two.  They're mostly ready.
I'll post them soonish (I want to say later today but I said later
today yesterday too :-)

Thanks.

-- 
tejun
