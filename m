From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: bug in use-ide_pio_bytes patch?
Date: Mon, 23 Mar 2009 11:27:25 +0100
Message-ID: <200903231127.25698.bzolnier@gmail.com>
References: <49C72C1B.5080601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:60467 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZCWK0W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2009 06:26:22 -0400
Received: by ewy9 with SMTP id 9so1545364ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2009 03:26:19 -0700 (PDT)
In-Reply-To: <49C72C1B.5080601@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>


Hi,

On Monday 23 March 2009, Tejun Heo wrote:
> Hello, Bartlomiej.
> 
> I've been looking at the pata-2.6 patches and use-ide_pio_bytes patch
> contains the following snippet.
> 
>   void ide_init_pc(struct ide_atapi_pc *pc)
>   {
> 	 memset(pc, 0, sizeof(*pc));
>  @@ -351,6 +308,9 @@ static ide_startstop_t ide_pc_intr(ide_d
> 			 pc->xferred = pc->req_xfer;
> 			 if (drive->pc_update_buffers)
> 				 drive->pc_update_buffers(drive, pc);
>  +
>  +			if (drive->media == ide_floppy)
>  +				ide_complete_rq(drive, 0, blk_rq_bytes(rq));
> 		 }
> 		 debug_log("%s: DMA finished\n", drive->name);
> 	 }
> 
> It completes ide_floppy requests in the DMA handling block; however,
> those requests are gonna be completed again later in the regular
> completion path again.  I think the above part can be simply dropped?

I'm not sure I get it -- could you point me to the other completion path?

Thanks,
Bart
