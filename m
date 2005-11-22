From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 test support
Date: Tue, 22 Nov 2005 10:52:02 +0900
Message-ID: <438279C2.6030002@gmail.com>
References: <20051122002333.9619.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.196]:18739 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964874AbVKVBwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Nov 2005 20:52:10 -0500
Received: by xproxy.gmail.com with SMTP id s14so838902wxc
        for <linux-ide@vger.kernel.org>; Mon, 21 Nov 2005 17:52:10 -0800 (PST)
In-Reply-To: <20051122002333.9619.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org

linux@horizon.com wrote:
>>One thing I wanna verify on sil24 is data integrity with multiple disks 
>>attached.  It would be very helpful if you can do some parallel data 
>>stress testing with multiple disks.
>>
>>* Parallel 'badblocks -w -t random' on all attached disks.  Maybe repeat 
>>it for a few days and verify no corrupted IO occurs.
> 
> 
> Just completed 6 passes x 6 drives x 350 GB = 12.6 TB of badblocks (10^14
> bits) with no errors.  That's in addition to a previous 5 passes that
> was interrupted by timeout problems on one drive, but that's an error
> handling issue and not a data corruption problem, and it did resolve
> itself eventually after I killed the badblocks run.
> 
> That's several days of solid disk access at > 300 MB/sec.
> (Some silly people asked me why I ingored the Sil3114 that came with
> the motherboard...)
> 
> Thanks for a great driver!  I'll have even more fun testing NCQ one of
> these days. :-)
> 
> Now rebooting to 2.6.14-rc2.  Now that it's stable, this system is going
> into production Very Very Soon.  If you want any more testing, speak up!

I'm very glad to here the good news.  I'll let you know when more
testing is needed.  Thanks for doing this.

-- 
tejun
