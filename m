From: Roger Heflin <rheflin@atipa.com>
Subject: Re: sata_mv issues with more than 1 disk in FC5 2.6.16-1.2096
Date: Thu, 27 Apr 2006 10:06:53 -0500
Message-ID: <4450DE0D.2090807@atipa.com>
References: <4447EA40.9010503@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:36874 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S965145AbWD0PGz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Apr 2006 11:06:55 -0400
In-Reply-To: <4447EA40.9010503@atipa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: linux-ide@vger.kernel.org

Roger Heflin wrote:
> Hello,
> 
> I know the FC5 2.6.16-1.2096 is based off of one of the 2.6.16
> stable releases.   I am not sure exactly which one this is based
> on.
> 
> I have several machines with this controller, the ones with a single
> disks all work correctly using the Marvell controller.
> 
> An identical MB/controller/chassis fails when there are 2 disks
> using software mirroring.  We have tested with 2 separate chassis,
> both exhibit the same failure.
> 
> Moving the 2 disks to a different built-in sata controller
> (sata_nv) results in the disks and the mirror working
> correctly.
> 
> The errors that it returns are:
> ata4: status=0xd0 { Busy }
> ata2: status=0xd0 { Busy }
> And the machine is terribly slow while this error is happening.
> The error appears to be happening when the disks are trying
> to be mounted.
> 
> We have tested the disk on a couple of different combinations of
> ports and this does not seem to change anything.
> 
> The single disk machines don't get this error like the 2 disk
> machines, though  they do get this error, every 30 minutes
> or so (probably from  smartd), but this error does not
> appear to be causing issues.
> Apr 19 16:26:19 lab229 kernel: ata1: status=0xd0 { Busy }
> Apr 19 16:26:19 lab229 kernel: ATA: abnormal status 0xD0 on
>     port 0xFFFFC2001012211C
> 
> Any thoughts?
>


A follow up, it passes the test with nosmp set, it fails every time
without nosmp.

acpi_irq_nobalance and noirqbalance and the irqbalance service
stopped or never started it works better, it takes longer to lock
up, and after it locks up it appears to come back and work for
around 30-60 seconds and then starts working again after being
hung for 30-60 seconds, but eventually it appears to completely
lock up and not work anymore.   MTBF is around 30 seconds for
the first event, and it stops working completely after several
minutes  vs. 1-2 seconds for the irq balancing enabled. The output of
/proc/interrupts does confirm that the interrupts are not being balanced.


To make the failure happen it appears to require several conditions:
SMP 2 disks or more doing heavy IO.

Having the irq's balanced appears to make the problem happen much faster,
but not having the irq's balanced does not appear to stop the problem.

I have not tested the nosmp option long enough to conclude that it
is very unlikely to occur in that case.

With "noapic" things seem to be stable and seem to work with both disk
doing io, and this is with the irq's still being balanced.

When it works the speeds are good in all cases 65MiB/second for the first
disk, and 130MiB/second when the second disk is added, all tested with dd.

What does noapic fixing the problem say about the cause
of the underlying issue?

                                      Roger



