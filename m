From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem:  security locked disk and partition table read..
Date: Wed, 19 Jan 2011 16:08:22 +0100
Message-ID: <20110119150822.GB22366@htj.dyndns.org>
References: <4D366DF1.3000303@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab1ASPI0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2011 10:08:26 -0500
Received: by fxm20 with SMTP id 20so976631fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 19 Jan 2011 07:08:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D366DF1.3000303@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Jan 18, 2011 at 11:52:01PM -0500, Mark Lord wrote:
> I was sorting through drives here today, and found one that
> was "security locked" (had a user passwd set on it),
> and for which I did not know the password.
> 
> So I hotplugged it to my SiI-3132 card, with the intent
> of simply erasing the drive (thereby clearing the passwd)
> using hdparm.
> 
> Except.. the kernel (?) sat there for a very long time trying
> (and failing) over and over and over and over and over and over
> to read sector-0 (the partition table).  Of course the reads
> each failed, and then got retried 5-times by SCSI, and then
> retried again a zillion times at a higher level.

I think SCSI and libata are behaving okay here.  The root cause is how
the partition code handles IO errors.  Different partition table type
probes do IOs separately.  It's somewhat reasonable given that they
may poke at different sectors which sometimes could be near the end of
the device failure of which might not necessarily mean the whole
device is inaccessible, but anyways the end result is that the each
partition table type pokes the drive regardless of how the previous
attempt went.  And yeah we probably need some improvements there.

Thanks.

-- 
tejun
