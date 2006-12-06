From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Wed, 06 Dec 2006 04:13:41 -0500
Message-ID: <457689C5.5030201@garzik.org>
References: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53456 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760350AbWLFJNo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Dec 2006 04:13:44 -0500
In-Reply-To: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Sun, 03 Dec 2006 22:00:42 +0900, Tejun Heo wrote:
>> Mikael Pettersson wrote:
>>> +}
>>> +
>>> +static void pdc_error_handler(struct ata_port *ap)
>>> +{
>>> +	struct ata_eh_context *ehc = &ap->eh_context;
>>> +	ata_reset_fn_t hardreset;
>>> +
>>> +	/* stop DMA, mask IRQ, don't clobber anything else */
>>> +	ata_eh_freeze_port(ap);
>> Don't freeze port unconditionally.  You'll end up hardresetting on every
>> error.  Just make sure DMA engine is stopped and the controller is in a
>> sane state.  If that fails, then, the port should be frozen.
> 
> I'm looking into this now, but so far it seems only a reset
> (what Promise calls software reset, I don't know if libata
> considers it a soft or hard reset) of the ATA channel will do.
> 
>>> +	hardreset = NULL;
>>> +	if (sata_scr_valid(ap)) {
>>> +		ehc->i.action |= ATA_EH_HARDRESET;
>> Why always force HARDRESET?
> 
> I based that on sata_sil24:
> 
> 	if (sil24_init_port(ap)) {
> 		ata_eh_freeze_port(ap);
> 		ehc->i.action |= ATA_EH_HARDRESET;
> 	}
> 
> I interpreted the ATA_EH_HARDRESET as being required due to
> the ata_eh_freeze_port(), but perhaps it's only there because
> sil24_init_port() returned failure?
> 
> A different issue, but of practical importance, is which
> libata branch I should base the EH conversion on: #upstream
> or #ALL? Andrew Morton's -mm kernels include the ALL patches,
> but they in turn include the promise-sata-pata patches, and
> there is a conflict between the PATA patch and the EH conversion.
> Currently my EH conversion is based on #upstream, and I've ported
> the PATA patch to apply on top of it.

It's a tiered system ;-)

* if at all possible, provide patches against the latest linux-2.6.git

* if there are dependencies in #upstream-fixes or #upstream (i.e. I 
already applied some of your patches), provide patches against 
#upstream-fixes or #upstream

#ALL is a branch that is blown away at will, and is really more of a 
testing and akpm sync point.  Don't worry about conflicts with 
promise-sata-pata, I take care of those when I merge the #ALL branch 
together.

	Jeff



