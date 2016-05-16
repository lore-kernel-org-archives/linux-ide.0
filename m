From: Jens Axboe <axboe@kernel.dk>
Subject: Re: UBSAN: Undefined behaviour in block/blk-mq.c:1459:27 with
 pata_amd
Date: Mon, 16 May 2016 09:55:31 -0600
Message-ID: <5739ED73.4020009@kernel.dk>
References: <alpine.LRH.2.20.1605121902440.4797@math.ut.ee>
 <22191628.vH7YQZ1hRO@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36861 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbcEPPze (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2016 11:55:34 -0400
Received: by mail-ig0-f172.google.com with SMTP id qe5so52230886igc.1
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2016 08:55:34 -0700 (PDT)
In-Reply-To: <22191628.vH7YQZ1hRO@amdc1976>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 05/13/2016 09:31 AM, Bartlomiej Zolnierkiewicz wrote:
> Does the patch below help?
>
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] blk-mq: fix undefined behaviour in order_to_size()
>
> When this_order variable in blk_mq_init_rq_map() becomes zero
> the code incorrectly decrements the variable and passes the result
> to order_to_size() helper causing undefined behaviour:
>
>   UBSAN: Undefined behaviour in block/blk-mq.c:1459:27
>   shift exponent 4294967295 is too large for 32-bit type 'unsigned int'
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc6-00072-g33656a1 #22
>
> Fix the code by checking this_order variable for not having the zero
> value first.

Thanks Bart, added for 4.7.

-- 
Jens Axboe

