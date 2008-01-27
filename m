From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.6.24 sata_promise SATA300TX4 problems
Date: Sun, 27 Jan 2008 03:11:53 +0100
Message-ID: <18331.59497.908868.283142@harpo.it.uu.se>
References: <479B0A39.2050700@how.dk>
	<18331.53035.493189.308501@harpo.it.uu.se>
	<479BD2E2.2060307@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:56454 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbYA0CL7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 21:11:59 -0500
In-Reply-To: <479BD2E2.2060307@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Peter Favrholdt writes:
 > Hi Mikael,
 > 
 > Thanks for your reply :-)
 > 
 > Mikael Pettersson wrote:
 > > Mysterious. What you have there is a transmission error between the
 > > controller and the disk, which is bad in and by itself, but then there's
 > > a sequence of COMRESETs that fail to bring the port or disk back to life.
 > > 
 > > The original error is not a driver error but something caused by your
 > > system, be it a dodgy cable, a poorly seated cable, or electrical
 > > interference. But the failed COMRESETs is a concern as I've seen them
 > > in other reports as well.
 > 
 > Maybe I should try switching cables (again). Or it could be a 
 > motherboard issue (NFORCE2)?
 > 
 > > Me worried ...
 > > 
 > > So going back to 2.6.21-rc2 makes the system stable again? Can you do some
 > > more testing to see at what point the system becomes less stable? I.e.,
 > > 2.6.21-rcI, 2.6.22, 2.6.22-rcJ, 2.6.23, or 2.6.24-rcJ?
 > 
 > I believe the important part is your 1.5Gbps patch which I applied to 
 > 2.6.21-rc2. Maybe the reason for being stable is that the transmission 
 > error will not show up at that speed - thus not having anything to do 
 > with the kernel version. I'm quite sure the problem is there using 
 > 2.6.21-rc2 at 3Gbps.
 > 
 > > FWIW, I just completed some testing of a 300 TX4 card with kernel 2.6.24,
 > > including dd:s, fscks, mkfs:s, and copying about 400GB of data from one drive
 > > (Samsung) to another (Seagate 7200.10) on that card, and I cannot seem to break it.
 > 
 > I believe it only happens if I stress all four drives simultanously. So 
 > maybe the transmission error is somehow related to the overall stress of 
 > the PCI bus/card/chip/whatever?
 > 
 > If it is not too much of a hassle, could you please make a 1.5Gbps patch 
 > for 2.6.24 for me to try out? If it solves the problem (without me ever 
 > touching the cables) we know for sure it is speed-related and not due to 
 > kernel version.

No problem. I had intended to drop that patch after 2.6.24-rc8 as it
ought to be obsolete, but then again it might not be. It's available here:
<http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24>
