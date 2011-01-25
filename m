From: Tejun Heo <tj@kernel.org>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Tue, 25 Jan 2011 11:01:10 +0100
Message-ID: <20110125100110.GM27510@htj.dyndns.org>
References: <20110125030410.GA24024@MAIL.13thfloor.at>
 <yq14o8x3c8t.fsf@sermon.lab.mkp.net>
 <20110125033259.GC24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41798 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1AYKBP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 05:01:15 -0500
Received: by fxm20 with SMTP id 20so5032933fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 25 Jan 2011 02:01:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110125033259.GC24024@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

Hello,

On Tue, Jan 25, 2011 at 04:32:59AM +0100, Herbert Poetzl wrote:
> > Align your partitions on a 4K boundary.
> 
> While this will ensure that the drive performance is better
> than without doing so (I'm not using a partition table on that
> drive anyways, but I get what you mean), this doesn't inform
> the kernel about proper I/O sizes and for sure doesn't prevent
> unnecessary read-change-write operations for the disc ...

Kernel doesn't really care.  Well, the fs should align things to 4KiB
but all the modern ones already do so.  The only thing necessary is
aligning the partition table.  Whether the drive lies about physical
sector or not, most modern distros unconditionally align partitions to
1MiB.  So, as long as you use a distro which was released in the past
six month, there's nothing to worry about.

Thanks.

-- 
tejun
