From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Tue, 25 Nov 2008 22:17:14 +0100
Message-ID: <18732.27482.857421.676802@harpo.it.uu.se>
References: <491C9A4F.1020801@tlinx.org>
	<491FB7E2.2030105@kernel.org>
	<18719.65298.689618.835202@harpo.it.uu.se>
	<492059B1.4030708@how.dk>
	<49205AD7.3080009@how.dk>
	<4920D093.2030508@kernel.org>
	<492159E0.1050804@how.dk>
	<4922165E.9070203@kernel.org>
	<49230361.2010001@how.dk>
	<492371F4.7020400@kernel.org>
	<49253A6D.1040202@how.dk>
	<18725.17831.755158.999770@harpo.it.uu.se>
	<49263F80.2060607@kernel.org>
	<492C358C.7030403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38572 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbYKYVRd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 16:17:33 -0500
In-Reply-To: <492C358C.7030403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, Mikael Pettersson <mikpe@it.uu.se>, Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > hrm....   at this point we have deviated massively from the standard 
 > Promise method of hard reset...
 > 
 > * set PMP port
 > * make hotplug irqs
 > * reset port# in PDC_GLOBAL_CTL
 > * pdc_reset_port()
 > * reset FPDMA -- probably a good idea even if not doing FPDMA
 > * clear SATA Error register (0xffffffff)
 > * clear errors-reported-from-link-layer register
 > * wait standard length of time for SATA connection
 > * clear hotplug bits
 > * set PMP port
 > 
 > The PDC_GLOBAL_CTL bitbang is the most notable missing element in the 
 > hard reset path, though we also miss clearing an apparently-important 
 > error register as well.  FPDMA reset would be a good idea I think, even 
 > if not in use, mainly for paranoia's sake and because that's what 
 > Promise's driver does.

->freeze() masks hotplug irqs, though it seems the events are still
logged and wrongly interpreted by the irq handler.

The other Promise bits should be easy to do, though FPDMA reset
will need special-casing for 1st-vs-2nd generation and maybe also
sata-vs-pata.

I'll look into it.

/Mikael
