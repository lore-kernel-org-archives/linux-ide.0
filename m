From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/6] libata: add xfer_mask handling functions
Date: Sat, 11 Mar 2006 19:01:05 -0500
Message-ID: <441364C1.1000007@pobox.com>
References: <11415871161635-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48822 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750759AbWCLABN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 19:01:13 -0500
In-Reply-To: <11415871161635-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
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

Check Word 53 to see if Word 88 is valid.

Otherwise OK.

	Jeff



