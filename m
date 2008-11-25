From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Suspend w/ sata_promise
Date: Tue, 25 Nov 2008 22:05:27 +0100
Message-ID: <18732.26775.608419.541321@harpo.it.uu.se>
References: <49202CB0.60507@gc-web.de>
	<18720.18615.938839.921189@harpo.it.uu.se>
	<492060D9.20808@gc-web.de>
	<18723.52001.559166.255589@harpo.it.uu.se>
	<18728.13696.418178.143954@harpo.it.uu.se>
	<4928569C.9080805@gc-web.de>
	<18729.54297.692199.41534@harpo.it.uu.se>
	<18730.39324.527421.503774@harpo.it.uu.se>
	<492B2A49.4060904@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38367 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbYKYVFf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 16:05:35 -0500
In-Reply-To: <492B2A49.4060904@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Alexander Clausen writes:
 > Mikael Pettersson wrote:
 > > Mikael Pettersson writes:
 > >  > 
 > >  > Are you absolutely certain both patches were applied and the driver rebuilt?
 > >  > I'm asking because I would have expected to see
 > >  > 
 > 
 > Yes, pretty sure.
 > 
 > >  > [...] sata_promise 0000:00:0d.0: restoring config space at offset 0x1 (...)
 > >  > 
 > >  > but your kernel log does not contain anything like that. Both machines
 > >  > I tested on today consistently included this message after the patch was
 > >  > applied, but did not when the patch wasn't applied.
 > 
 > Ok, that is strange.
 > 
 > >  > 
 > >  > I did note some temporary errors (that sata_promise recovered from) on
 > >  > one machine after resuming from suspend to ram that did not occur when
 > >  > using standby. I'll update the patch to include a controller reinit in
 > >  > the ->resume op, which should hopefully fix that.
 > > 
 > > Here's an updated suspend patch for sata_promise. It will now
 > > do a HW re-init of the controller and its ports on resume,
 > > which should help e.g. S2R when all state may have been lost.
 > > 
 > > Depending on machine, suspend type (standby or mem), and disk
 > > I do get different results, some cases come up very cleanly
 > > while others have some transient failures; however in my tests
 > > libata EH always recovers.
 > > 
 > > Only tested on 2nd gen controllers as my 1st gen is at another site.
 > > 
 > > If this still doesn't work, try changing the #if 0 in pdc_pci_device_resume()
 > > to #if 1, that will make it issue a HW reset to all ATA engines before
 > > reinitialising them (shouldn't be needed, which is why it's disabled).
 > 
 > Ok, I tried this patch (with and without the HW reset). Also, I disabled the NVidia driver, and
 > indeed, I did have APIC disabled (in the .config, no idea why, really), so I enabled it.
 > Same failure, still happens on second suspend, updated dmesgs attached.

I tried these patches now on my K8T Neo FIS2R w/ PDC20378.
I can do several standby suspends (S1) ok, but I can only do one
mem suspend (S3): while it resumes w/o errors the machine hangs hard
if I try a second S3 suspend. In that case there are no errors before
the hang, so I can't tell if sata_promise is involved or not.

Oh well, that machine has other issues as well (hangs during
reboot if the CPU has been slowed down by cpufreq), so I'm
considering that particular machine a lost cause wrt suspend.

/Mikael
