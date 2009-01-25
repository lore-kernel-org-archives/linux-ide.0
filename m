From: Tejun Heo <htejun@gmail.com>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Sun, 25 Jan 2009 10:12:50 +0900
Message-ID: <497BBC92.5090208@gmail.com>
References: <20090120002923.065f24ca@diego-desktop> <4976F89A.1040405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:58182 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZAYBMw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 20:12:52 -0500
In-Reply-To: <4976F89A.1040405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Horn <patrick.horn@gmail.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Patrick.

Patrick Horn wrote:
...
> Is this error just coincidence, or did Seagate forget to mention my drive?
> (And what happened to the firmware updates--they seem to be "In
> Validation")
> Is seagate the only site with information about this? Any public
> blacklist of every affected drive? What can I see in dmesg that
> indicates that NCQ is the cause?

I think it's coincidental.  AFAIK, there was no report of increased
transmission failures.  Two known problems with these firmwares are

1. timeout on FLUSH if NCQ is in use on certain drives

2. bricking after power off (so, the failure is almost always during
   BIOS probing during boot)

> (I'll paste my dmesg as I don't know enough to tell if this is the same
> issue as the other seagate drives--I trimmed the repetitive parts)
> 
> [ 7520.699730] ata2.00: exception Emask 0x10 SAct 0x7ff4f SErr 0x400100
> action 0x6 frozen
> [ 7520.699734] ata2.00: irq_stat 0x08000000, interface fatal error
> [ 7520.699738] ata2: SError: { UnrecovData Handshk }

This is transmission error.  Most common causes are power related or
unreliable connection especially if backplanes are involved.  Is the
problem still reproducible?  If so, can you please try to move it to
different power connector and SATA port and see what changes?

Thanks.

-- 
tejun
