From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 4.1-rc6: ATA link is slow to respond, please be patient
Date: Mon, 10 Aug 2015 11:37:07 +1000
Message-ID: <1439170627.20774.5.camel@ellerman.id.au>
References: <alpine.DEB.2.20.8.1508070306080.12626@trent.utfs.org>
	 <alpine.DEB.2.20.8.1508082049490.12626@trent.utfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:45365 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbbHJBhJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2015 21:37:09 -0400
In-Reply-To: <alpine.DEB.2.20.8.1508082049490.12626@trent.utfs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Kujau <lists@nerdbynature.de>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2015-08-08 at 21:17 -0700, Christian Kujau wrote:
> [Adding linux-ide@vger.kernel.org]
> 
> On Fri, 7 Aug 2015, Christian Kujau wrote:
> > this PowerBook G4 was running 3.16 for a while but now I wanted to upgrade 
> > to latest mainline. However, during bootup the following happens:
> > 
> > ===============================
> > [    2.237102] ata1: PATA max UDMA/100 irq 39
> > [    2.401708] ata1.00: ATA-8: SAMSUNG HM061GC, LR100-10, max UDMA/100
> > [    2.401764] ata1.00: 117231408 sectors, multi 16: LBA48 
> > [    2.417633] ata1.00: configured for UDMA/100
> > [   44.918102] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> > [   44.920452] ata1.00: failed command: READ DMA
> > [   44.922725] ata1.00: cmd c8/00:88:64:c2:12/00:00:00:00:00/e0 tag 0 dma 69632 in
> > [   44.927257] ata1.00: status: { DRDY }
> > [   49.971784] ata1.00: qc timeout (cmd 0xec)
> > [   49.976529] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> > [   49.978908] ata1.00: revalidation failed (errno=-5)
> > [   55.019662] ata1: link is slow to respond, please be patient (ready=0)
> > [   60.007677] ata1: device not ready (errno=-16), forcing hardreset
> > [   60.012670] ata1: soft resetting link
> > [   60.193638] ata1.00: configured for UDMA/100
> > [   60.196158] ata1.00: device reported invalid CHS sector 0
> > [   60.198610] ata1: EH complete
> > ===============================
> > 
> > This happens only once, but systemd thinks there's a hard problem and will 
> > drop to a recovery shell. I can start sshd and login remotely and then the 
> > system appears to be running just fine.
> > 
> > This happened in 4.2.0-rc5 so I went back a few versions and found that
> > 4.1-rc5 was OK (the error does not show up and the system boots just fine)
> > and 4.1-rc6 is not.
> > 
> 
> After more digging around I noticed that the same error (with 
> changed wording) happens with a Debian 3.16.0-4-powerpc kernel - so it
> doesn't appear to be a recent regression as I suspected at first:
> 
> ==================================
> [   46.907147] ata1: drained 572 bytes to clear DRQ
> [   46.907166] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   46.908419] ata1.00: failed command: READ DMA
> [   46.909058] ata1.00: cmd c8/00:80:9c:f9:60/00:00:00:00:00/e0 tag 0 dma 65536 in
>          res 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x20 (host bus error)
> [   46.910303] ata1.00: status: { DRDY }
> [   46.970579] ata1.00: configured for UDMA/100
> [   46.971853] ata1.00: device reported invalid CHS sector 0
> [   46.972524] ata1: EH complete
> ==================================
> 
> Also, the error cannot repduced as reliably as I thought: sometimes, the 
> machine just boots w/o a hitch - and that might be the reasons why my 
> bisect attempts failed and incorrectly blamed totally unrelated commits: 
> after each "git bisect {good,bad}" (+compiling) I rebooted but there was a 
> chance that the system came up just fine / showed the same ATA error and 
> thus falsified the git-bisect results.

Yes that would explain why the bisect went wrong. If you have an intermittent
bug like that you have to be very careful about which commits you mark good or
bad.

I don't really know anything about disk drivers, so hopefully someone who does
can chime in.

cheers


