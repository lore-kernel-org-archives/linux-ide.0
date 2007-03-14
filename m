From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH libata#upstream] sata_promise: decode and report error reasons
Date: Wed, 14 Mar 2007 10:30:37 +0100 (MET)
Message-ID: <200703140930.l2E9Ub4c006713@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:63720 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030816AbXCNJat (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 05:30:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

On Wed, 14 Mar 2007 05:06:11 -0400, Jeff Garzik wrote:
> > -	tmp = readl(mmio);
> > -	if (tmp & PDC_ERR_MASK) {
> > -		qc->err_mask |= AC_ERR_DEV;
> > -		pdc_reset_port(ap);
> 
> AFAICS pdc_reset_port() will no longer be called, after this change.
> 
> Since you are freezing the port with ata_port_freeze() before 
> pdc_error_handler() is called, the one remaining call to 
> pdc_reset_port() never occurs:
> 
>          if (!(ap->pflags & ATA_PFLAG_FROZEN))
>                  pdc_reset_port(ap);
> 
> And Promise hardware definitely needs to be "kicked" by pdc_reset_port() 
> after most errors.

There's also a conditional pdc_reset_port() in pdc_post_internal_cmd().

I'll reinvestigate the reset logic.

> Also, PCI error are controller-wide, so ideally you should presume that 
> all transactions on all ports are bad, and reset everything.  See 
> mv_pci_error() in sata_mv.c in libata-dev.git#mv-eh for mostly-generic 
> code that initiates error handling on all ports, rather than just one.

Agreed.

Thanks,

/Mikael
