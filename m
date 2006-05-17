From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 13:44:35 +0900
Message-ID: <446AAA33.5010800@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:38256 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751243AbWEQEom (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 00:44:42 -0400
Received: by py-out-1112.google.com with SMTP id z59so161411pyg
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 21:44:41 -0700 (PDT)
In-Reply-To: <446A9F13.4020907@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Ric Wheeler wrote:
> May 17 03:30:54 centera kernel: [start_ordered           ]: BIO d08998c0 3357330 4096
> May 17 03:30:54 centera kernel: [start_ordered           ]: ordered=1 in_flight=0
> May 17 03:30:54 centera kernel: [blk_do_ordered          ]: start_ordered ed3553c0->dfe2bd28
> May 17 03:30:54 centera kernel: [elv_next_request        ]: dfe2bd28 (bar)
> May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
> May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ffa00 3357330 4096
> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
> May 17 03:30:54 centera kernel: [ordered_bio_endio       ]: q->orderr=0 error=0
> May 17 03:30:54 centera kernel: [flush_dry_bio_endio     ]: BIO f18ff300 3357330 4096
> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: ordseq=17 seq=08 orderr=0 error=0
> May 17 03:30:54 centera kernel: [blk_ordered_complete_seq]: sequence complete
[--snip--]

Combined with your boot log, everything seems as expected.  Write cache 
is disabled, so the chosen ordered mode is 0x1 - DRAIN only.  In the log 
you've posted, there are no pending IOs on barrier issue, so the barrier 
is executed directly and then the sequence is complete.  If there were 
other requests pending, all that happens would be waiting for them to 
finish before issuing the barrier.

If you turned on write cache after the machine booted, what method did 
you use to turn on write cache?  If you issued the command directly 
using sg to an active device (usage count >= 1), SCSI doesn't snoop such 
commands and thus it won't adjust ordered mode automatically.  However, 
sd forces disk revalidation (and thus ordered reconfiguration) if you 
change cache mode via /sys/class/scsi_disk/X\:0\:0\:0/cache_type.

-- 
tejun
