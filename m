From: Tejun Heo <tj@kernel.org>
Subject: Re: PMPs
Date: Thu, 02 Apr 2009 09:30:52 +0900
Message-ID: <49D4073C.4010101@kernel.org>
References: <alpine.DEB.1.10.0904012109180.28814@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35571 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759357AbZDBAbB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 20:31:01 -0400
In-Reply-To: <alpine.DEB.1.10.0904012109180.28814@uplift.swm.pp.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: linux-ide@vger.kernel.org

Hello,

Mikael Abrahamsson wrote:
> I have a SiL based PCI-E card and a PMP:
> 
> 02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA
> Raid II Controller (rev 01)
> 
> ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
> 
> I'm using Ubuntu 8.10 kernel 2.6.27-11-generic #1 SMP Thu Jan 29
> 19:24:39 UTC 2009 i686 GNU/Linux
> 
> I'm running into all kinds of weird behaviour, like only P1 (port 1
> out of 5) on the PMP working with single drive. Also, it seems to
> differ whether I have a WD or Samsung drive, the WD drive works
> alone in P1 and P2 of the PMP, with the Samsung drive only working
> alone in P1. If I put the Samsung drive in P1 and put the WD drive
> in P3, the P3 drive isn't recognised upon hotplug. If I unplug
> Samsung P1 drive and re-insert it in the same P1 hotswat bay again,
> drives in both P1 and P3 are recognised upon P1 spinning up and
> being recognised.
> 
> Is this a known problem?
> 
> This is perfectly reproducible, I can provide logs if that would
> help.  I'm also willing to try 2.6.29.x if there has been work done
> after 2.6.27.

You need to keep the first port occupied for 3726/4726; otherwise, the
fake config disk jumps around and it just goes belly up.  Do you
experience problems even with the first port occupied?

Thanks.

-- 
tejun
