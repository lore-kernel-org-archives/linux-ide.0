From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 09:50:18 +0900
Message-ID: <446A734A.6020504@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:36788 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932395AbWEQAuZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 20:50:25 -0400
Received: by wr-out-0506.google.com with SMTP id 70so377359wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 17:50:24 -0700 (PDT)
In-Reply-To: <446A6ECD.7080104@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
> Actually, looking even more at the code, I think the entire "spurious 
> interrupt" code block is bogus.
> 
> The device is free to send D2H or SDB FIS to clear Status bits, as well 
> as SDB FIS's to update SActive.  The ata_qc_complete_multiple() call 
> will do the right thing, even if there is no work to do.

Yes, they are, but...

* Please note that SActive update via SDB FIS is edge-triggered.  It 
doesn't send the whole image of the register.  The SActive bits in SDB 
FIS indicate W1C (this is inevitable because controller and device 
cannot be in full synchronization regarding SActive).  So, they have can 
have dangerous side effects.

* Those spurious FISes are actively setting the I bit requesting 
interrupt explicitly.  Those are not innocent status update FISes.  And 
the spec state machines don't allow D2H FISes during NCQ command phase. 
  I seem to recollect it's actually forbidden explicitly but currently 
cannot find where.  I'll keep looking.

> As another side note, command coalescing is worth experimenting with.

Might be, but I'm a bit skeptical.  We might lose more to added latency.

-- 
tejun
