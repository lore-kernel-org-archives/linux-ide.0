From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: IRQ issues with multiple SiI3114's on Kernel 3.2
Date: Fri, 27 Jul 2012 12:24:52 -0500
Message-ID: <5012CEE4.8040306@hardwarefreak.com>
References: <CAJt7KB8-yPm7RX8doKw1WjYwxfvVQ8Af7GNmu=QVsM_sAtYKiQ@mail.gmail.com>
Reply-To: stan@hardwarefreak.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:41952 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2G0RdU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 13:33:20 -0400
In-Reply-To: <CAJt7KB8-yPm7RX8doKw1WjYwxfvVQ8Af7GNmu=QVsM_sAtYKiQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stirling Westrup <swestrup@gmail.com>
Cc: linux-ide@vger.kernel.org

On 7/27/2012 11:40 AM, Stirling Westrup wrote:

> I recently purchased a large system for use as a backup server for a
> pair of small businesses. It contains a boot drive plus 10 more
> storage drives. Despite having three onboard SATA controllers, the
> motherboard didn't have enough SATA connectors for all the drives, so
> I installed a pair of identical SiI3114 raid cards to handle the extra
> connections. It has a Sandy Bridge chipset, so I installed a 3.2
> kernel.
> 
> # uname -a
> Linux ttt 3.2.0-0.bpo.2-amd64 #1 SMP Fri Jun 29 20:42:29 UTC 2012
> x86_64 GNU/Linux
...
> Okay, enough background. Here's the issue: I had no trouble building
> and sync'ing the first array, but when I try to sync the second array,
> I always get the following dmesg an hour or so into the process:
>
> irq 19: nobody cared (try booting with the "irqpoll" option)
> [  346.120572] Pid: 1100, comm: md1_resync Not tainted
3.2.0-0.bpo.2-amd64 #1
> [  346.120573] Call Trace:
> ...
> [  346.120697] handlers:
> [  346.120699] [<ffffffffa00479e0>] ahci_interrupt
> [  346.120702] [<ffffffffa02f17ec>] sil_interrupt
> [  346.120703] Disabling IRQ #19
> [  346.122145] sched: RT throttling activated
...
> From this point onward syncing drops to a tiny fraction of its
> previous speed. I've tried booting with 'irqpoll' as the error message
> suggests, but it has had no effect. I'm really not sure if there is a
> conflict between my two SiI3114's or between the SiI's and the Marvell
> controller (although I've never had an issue with Marvell in the
> past), nor how to go about diagnosing or fixing this.  I'll include a
> full dmesg dump below, as well as my currently loaded modules. If
> anyone wants any further info, just ask.

Have you tried irqbalance to spread the interrupts across cores/cache
domains? https://irqbalance.org/documentation.html

Dual/quad socket machines benefit more than a single socket machine, but
the latter can still benefit if the cache hierarchy is appropriate.

~$ aptitude install irqbalance

No guarantees this will fix your problem but it's worth a shot.  Takes a
few seconds to install, and it won't cause any negative effects, even if
it yields no positive effects.

-- 
Stan

