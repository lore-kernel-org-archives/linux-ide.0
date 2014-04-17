From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2] ahci: imx: software workaround for phy reset issue
 in resume
Date: Thu, 17 Apr 2014 10:05:10 +0800
Message-ID: <20140417020509.GM2523@dragon>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
 <20140415161018.GN1863@htj.dyndns.org>
 <20140416073823.GJ2523@dragon>
 <20140416140112.GB1257@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:19505
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754571AbaDQCFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 22:05:21 -0400
Content-Disposition: inline
In-Reply-To: <20140416140112.GB1257@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

On Wed, Apr 16, 2014 at 10:01:12AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 16, 2014 at 03:38:24PM +0800, Shawn Guo wrote:
> > The hardware manual suggests that an ACK will normally be given within
> > 100us.  So using msleep() will have it sleep longer than necessary for
> > normal case.  Basically, we're following the suggestion from
> > Documentation/timers/timers-howto.txt to use usleep_range() over
> > msleep().
> > 
> > SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
> > 	* Use usleep_range
> > 
> > 	- Why not msleep for (1ms - 20ms)?
> > 		Explained originally here:
> > 			http://lkml.org/lkml/2007/8/3/250
> > 		msleep(1~20) may not do what the caller intends, and
> > 		will often sleep longer (~20 ms actual sleep for any
> > 		value given in the 1~20ms range). In many cases this
> > 		is not the desired behavior.
> 
> But we don't care whether the minimum wait is actually 100us here, do
> we?  It's a reset path.  Let's please just be simple.  msleep(1) not
> actually sleeping 1ms is an implementation detail which may change in
> the future.  If this were in the command execution path, sure, but not
> here.

Functions imx_phy_reg_[addressing|write|read]() implement the phy
control register bus interface.  Though the interface is used only for
phy reset right now, it's not limited to phy reset but anything that
needs to access phy.

Even for reset path, we still care about the time.  I just quickly
tested it with replacing all those usleep_range() calls with msleep(1),
and found that the resume time increases dramatically, from 10.880 msecs
to 69.431 msecs.  The system resume speed is quite critical to some of
our customers.  If every device sleeps longer than necessary like that,
the system resume speed will be unacceptably slow.  So, please, allow
the use of usleep_range() here.

Shawn

=== usleep_range ===
$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Entering mem sleep
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
PM: suspend of devices complete after 51.209 msecs
PM: suspend devices took 0.060 seconds
PM: late suspend of devices complete after 4.651 msecs
PM: noirq suspend of devices complete after 4.869 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 4.010 msecs
PM: early resume of devices complete after 4.619 msecs
sd 0:0:0:0: [sda] Starting disk
PM: resume of devices complete after 10.880 msecs
PM: resume devices took 0.020 seconds
PM: Finishing wakeup.
Restarting tasks ... done.
$ ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133

=== msleep(1) ===
$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.002 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Entering mem sleep
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
PM: suspend of devices complete after 35.751 msecs
PM: suspend devices took 0.040 seconds
PM: late suspend of devices complete after 4.190 msecs
PM: noirq suspend of devices complete after 4.450 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 2.328 msecs
PM: early resume of devices complete after 2.774 msecs
sd 0:0:0:0: [sda] Starting disk
PM: resume of devices complete after 69.431 msecs
PM: resume devices took 0.070 seconds
PM: Finishing wakeup.
Restarting tasks ... done.
$ ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133

