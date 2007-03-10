From: "Russ Weeks" <rweeks@razorwire.ca>
Subject: RE: sata-nv hotplug feature
Date: Fri, 9 Mar 2007 22:36:49 -0800
Message-ID: <000401c762de$7baf5b60$6400a8c0@foxbat>
References: <20070308093810.GA19929@jim.sh>
Reply-To: <rweeks@razorwire.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from defout.telus.net ([199.185.220.240]:56286 "EHLO
	defout.telus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbXCJGgv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 01:36:51 -0500
In-Reply-To: <20070308093810.GA19929@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jim Paris' <jim@jtan.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Thanks, Jim, Tejun.  Upgrading to 2.6.20 solved all my problems.

What I observe now is that once the drive is plugged in again, 2-3
minutes may pass before the device entry appears in /dev.  This isn't a
problem for me, but if you have time to explain I'd be interested to
know why.

Also, if you have any tips on 'best practices' for drive yanking, I'd
appreciate 'em.  So far I'm just doing 'sdparm --command=stop'.

Thanks again for the great drivers!

Russ

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Jim Paris
> Sent: Thursday, March 08, 2007 1:38 AM
> To: Russ Weeks
> Cc: linux-ide@vger.kernel.org; htejun@gmail.com
> Subject: Re: sata-nv hotplug feature
> 
> 
> > I'd like some more information regarding the device hotplug feature 
> > for the
> > sata-nv driver.  The FAQ indicates that 'device hotplug' == 
> 'yank the drive': 
> > this seems more like 'hot-unplug' to me.  Can I then plug 
> the drive back in 
> > after I've unplugged it?
> > 
> > This thread: 
> > 
> http://www.mail-archive.com/ubuntu->
server@lists.ubuntu.com/msg00182.ht
> > ml
> > 
> > Seems to indicate that I can do it, but I may need to 
> refresh the SCSI 
> > device
> > system somehow.  This suits my needs just fine, as long as 
> a plug doesn't 
> > necessitate a reboot.  But running rescan-scsi-bus.sh 
> doesn't seem to work.
> > 
> > uname -a:
> > Linux backfire 2.6.19.2-smp #2 SMP Sat Mar 3 13:06:28 PST 
> 2007 x86_64 
> > x86_64
> > x86_64 GNU/Linux
> > 
> > lspci shows this:
> > 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev 
> f2) 00:07.0 
> > IDE interface: nVidia Corporation CK804 Serial ATA 
> Controller (rev f3) 
> > 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA 
> Controller 
> > (rev f3)
> 
> Hi Russ,
> 
> I believe you need this patch from Tejun:
> 
 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=722420fe6e2ab63bebc5a9ea346016b59076d75d

which is in kernel 2.6.20.  Original thread is here:
  
  http://thread.gmane.org/gmane.linux.ide/13219

-jim
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html

