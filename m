From: Sebastian Siewior <ide+bug@ml.breakpoint.cc>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sat, 9 Feb 2008 22:22:37 +0100
Message-ID: <20080209212237.GA22582@Chamillionaire.breakpoint.cc>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc> <200802092128.39247.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:59841 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754396AbYBIVWj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 16:22:39 -0500
Content-Disposition: inline
In-Reply-To: <200802092128.39247.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

* Bartlomiej Zolnierkiewicz | 2008-02-09 21:28:39 [+0100]:

>It could be that due to block layer changes to I/O barrier handling
>allocating ATA command structure on the stack is no longer safe.
>
>Please try booting with "hdx=noflush" kernel parameter or please try
>the attached patch which should fix the issue (if my theory is correct).
That was quick.
hdx=noflush worked well. The patch delayed the disk access as you can
see in [1]. After the IPI message the hd led enlightened and was
active until "lost interrupt" message. The following boot process was
verry slow. Basically everything what required disk access took a while
and the hd-led was almost continuous on. I aborted the boot process via
magic keys after about 15 minutes.

[1] http://download.breakpoint.cc/lnx-2.6.24-post-long-boot.jpg

Sebastian
