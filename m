From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: ibata: get rid of ATA_MAX_QUEUE loop in
	ata_qc_complete_multiple()  v2
Date: Wed, 20 May 2009 09:58:52 +0200
Message-ID: <20090520075852.GL11363@kernel.dk>
References: <20090520074439.GJ11363@kernel.dk> <4A13B60F.8030603@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:44687 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756100AbZETH6w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 03:58:52 -0400
Content-Disposition: inline
In-Reply-To: <4A13B60F.8030603@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

On Wed, May 20 2009, Jeff Garzik wrote:
> Jens Axboe wrote:
>> We very rarely (if ever) complete more than one command in the
>> sactive mask at the time, even for extremely high IO rates. So
>> looping over the entire range of possible tags is pointless,
>> instead use __ffs() to just find the completed tags directly.
>>
>> Updated to clear the tag from the done_mask instead of shifting
>> done_mask down as suggested by From: Tejun Heo <htejun@gmail.com>
>> Verified with a user space tester to produce the same results.
>>
>> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
>> ---
>>  drivers/ata/libata-core.c |   11 +++++------
>>  1 files changed, 5 insertions(+), 6 deletions(-)
>
> Much cleaner.  Queued...

Thanks!

> Separately, I wonder if we shouldn't add code to report when the  
> hardware gives us an unknown tag.
>
> The code always correctly handles invalid tags passed to us from  
> hardware "if (qc)", but we should probably squawk when that happens, I  
> suspect.

Probably a good idea, it is a sign of bigger problems if the hardware
completes tags that we don't know about.

-- 
Jens Axboe

