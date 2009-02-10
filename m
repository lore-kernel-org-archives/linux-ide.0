From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Mon, 09 Feb 2009 23:30:29 -0500
Message-ID: <499102E5.6000603@garzik.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk>	<18725.17831.755158.999770@harpo.it.uu.se>	<49263F80.2060607@kernel.org>	<492C358C.7030403@garzik.org> <18737.47407.218634.726384@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42120 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbZBJEak (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 23:30:40 -0500
In-Reply-To: <18737.47407.218634.726384@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Tejun Heo <tj@kernel.org>, Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Jeff Garzik writes:
>  > hrm....   at this point we have deviated massively from the standard 
>  > Promise method of hard reset...
>  > 
>  > * set PMP port
>  > * make hotplug irqs
>  > * reset port# in PDC_GLOBAL_CTL
>  > * pdc_reset_port()
>  > * reset FPDMA -- probably a good idea even if not doing FPDMA
>  > * clear SATA Error register (0xffffffff)
>  > * clear errors-reported-from-link-layer register
>  > * wait standard length of time for SATA connection
>  > * clear hotplug bits
>  > * set PMP port
>  > 
>  > The PDC_GLOBAL_CTL bitbang is the most notable missing element in the 
> 
> I assume you meant the PCI control register (offset 0x48).
> 
>  > hard reset path, though we also miss clearing an apparently-important 
>  > error register as well.  FPDMA reset would be a good idea I think, even 
>  > if not in use, mainly for paranoia's sake and because that's what 
>  > Promise's driver does.
> 
> Here's a patch on top of 2.6.28-rc6 that should make sata_promise's
> reset sequences a closer match to what Promise's drivers do.
> 
> - soft reset (pdc_reset_port):
>   * wait for ATA engine to not be in packet command mode (2nd gen only)
>   * write reset bit in PDC_CTLSTAT before the first read in the loop
>   * for 2nd gen SATA follow up with FPDMA reset and clearing error status registers
> - hard reset (pdc_sata_hardreset):
>   * wait for ATA engine to not be in packet command mode (2nd gen only)
>   * reset ATA engine via the PCI control register
>   * Tejun's change to use non-waiting hardreset + follow-up SRST
> 
> I'm not changing the hotplug mask bits since they are taken care
> of by sata_promise's ->freeze() and ->thaw() operations. And I'm
> not writing the PMP port # because that's always zero (for now).
> 
> Tested here on a SATAII150 TX2plus w/ two sata disks, some hdparm -y
> + smartctl tests which used to cause timeouts on one of those disks,
> and some parallel dd:s to stress things a little. No issues found.
> I'll test it on a 1st gen 20378 next week.
> 
> Testers welcome.

Any updates?


