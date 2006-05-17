From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 07:30:02 -0400
Message-ID: <446B093A.7080906@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:52671 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932081AbWEQKdz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 06:33:55 -0400
In-Reply-To: <446AAA33.5010800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>


Tejun Heo wrote:

> Ric Wheeler wrote:
>
>> May 17 03:30:54 centera kernel: [start_ordered           ]: BIO 
>> d08998c0 3357330 4096
>> May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 
>> in_flight=0
>> May 17 03:30:54 centera kernel: [blk_do_ordered          ]: 
>> start_ordered ed3553c0->dfe2bd28
>> May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2bd28 
>> (bar)
>> May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: 
>> q->orderr=0 error=0
>> May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO 
>> f18ffa00 3357330 4096
>> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 
>> seq=08 orderr=0 error=0
>> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence 
>> complete
>> May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: 
>> q->orderr=0 error=0
>> May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO 
>> f18ff300 3357330 4096
>> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 
>> seq=08 orderr=0 error=0
>> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence 
>> complete
>
> [--snip--]
>
> Combined with your boot log, everything seems as expected.  Write 
> cache is disabled, so the chosen ordered mode is 0x1 - DRAIN only.  In 
> the log you've posted, there are no pending IOs on barrier issue, so 
> the barrier is executed directly and then the sequence is complete.  
> If there were other requests pending, all that happens would be 
> waiting for them to finish before issuing the barrier.
>
> If you turned on write cache after the machine booted, what method did 
> you use to turn on write cache?  If you issued the command directly 
> using sg to an active device (usage count >= 1), SCSI doesn't snoop 
> such commands and thus it won't adjust ordered mode automatically.  
> However, sd forces disk revalidation (and thus ordered 
> reconfiguration) if you change cache mode via 
> /sys/class/scsi_disk/X\:0\:0\:0/cache_type.
>
That is what I suspected...

The write cache gets set via hdparm (in the previous kernel we had just 
hacked the sd code to always assume write back/barriers until this /sys 
control came along ;-)).

What is the magic sequence to get the cache type to flip? My first tries 
to poke cache type leave it firmly in write through...

ric

