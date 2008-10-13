From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide: Bug fixes and improvements in the disk head parking code
Date: Mon, 13 Oct 2008 21:04:38 +0200
Message-ID: <200810132104.39673.bzolnier@gmail.com>
References: <87fxn3hw33.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:40870 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759875AbYJMUM3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 16:12:29 -0400
Received: by gv-out-0910.google.com with SMTP id e6so408246gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 13:12:28 -0700 (PDT)
In-Reply-To: <87fxn3hw33.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org

On Saturday 11 October 2008, Elias Oltmanns wrote:
> Fix a memory leak due to a missing blk_put_request() in
> issue_park_cmd(). Additionally, we should plug the queue when enqueueing
> the unpark request because there is no guarantee that the park timeout
> has not expired by then. Even though the chance for that to happen is
> very slim, the request might end up hanging in the queue until the next
> I/O operation is queued up. While at it, clean up the code a little:
> - make issue_park_cmd() a function of type void since nobody cares for
>   the return value anyway;
> - use blk_start_queueing() instead of __blk_run_queue() since we don't
>   have to worry about recursion;
> - remove a superfluous pointer deference in task_no_data_intr().
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> ---
> Feel free to merge with original patch if Linus hasn't pulled your tree
> yet.

done, thanks
