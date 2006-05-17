From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 23:57:07 -0400
Message-ID: <446A9F13.4020907@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060105020202000500020002"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:50647 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751187AbWEQC5T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 22:57:19 -0400
In-Reply-To: <446A7E4A.1080003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------060105020202000500020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Tejun Heo wrote:

> Ric Wheeler wrote:
>
>>
>> (Trying to keep up ;-))
>>
>> Is there still value in testing your last patch?
>>
>
> The result should be the same, so it's not really necessary.  But, 
> just in case, sticking that patch when you test the barrier would be 
> nice so that things can be verified again.

I applied both patches and rebooted - many minutes later & 94MB of log 
file, I ran my synchronous file write test (the last 200 lines of the 
log file is attached). Is more useful?

>
> Thanks for testing.
>
thanks for the code - this is great!

ric


--------------060105020202000500020002
Content-Type: text/plain;
 name="messages_tail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages_tail"

May 17 03:30:54 centera kernel: [start_ordered           ]: BIO d08998c0 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed3553c0->dfe2bd28
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2bd28 (bar)
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ffa00 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ff300 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO d0899600 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO d08998c0 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [start_ordered           ]: ed3551c8 -> dfe2b1b8,dfe2b260,dfe2b308 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: f18ff4c0 0 3357330 8 8 1 1 dfdd9000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO f18ff4c0 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed3551c8->dfe2b260
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2b260 (bar)
May 17 03:30:54 centera kernel: [start_ordered           ]: ed355ba0 -> dfe2b550,dfe2b5f8,dfe2b6a0 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: f18ffcc0 0 3357330 8 8 1 1 dff0b000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO f18ffcc0 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed355ba0->dfe2b5f8
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2b5f8 (bar)
May 17 03:30:54 centera kernel: [start_ordered           ]: ed341318 -> dfe2b8e8,dfe2b990,dfe2ba38 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: e413bf00 0 3357330 8 8 1 1 f7b57000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO e413bf00 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed341318->dfe2b990
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2b990 (bar)
May 17 03:30:54 centera kernel: [start_ordered           ]: ed3553c0 -> dfe2bc80,dfe2bd28,dfe2bdd0 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: d08993c0 0 3357330 8 8 1 1 df937000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO d08993c0 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed3553c0->dfe2bd28
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2bd28 (bar)
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ff4c0 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ffcc0 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO e413bf00 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO d08993c0 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [start_ordered           ]: ed3553c0 -> dfe2b1b8,dfe2b260,dfe2b308 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: e413bf00 0 3357330 8 8 1 1 dfdd9000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO e413bf00 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed3553c0->dfe2b260
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2b260 (bar)
May 17 03:30:54 centera kernel: [start_ordered           ]: ed341318 -> dfe2b550,dfe2b5f8,dfe2b6a0 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: f18ffcc0 0 3357330 8 8 1 1 dff0b000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO f18ffcc0 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed341318->dfe2b5f8
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2b5f8 (bar)
May 17 03:30:54 centera kernel: [start_ordered           ]: ed355ba0 -> dfe2b8e8,dfe2b990,dfe2ba38 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: f18ff4c0 0 3357330 8 8 1 1 f7b57000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO f18ff4c0 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed355ba0->dfe2b990
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2b990 (bar)
May 17 03:30:54 centera kernel: [start_ordered           ]: ed3551c8 -> dfe2bc80,dfe2bd28,dfe2bdd0 infl=0
May 17 03:30:54 centera kernel: [start_ordered           ]: d0899800 0 3357330 8 8 1 1 df937000
May 17 03:30:54 centera kernel: [start_ordered           ]: BIO d0899800 3357330 4096
May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed3551c8->dfe2bd28
May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2bd28 (bar)
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO e413bf00 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ffcc0 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ff4c0 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO d0899800 3357330 4096
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete

--------------060105020202000500020002--
