From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/6] libata: add xfer_mask handling functions
Date: Tue, 07 Mar 2006 13:51:05 +0800
Message-ID: <440D1F49.5040508@tw.ibm.com>
References: <11415871161635-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:55494 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750861AbWCGFvP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Mar 2006 00:51:15 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k275p9AO016599
	for <linux-ide@vger.kernel.org>; Tue, 7 Mar 2006 00:51:09 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k275mSTY261944
	for <linux-ide@vger.kernel.org>; Mon, 6 Mar 2006 22:48:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k275p8TD005144
	for <linux-ide@vger.kernel.org>; Mon, 6 Mar 2006 22:51:09 -0700
In-Reply-To: <11415871161635-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add ata_pack_xfermask(), ata_xfer_mask2mode(), ata_xfer_mode2mask(),
> ata_xfer_mode2shift() and ata_id_xfermask().  These functions will be
> used by following patches to simplify xfer_mask handling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  (snip)
> +/**
> + *	ata_id_xfermask - Compute xfermask from the given IDENTIFY data
> + *	@id: IDENTIFY data to compute xfer mask from
> + *
> + *	Compute the xfermask for this device. This is not as trivial
> + *	as it seems if we must consider early devices correctly.
> + *
> + *	FIXME: pre IDE drive timing (do we care ?).
> + *
> + *	LOCKING:
> + *	None.
> + *
> + *	RETURNS:
> + *	Computed xfermask
> + */
> +static unsigned int ata_id_xfermask(const u16 *id)
> +{
> +	unsigned int pio_mask, mwdma_mask, udma_mask;
> +
> +	/* Usual case. Word 53 indicates word 64 is valid */
> +	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
> +		pio_mask = id[ATA_ID_PIO_MODES] & 0x03;
> +		pio_mask <<= 3;
> +		pio_mask |= 0x7;
> +	} else {
> +		/* If word 64 isn't valid then Word 51 high byte holds
> +		 * the PIO timing number for the maximum. Turn it into
> +		 * a mask.
> +		 */
> +		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
> +
> +		/* But wait.. there's more. Design your standards by
> +		 * committee and you too can get a free iordy field to
> +		 * process. However its the speeds not the modes that
> +		 * are supported... Note drivers using the timing API
> +		 * will get this right anyway
> +		 */
> +	}
> +
> +	mwdma_mask = id[ATA_ID_MWDMA_MODES] & 0x07;
> +	udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
> +
> +	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
> +}
> +
>  /*

We have ap->pio_mask, ap->mwdma_mask and ap->udma_mask.
Just thinking what if we have these masks in ata_device? 
Maybe we can save some bitwise operations and make the code more intuitive to read?

Ex. ata_id_xfermask() can store the calculated masks to dev->pio_mask, dev->mwdma_mask, etc.
Ex. ata_mode_string() can take mode (XFER_UDMA_7..) as parameter and translate the given mode to string.
    
Ex. to print out the max mode support by the device, 
    1. ata_id_xfermask() calculates and saves the masks to dev->pio_mask, etc.
    2. Another function, say, ata_dev_max_mode() takes dev as parameter,
       packs the mode by ata_pack_xfermask() internally,
       find the max mode supported by the drive,
       then use ata_xfer_mask2mode() to return the mode.
    3. ata_mode_string() translates the mode, say XFER_UDMA_7, to string literal.

Albert


