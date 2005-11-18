From: linux@horizon.com
Subject: Re: sata_sil24 test support
Date: 18 Nov 2005 14:36:52 -0500
Message-ID: <20051118193652.6403.qmail@science.horizon.com>
References: <20051118022349.12316.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:55864 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932197AbVKRTg7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Nov 2005 14:36:59 -0500
In-Reply-To: <20051118022349.12316.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org
Cc: linux@horizon.com

> One thing I wanna verify on sil24 is data integrity with multiple disks 
> attached.  It would be very helpful if you can do some parallel data 
> stress testing with multiple disks.
> 
> * Parallel 'badblocks -w -t random' on all attached disks.  Maybe repeat 
> it for a few days and verify no corrupted IO occurs.

I only ran it for a day, but I can report success on exactly this
test on 6x Seagate 7200.8 drives (350G partition of 400G drives)
across 3x Sil3132.

That's how I found my problems, and how I verified that they were gone.

(The only "intereting" finding was that one drive was noticeably slower
than the others.  Not 10%, but it finished most of an hour later.  I
checked the cables and all looked well, and its partner on the same
controller was fine.  I'm going to do a bit of swapping to experiment.)

This is with CONFIG_PCI_MSI=y.  It was run in single-user mode (all
file systems mounted read-only) because the question was whether
live file systems were safe.

One thing I'm thinking of as a *driver* test is to write a little utility
that uses O_DIRECT to do heavy I/O to the drive's cache.  That should
be able to exceed the 60 MB/sec media transfer rate limit.
