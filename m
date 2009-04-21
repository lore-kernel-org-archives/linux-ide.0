From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl
	0)
Date: Tue, 21 Apr 2009 10:05:10 +0200
Message-ID: <18925.32310.909665.474085@pilspetsen.it.uu.se>
References: <20080113234320.GA6225@roeckx.be>
	<18315.7567.747367.84127@harpo.it.uu.se>
	<20080115000953.GA2799@roeckx.be>
	<18316.31910.973794.732242@harpo.it.uu.se>
	<20080115173557.GA3033@roeckx.be>
	<18317.54768.524651.128063@harpo.it.uu.se>
	<20090420182503.GA10768@roeckx.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:40158 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbZDUIFR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Apr 2009 04:05:17 -0400
In-Reply-To: <20090420182503.GA10768@roeckx.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kurt Roeckx <kurt@roeckx.be>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Kurt Roeckx writes:
 > On Wed, Jan 16, 2008 at 11:01:20AM +0100, Mikael Pettersson wrote:
 > > Kurt Roeckx writes:
 > >  > On Tue, Jan 15, 2008 at 10:28:06AM +0100, Mikael Pettersson wrote:
 > >  > >  > 00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
 > >  > > ...
 > >  > >  > 00:08.0 0104: 105a:3376 (rev 02)
 > >  > > 
 > >  > > Let me guess, this is a Promise chip included on the mainboard
 > >  > > as a RAID controller, and not an add-on PCI card?
 > >  > 
 > >  > Yes, it's a K8V motherboard which has that onboard.
 > >  > 
 > >  > > If it's a mainboard chip, please enter the BIOS and see if it
 > >  > > can be configured for non-RAID mode. If it can, please reconfigure
 > >  > > it and boot Linux. Does it still claim to be a 20376 or is it
 > >  > > now a 20378?
 > >  > 
 > >  > I can't find an option to turn that off in the BIOS.  If it did, I'd
 > >  > probably have turned it off already.  I've also opened the case and it
 > >  > says PDC20376 on the chip.
 > > 
 > > Ok. I haven't yet found any information about the 20376 which
 > > could explain why the 20376 fails while the 20378 works.
 > > For now, you can disable hotplugging in the driver by applying
 > > the patch below. This should at least bring back some stability
 > > to your system.
 > > 
 > > Longer-term I guess I'll have to invent a blacklist mechanism
 > > to automatically prevent 20376 chips from enabling hotplugging.
 > > That is, unless someone can show me a system where a 20376
 > > actually does work with hotplugging, in which case I'd need a
 > > module parameter (yuck) or some form of dynamic detection of
 > > this condition.
 > 
 > Hi,
 > 
 > I'm still having this problem with a 2.6.29 kernel.  I want to
 > avoid always having to patch my kernel, so I would like to see
 > some solution to this.  What do you think that the best way
 > forward is?

Since the previous discussion I've seen the 20378s in two
identical mainboards of a particular model also throw spurious
hotplug events. It would be possible to blacklist hotplugging
on all SATA1 models, but that would also affect SATA1-based
PCI cards like the SATA150 TX2/TX4 which don't appear to
have this problem.

Can you post the lspci -vvn output for your 20376?
