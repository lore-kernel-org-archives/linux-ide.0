From: Kurt Roeckx <kurt@roeckx.be>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl
	0)
Date: Wed, 15 Jul 2009 19:46:02 +0200
Message-ID: <20090715174602.GA3684@roeckx.be>
References: <20080115000953.GA2799@roeckx.be> <18316.31910.973794.732242@harpo.it.uu.se> <20080115173557.GA3033@roeckx.be> <18317.54768.524651.128063@harpo.it.uu.se> <20090420182503.GA10768@roeckx.be> <18925.32310.909665.474085@pilspetsen.it.uu.se> <20090421162507.GA16798@roeckx.be> <20090621221002.GA11170@roeckx.be> <19008.49605.448797.606574@pilspetsen.it.uu.se> <19011.30301.825635.763918@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from georges.telenet-ops.be ([195.130.137.68]:50933 "EHLO
	georges.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbZGORqH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2009 13:46:07 -0400
Content-Disposition: inline
In-Reply-To: <19011.30301.825635.763918@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Thu, Jun 25, 2009 at 03:06:37PM +0200, Mikael Pettersson wrote:
>  > 
>  > Sorry, I dropped the ball on that one. (Too many projects requiring
>  > my attention.) I think the safest solution is to just disable hotplug
>  > interrupts on SATA1 chips. I'll give that a try in 2-3 days (busy with
>  > other stuff).
> 
> Some 1st generation Promise SATA chips generate spurious hotplug events
> which can disrupt normal operation. This has been observed on 20376 and
> 20378 chips. This patch thus disables hotplug support on 1st gen chips
> while leaving it enabled for 2nd gen chips.
> 
> Tested on a 2nd gen SATA300 PCI card and a 1st gen 20378 mainboard chip.
> 
> Kurt, does this work for your 20376?

Yes, works perfectly.

Sorry that I took so long to respond to this.


Kurt

