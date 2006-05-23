From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Tue, 23 May 2006 06:59:16 -0700
Message-ID: <44731534.2030600@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6E6F.8010201@gmail.com> <446A7794.80909@garzik.org> <446A7BF6.3090103@gmail.com> <447165F7.1070905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:47480 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932128AbWEWVzE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 17:55:04 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1103602wxc
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 14:55:03 -0700 (PDT)
In-Reply-To: <447165F7.1070905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
> I quite understand the implications.  My argument comes from a different 
> angle:  I don't feel we should be adding tons of code that essentially 
> validates the silicon.

Actually, I think libata-core can/should implement helper function to 
handle ATA device malfunctions in controller-independent way.  Most 
FIS-based controllers provide some level of information about the most 
recent FIS.  The helper function can figure out what's going on and 
required action with info available in the libata-core level and the FIS 
info from LLD irq handler.

> There are plenty of chances for the hardware to 
> fuck up in a way that corrupts data, and is also difficult to detect. 
> Pre-production BIOS have even done silly things like turn off data 
> verification (checksum) by default.  Talk about subtle corruption...
> 
> So I feel the best path is to use the hardware programming sequences 
> described in the spec, because that's what the chip designers and Q/A 
> engineers validate with (read: the Windows driver).

I understand your concern about bloating LLDs with special case handling 
coes but I don't really follow the above logic.  Vendors include every 
possible workaround in their proprietary drivers to make things work 
smoothly.  They don't stick to datasheets in the face existing problems.

> Once we have deployed drivers with the standard programming sequences, 
> _then_ we can consider looking into proper spurious interrupt 
> accounting.  The current AHCI interrupt accounting stuff is not nearly 
> as accurate as it should be, which implies that the code simply should 
> not exist at the present time.

I think it's okay to remove spurious interrupt accounting until AHCI irq 
handling is in better shape as long as we plan to implement proper 
handling in not too distant future.  Also, please note that without code 
that reporting such events, it would be difficult to learn what kind of 
weird things happen.

Thanks.

-- 
tejun

