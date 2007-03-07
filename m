From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [RFT] sata_promise: decode and report error reasons
Date: Wed, 7 Mar 2007 20:53:45 +0100
Message-ID: <17903.6217.992304.800959@alkaid.it.uu.se>
References: <200703010158.l211wXPS012467@harpo.it.uu.se>
	<45EB9DF4.20402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:33558 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992535AbXCGTxz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 14:53:55 -0500
In-Reply-To: <45EB9DF4.20402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun,

Tejun Heo writes:
 > Hello, Mikael.
 > 
 > Mikael Pettersson wrote:
 > > +static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc, u32 port_status)
 > > +{
 > > +	struct pdc_host_priv *hp = ap->host->private_data;
 > > +	struct ata_eh_info *ehi = &ap->eh_info;
 > > +	unsigned int err_mask = 0, action = 0;
 > > +	u32 serror;
 > > +
 > > +	ata_ehi_clear_desc(ehi);
 > > +
 > > +	serror = 0;
 > > +	if (sata_scr_valid(ap)) {
 > > +		serror = pdc_sata_scr_read(ap, SCR_ERROR);
 > > +		if (!(hp->flags & PDC_FLAG_GEN_II))
 > > +			serror &= ~PDC2_SERR_MASK;
 > > +	}
 > > +
 > > +	printk("%s: port_status 0x%08x serror 0x%08x\n", __FUNCTION__, port_status, serror);
 > > +
 > > +	ata_ehi_push_desc(ehi, "port_status 0x%08x", port_status);
 > > +
 > > +	if (serror & PDC_SERR_MASK) {
 > > +		err_mask |= AC_ERR_ATA_BUS;
 > 
 > 1. It might be that decoding PDC specific bits is unnecessary if it sets
 > the standard bits correctly.  Also, SError bits above bit16 are
 > diagnostic bits and don't necessarily indicate error condition.

Which SErrror bits are standard?
It is true that some of the SError bits are diagnostic rather than
actual error indicators, as Promise's driver only checks a subset
of them. I'll fix that.

 > 2. PDC_SERR_FIS_TYPE is more close to AC_ERR_HSM.

FIS_TYPE is described as reception of a FIS with a good CRC but
unrecognised type field. I can make it AC_ERR_HSM if that's more
appropriate.

 > > +		ata_ehi_push_desc(ehi, ", serror 0x%08x", serror);
 > > +	}
 > > +	if (port_status & PDC_DRIVE_ERR)
 > > +		err_mask |= AC_ERR_DEV;
 > > +	if (port_status & PDC2_HTO_ERR)
 > > +		err_mask |= AC_ERR_TIMEOUT;
 > 
 > What does HTO mean?  Host time out?  Until now, AC_ERR_TIMEOUT has been
 > used to indicate that driver side timeout has expired and I'd like to
 > keep it that way.

Yes, HTO is "host bus timeout" which is described as the host bus being
busy more than 256 clock (I guess PCI) cycles for an ATA I/O transfer.

If not AC_ERR_TIMEOUT, then what? AC_ERR_HOST_BUS?

 > > +	if (port_status & (PDC_UNDERRUN_ERR | PDC_OVERRUN_ERR | PDC2_ATA_DMA_CNT_ERR
 > > +			   | PDC2_ATA_HBA_ERR))
 > > +		err_mask |= AC_ERR_ATA_BUS;
 > 
 > AC_ERR_ATA_BUS indicates transmission errors on the ATA bus.  AC_ERR_HSM
 > (host state machine/protocol violation), AC_ERR_HOST_BUS (host/PCI BUS
 > error) or AC_ERR_SYSTEM (other system errors) seems more appropriate for
 > the above error conditions.

UNDERRUN and OVERRUN occur when DMA S/G byte count differs from what the
device accepts or delivers as checked when the device asserts INTRQ.
I can make them AC_ERR_HSM instead. (HOST_BUS or SYSTEM seem inappropriate.)

ATA_HBA_ERR is any FIS transmission error on SATA interface. AC_ERR_ATA_BUS
seems appropriate for that one.

ATA_DMA_CNT_ERR is when a DMA FIS data size differs from total DMA S/G size.
I think AC_ERR_ATA_BUS is the correct choice for this one too.

I will add more explanatory text to the error bit definitions, and
perhaps also a table-driven error logger (a bit like sata_sil24).

Thanks for the review.

/Mikael
