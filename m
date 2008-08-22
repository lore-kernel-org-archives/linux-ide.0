From: Robin Holt <holt@sgi.com>
Subject: Re: kernel unaligned accesses on IA64 in IDE
Date: Fri, 22 Aug 2008 14:39:43 -0500
Message-ID: <20080822193943.GF9457@sgi.com>
References: <20080819225606.GB22088@us.ibm.com> <20080822164538.GB9047@us.ibm.com> <9ea470500808221029l6bd79c62w4c06d948f962d95c@mail.gmail.com> <200808222036.00536.bzolnier@gmail.com> <57C9024A16AD2D4C97DC78E552063EA309EDE187@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:51050 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752007AbYHVTjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Aug 2008 15:39:44 -0400
Content-Disposition: inline
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA309EDE187@orsmsx505.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "petkovbb@gmail.com" <petkovbb@gmail.com>, Nishanth Aravamudan <nacc@us.ibm.com>, Robin Holt <holt@sgi.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

On Fri, Aug 22, 2008 at 11:51:47AM -0700, Luck, Tony wrote:
> > Why not just make rq->cmd always properly aligned in the block layer
> > i.e. by allocating BLK_MAX_CDB + 2 instead of BLK_MAX_CDB for rq->__cmd
> > and then doing ALIGN() when setting rq->cmd in blk_rq_init()?
> 
> There are two places that do
> 
>         if (rq->cmd != rq->__cmd)
>                 kfree(rq->cmd);
> 
> that would need to be adjusted if you did that.  Better to get __cmd
> aligned on a good boundary by changing the declaration to
> 
>         int __cmd[BLK_MAX_CDB / sizeof (int)];

How about long instead of int.  int leaves us with the possibility that
something else will expect 8 byte alignment.

> and adding a cast to blk_rq_init():
> 
>         rq->cmd = (char *)rq->__cmd;

Robin
