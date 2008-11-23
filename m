From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Suspend w/ sata_promise
Date: Sun, 23 Nov 2008 23:07:21 +0100
Message-ID: <18729.54297.692199.41534@harpo.it.uu.se>
References: <49202CB0.60507@gc-web.de>
	<18720.18615.938839.921189@harpo.it.uu.se>
	<492060D9.20808@gc-web.de>
	<18723.52001.559166.255589@harpo.it.uu.se>
	<18728.13696.418178.143954@harpo.it.uu.se>
	<4928569C.9080805@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:39783 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbYKWWH2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Nov 2008 17:07:28 -0500
In-Reply-To: <4928569C.9080805@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Alexander Clausen writes:
 > Mikael Pettersson wrote:
 > >  > 
 > >  > Based on several other libata sata drivers I think handling suspend in
 > >  > sata_promise may be as simple as hooking ata_pci_device_{suspend,resume},
 > >  > which is what the patch below does. If this doesn't work then the most
 > >  > likely solution is to augment the ->resume op with a Promise-specific
 > >  > controller reset (again similar to several other sata drivers).
 > >  > 
 > >  > Care to give it a try? The patch is against 2.6.28-rc5 but should also
 > >  > work in 2.6.27.
 > > 
 > > Alexander, have you had a chance to test this? Preferably together
 > > with Tejun's hardreset improvement patch posted recently.
 > > <http://marc.info/?l=linux-ide&m=122724338905689&w=2>
 > > 
 > > With both this and Tejun's hardreset patch applied my Promise test
 > > machine survives several suspend/resume cycles without problems.
 > 
 > Did not work here. I applied both patches to 2.6.27.6, seems to behave exactly as before.
 > dmesg attached.

Are you absolutely certain both patches were applied and the driver rebuilt?
I'm asking because I would have expected to see

[...] sata_promise 0000:00:0d.0: restoring config space at offset 0x1 (...)

but your kernel log does not contain anything like that. Both machines
I tested on today consistently included this message after the patch was
applied, but did not when the patch wasn't applied.

I did note some temporary errors (that sata_promise recovered from) on
one machine after resuming from suspend to ram that did not occur when
using standby. I'll update the patch to include a controller reinit in
the ->resume op, which should hopefully fix that.

On some possibly unrelated notes, I see that:
a) all your interrupts seem to be legacy IRQs < 16, aren't you
   enabling the I/O-APIC?
b) your kernel includes the nvidia binary-only driver, which puts
   a big unknown into the picture

/Mikael
