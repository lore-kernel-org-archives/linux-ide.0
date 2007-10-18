From: Tejun Heo <htejun@gmail.com>
Subject: Re: timeouts with SiI 4726/3531
Date: Thu, 18 Oct 2007 16:13:41 +0900
Message-ID: <471707A5.1000004@gmail.com>
References: <87lkaf3moh.fsf@wyrd.be> <87lkadsab5.fsf@wyrd.be>	<470D93B2.9000603@gmail.com> <87bqb5wh29.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:7704 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXJRHNt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 03:13:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so80663rvb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 00:13:49 -0700 (PDT)
In-Reply-To: <87bqb5wh29.fsf@wyrd.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lieven Marchand <mal@wyrd.be>
Cc: linux-ide@vger.kernel.org

Hello,

Lieven Marchand wrote:
> I have an external enclosure based on the SiI 4726 connected to the
> 3531 controller. It mostly works on a Debian 2.6.22 kernel patched
> with libata-tj-2.6.22.1-20070808. But occasionally under high load
> there are timeouts. Usually, the system recovers without a problem but
> once a disk wasn't found after the reset. It took a power off/power on
> of the device.
> 
> Another weird problem is that the SiI 4726 software doesn't find its
> controller, although the config disk is found by the system. I was
> going to use the device in JBOD mode anyway so this isn't a big deal.

It doesn't work (yet).  The config disk is very quirky and the 4726
manager program needs some changes to work with libata-pmp support.

> Thanks for a great job. It's amazing how well this works already. I
> see on the SiI site they distribute a kernel module for Suse/Redhat
> for the 3531. Is the source available for it and does it work better
> with it?

That driver is closed source and I don't know whether it works well or
not.  Never tried it.

> I haven't tested the disks out of the enclosure so I don't know if
> they work well with NCQ without PMP. I can't move other disks to the
> enclosure to test because all of the disks internal in the machine are
> in an LVM needed to boot.
> 
> Most of the time there's just the timeout which is bad for performance
> but occasionally one of the disks doesn't come up and then I have to
> rebuild the array.

Can you please take the drive out of the enclosure and connect directly
to the board and put it under stress test?  We need to determine whether
we need to blacklist NCQ for the drive or not.

Thanks.

-- 
tejun
