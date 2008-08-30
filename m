From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA ALPM min_power causes > 10s delay on resume
Date: Sat, 30 Aug 2008 13:02:04 +0200
Message-ID: <48B928AC.8090007@kernel.org>
References: <1219598870.11057.2.camel@stinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38944 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbYH3LDP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 07:03:15 -0400
In-Reply-To: <1219598870.11057.2.camel@stinkpad>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jeffrey W. Baker" <jwbaker@gmail.com>
Cc: linux-ide@vger.kernel.org

Jeffrey W. Baker wrote:
> I started using the min_power ALPM setting on my ThinkPad to save power
> (which works great, thanks!) but it causes a small problem.  When the
> machine resumes from suspend-to-ram it hangs for about 10s and then
> prints this on the console:
> 
> ata1: COMRESET failed (errno=-16)
> 
> It then proceeds normally.  The full messages are:
> 
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: soft resetting link
> ata1: SATA link down (SStatus 611 SControl 300)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting link
> ata1: port is slow to respond, please be patient (Status 0x80)
> ata1: COMRESET failed (errno=-16)
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 
> After which point the machine works normally.  The SATA controller is an
> Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev
> 03) and the SATA target is a SAMSUNG MCBQE32G Rev: PS10.  The kernel is
> 2.6.24.  I haven't tried anything newer.
> 
> If the ALPM setting is left at its default of max_performance then
> resume from suspend is instant.  Is there any way to work around this?
> ALPM is worth a solid 30 minutes of extra battery life, so obviously I'd
> like to use it.  If nothing else, it might be helpful to have a module
> parameter to shorten the timeout on known-working hardware.

Which kernel version are you using?

-- 
tejun
