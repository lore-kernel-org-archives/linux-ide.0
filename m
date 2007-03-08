From: Jim Paris <jim@jtan.com>
Subject: Re: sata-nv hotplug feature
Date: Thu, 8 Mar 2007 04:38:10 -0500
Message-ID: <20070308093810.GA19929@jim.sh>
References: <200703072039.18588.rweeks@razorwire.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:58481 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030464AbXCHJiV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 04:38:21 -0500
Content-Disposition: inline
In-Reply-To: <200703072039.18588.rweeks@razorwire.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russ Weeks <rweeks@razorwire.ca>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

> I'd like some more information regarding the device hotplug feature for the 
> sata-nv driver.  The FAQ indicates that 'device hotplug' == 'yank the drive': 
> this seems more like 'hot-unplug' to me.  Can I then plug the drive back in 
> after I've unplugged it?
> 
> This thread:
> http://www.mail-archive.com/ubuntu-server@lists.ubuntu.com/msg00182.html
> 
> Seems to indicate that I can do it, but I may need to refresh the SCSI device 
> system somehow.  This suits my needs just fine, as long as a plug doesn't 
> necessitate a reboot.  But running rescan-scsi-bus.sh doesn't seem to work.
> 
> uname -a:
> Linux backfire 2.6.19.2-smp #2 SMP Sat Mar 3 13:06:28 PST 2007 x86_64 x86_64 
> x86_64 GNU/Linux
> 
> lspci shows this:
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
> 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
> 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)

Hi Russ,

I believe you need this patch from Tejun:

  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=722420fe6e2ab63bebc5a9ea346016b59076d75d

which is in kernel 2.6.20.  Original thread is here:
  
  http://thread.gmane.org/gmane.linux.ide/13219

-jim
