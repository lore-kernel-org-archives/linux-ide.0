From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] sata_promise: decode and report error reasons
Date: Wed, 07 Mar 2007 17:45:57 -0500
Message-ID: <45EF40A5.70208@garzik.org>
References: <200703010158.l211wXPS012467@harpo.it.uu.se>	<45EB9DF4.20402@gmail.com> <17903.6217.992304.800959@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41445 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992701AbXCGWqC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 17:46:02 -0500
In-Reply-To: <17903.6217.992304.800959@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
>  > 2. PDC_SERR_FIS_TYPE is more close to AC_ERR_HSM.
> 
> FIS_TYPE is described as reception of a FIS with a good CRC but
> unrecognised type field. I can make it AC_ERR_HSM if that's more
> appropriate.

AC_ERR_HSM is how other drivers currently handle "unknown FIS received" 
condition.

AC_ERR_HSM is generally used for any sort of protocol violation. 
Successful reception of an unexpected FIS would be a reasonable 
candidate for that, though perhaps for SATA it's easiest to just note 
and ignore unknown FIS's.


>  > > +		ata_ehi_push_desc(ehi, ", serror 0x%08x", serror);
>  > > +	}
>  > > +	if (port_status & PDC_DRIVE_ERR)
>  > > +		err_mask |= AC_ERR_DEV;
>  > > +	if (port_status & PDC2_HTO_ERR)
>  > > +		err_mask |= AC_ERR_TIMEOUT;
>  > 
>  > What does HTO mean?  Host time out?  Until now, AC_ERR_TIMEOUT has been
>  > used to indicate that driver side timeout has expired and I'd like to
>  > keep it that way.
> 
> Yes, HTO is "host bus timeout" which is described as the host bus being
> busy more than 256 clock (I guess PCI) cycles for an ATA I/O transfer.
> 
> If not AC_ERR_TIMEOUT, then what? AC_ERR_HOST_BUS?

AC_ERR_HOST_BUS sounds applicable, yes.


>  > > +	if (port_status & (PDC_UNDERRUN_ERR | PDC_OVERRUN_ERR | PDC2_ATA_DMA_CNT_ERR
>  > > +			   | PDC2_ATA_HBA_ERR))
>  > > +		err_mask |= AC_ERR_ATA_BUS;
>  > 
>  > AC_ERR_ATA_BUS indicates transmission errors on the ATA bus.  AC_ERR_HSM
>  > (host state machine/protocol violation), AC_ERR_HOST_BUS (host/PCI BUS
>  > error) or AC_ERR_SYSTEM (other system errors) seems more appropriate for
>  > the above error conditions.
> 
> UNDERRUN and OVERRUN occur when DMA S/G byte count differs from what the
> device accepts or delivers as checked when the device asserts INTRQ.
> I can make them AC_ERR_HSM instead. (HOST_BUS or SYSTEM seem inappropriate.)

Overrun/underrun are typically programmer errors, something you should 
never see in the field is the driver is working properly.  AC_ERR_HSM is 
probably the closest mapping to such a condition, though perhaps 
AC_ERR_DRIVER_BUG would be more clear :)


> ATA_HBA_ERR is any FIS transmission error on SATA interface. AC_ERR_ATA_BUS
> seems appropriate for that one.

Yep.


> ATA_DMA_CNT_ERR is when a DMA FIS data size differs from total DMA S/G size.
> I think AC_ERR_ATA_BUS is the correct choice for this one too.

Where is this in the Promise docs, so that I can take a closer look?

This condition sounds like overrun/underrun, something that would not 
occur outside of a driver bug?


> I will add more explanatory text to the error bit definitions, and
> perhaps also a table-driven error logger (a bit like sata_sil24).

SiI 3124 makes it a bit easier, by actually returning error codes 
(rather than bits scattered about, like all other hardware).  But yes, 
that's a reasonable approach if it makes the code more clean.

	Jeff


