From: linux@horizon.com
Subject: Re: sata_sil24 test support
Date: 21 Nov 2005 19:23:33 -0500
Message-ID: <20051122002333.9619.qmail@science.horizon.com>
References: <20051118193652.6403.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:57639 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964781AbVKVAXl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Nov 2005 19:23:41 -0500
In-Reply-To: <20051118193652.6403.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux@horizon.com, linux-ide@vger.kernel.org

> One thing I wanna verify on sil24 is data integrity with multiple disks 
> attached.  It would be very helpful if you can do some parallel data 
> stress testing with multiple disks.
> 
> * Parallel 'badblocks -w -t random' on all attached disks.  Maybe repeat 
> it for a few days and verify no corrupted IO occurs.

Just completed 6 passes x 6 drives x 350 GB = 12.6 TB of badblocks (10^14
bits) with no errors.  That's in addition to a previous 5 passes that
was interrupted by timeout problems on one drive, but that's an error
handling issue and not a data corruption problem, and it did resolve
itself eventually after I killed the badblocks run.

That's several days of solid disk access at > 300 MB/sec.
(Some silly people asked me why I ingored the Sil3114 that came with
the motherboard...)

Thanks for a great driver!  I'll have even more fun testing NCQ one of
these days. :-)

Now rebooting to 2.6.14-rc2.  Now that it's stable, this system is going
into production Very Very Soon.  If you want any more testing, speak up!
