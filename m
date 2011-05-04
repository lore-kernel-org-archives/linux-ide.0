From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [patch v2 2/3] block: hold queue if flush is running for non-queueable
 flush drive
Date: Wed, 04 May 2011 14:42:05 +0400
Message-ID: <4DC12D7D.4060705@ru.mvista.com>
References: <20110504081725.946950281@sli10-conroe.sh.intel.com> <20110504082115.270298766@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39842 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1EDKnr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2011 06:43:47 -0400
In-Reply-To: <20110504082115.270298766@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shaohua.li@intel.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jaxboe@fusionio.com, htejun@gmail.com, jgarzik@pobox.com, hch@infradead.org, djwong@us.ibm.com

Hello.

On 04-05-2011 12:17, shaohua.li@intel.com wrote:

> In some drives, flush requests are non-queueable. When flush request is running,
> normal read/write requests can't run. If block layer dispatches such request,
> driver can't handle it and requeue it.
> Tejun suggested we can hold the queue when flush is running. This can avoid
> unnecessary requeue.
> Also this can improve performance. Say we have requests f1, w1, f2 (f is flush
> request, and w is write request). When f1 is running, queue will be hold, so w1
> will not be added to queue list. Just after f1 is finished, f2 will be
> dispatched. Since f1 already flushs cache out, f2 can be finished very quickly.
> In my test, the queue holding completely solves a regression introduced by
> commit 53d63e6b0dfb9588, which is about 20% regression running a sysbench fileio

    Please specify that commit's summary -- for human readers. The ID is only 
immediately usable to gitweb.

> workload.

> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

[...]

> Index: linux/block/blk.h
> ===================================================================
> --- linux.orig/block/blk.h	2011-05-04 14:20:33.000000000 +0800
> +++ linux/block/blk.h	2011-05-04 16:09:42.000000000 +0800
> @@ -61,7 +61,17 @@ static inline struct request *__elv_next
>   			rq = list_entry_rq(q->queue_head.next);
>   			return rq;
>   		}
> -
> +		/*
> +		 *  Flush request is running and flush request isn't queeueable

    Queueable.

WBR, Sergei
