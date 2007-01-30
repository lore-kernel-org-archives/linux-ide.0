From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 19:33:55 -0800
Message-ID: <20070129193355.4f40cdc1.akpm@osdl.org>
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
	<20070129190847.6ef1191f.akpm@osdl.org>
	<1170123518.2376.2.camel@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40632 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964930AbXA3DoJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 22:44:09 -0500
In-Reply-To: <1170123518.2376.2.camel@max>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>

On Mon, 29 Jan 2007 21:18:38 -0500
Mike Christie <michaelc@cs.wisc.edu> wrote:

> Ok. here is a fix with the overflow check sg.c has. Patch
> was made against Linus's tree and tested with nero.
> 
> Userspace does not send us jiffies. Use msecs_to_jiffies
> and check for overflow like sg.c
> 
> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
> 
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 2528a0c..5ca72c5 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -223,7 +223,7 @@ static int verify_command(struct file *f
>  static int sg_io(struct file *file, request_queue_t *q,
>  		struct gendisk *bd_disk, struct sg_io_hdr *hdr)
>  {
> -	unsigned long start_time;
> +	unsigned long start_time. timeout;

you'll be wanting a comma there.
