From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 19 Feb 2008 01:39:09 -0500
Message-ID: <20080219063909.GA31055@denix.org>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:44826 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbYBSGjL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 01:39:11 -0500
Received: from gandalf.denix.org ([71.255.238.68]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JWH00C0Q39LM562@vms173001.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 19 Feb 2008 00:27:22 -0600 (CST)
In-reply-to: <20080219043659.GA11936@jim.sh>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-ide@vger.kernel.org

On Mon, Feb 18, 2008 at 11:36:59PM -0500, Jim Paris wrote:
> Denys Dmytriyenko wrote:
> > I've been following this list for several months now trying to spot a similar
> > issue or to gain knowledge to resolve mine.
> ..
> > I'm running a fileserver with array of 10 disks (8 Seagate 500GB 7200.9 and
> > 7200.10 plus 2 Maxtors)
> ..
> > Power supply was
> > originally 550 watt Enermax (should be enough power, according to a wattmeter),
> > but to be sure was replaced to 750 watt Coolermaster.
> 
> Hi,
> 
> As you may have noticed on this list, power supplies are very
> frequently a problem.  Just taking what you said, a ST3500630AS
> 7200.10 disk requires up to 2.8A peak on the +12V line, which is 28A
> total for 10 disks.  The Coolermaster Real Power Pro 750 has three
> separate 12V rails and each can only go up to 19A.  So that might
> already be the answer, depending on how the rails match up with your
> wiring.
> 
> I suggest hooking up a couple of the disks to your old power supply
> and powering them up separately [1].  If you don't see any problems on
> those disks then it was likely power related.

Hi,

Thanks for the reply. Power supply was the first thing to check, that's why I
mentioned that it was upgraded. The Coolermaster Real Power Pro 750 actually
has 4 separate 12V rails, but AFAIK 2 of them only available to the PCIe
connectors and not to the regular Molex/SATA connectors. Others I distributed
equally among the drives. BTW, I should probably get some PCIe 6-pin/8-pin to
Molex 4-pin adapters to utilize those unused 12V rails...

2.8A peak is used mainly during spin up, which is staggered in my case (ICY
Dock SATA enclosure). Even when all disks were spun up at the same time,
wattmeter never showed anything close to 500 watt. During normal operation
no more than 2 disks are accessed at a time, plus most of them are in standby,
as I mentioned. And good PSUs, like previous Enermax and current Coolermaster
can withstand additional 100-150 watt of peak load...

I used to run the system with fewer (4) drives and was still experiencing
problems. Not to mention that power problem would not cause the second issue
of poor performance.

Thanks again.

Regards,
Denys
