From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA hotswap and write caches
Date: Fri, 08 Jun 2007 22:05:24 +0900
Message-ID: <46695414.70807@gmail.com>
References: <20070603104334.GH18680@zoy.org> <4662CF26.6060902@garzik.org> <20070604005341.GA3315@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:61745 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937855AbXFHNFb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 09:05:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1053930wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 06:05:30 -0700 (PDT)
In-Reply-To: <20070604005341.GA3315@zoy.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Michel Lespinasse wrote:
> On Sun, Jun 03, 2007 at 10:24:38AM -0400, Jeff Garzik wrote:
>> Michel Lespinasse wrote:
>>> * Is there anything one needs to know before hot-removing a drive ?
>> Make sure all data is flushed to the drive before removing it.
> 
> Sure. Is there a way to do that, though, other than using /sbin/halt
> which seems to have, errr, undesirable side-effects :)
> 
> Ideally it'd be very nice if that was doable through /sys or /proc files.
> It'd also be nice if disk standby was user-controllable in this way too.
> (or maybe both as one step, i.e. a way to tell the kernel we'd like to
> take the disk out in the safest way possible).

If you're using barrier, you should be in the clear, I think.

-- 
tejun
