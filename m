From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 19:08:47 -0800
Message-ID: <20070129190847.6ef1191f.akpm@osdl.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de>
	<20070128133344.214070@gmx.net>
	<1170051963.6454.7.camel@Homer.simpson.net>
	<Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
	<45BE5AF0.3030005@cs.wisc.edu>
	<Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
	<45BE864A.2050907@cs.wisc.edu>
	<Pine.LNX.4.64.0701291614020.3611@woody.linux-foundation.org>
	<45BE9774.20105@cs.wisc.edu>
	<45BE99A4.9080503@cs.wisc.edu>
	<Pine.LNX.4.64.0701291736550.3611@woody.linux-foundation.org>
	<45BEB292.7060008@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:39803 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbXA3DTt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 22:19:49 -0500
In-Reply-To: <45BEB292.7060008@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>

On Mon, 29 Jan 2007 20:50:58 -0600
Mike Christie <michaelc@cs.wisc.edu> wrote:

> With the attached patch, nero finds the cd drives and I can burn disks.
> There is no errors from the ide layer like before.
> 
> 
> [use-old-timeout-calc.patch  text/x-patch (399B)]
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 2528a0c..aded9a0 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -271,7 +271,7 @@ static int sg_io(struct file *file, requ
>  
>  	rq->cmd_type = REQ_TYPE_BLOCK_PC;
>  
> -	rq->timeout = jiffies_to_msecs(hdr->timeout);
> +	rq->timeout = (hdr->timeout * HZ) / 1000;

Yes, that was a buggy conversion - it should have been msecs_to_jiffies().
