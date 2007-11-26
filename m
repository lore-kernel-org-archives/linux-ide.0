From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH RFC] sata_promise: make pdc_atapi_pkt() use values from qc->tf
Date: Mon, 26 Nov 2007 13:00:57 +0100 (MET)
Message-ID: <200711261200.lAQC0vFd029485@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:44529 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396AbXKZMBD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Nov 2007 07:01:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org, mikpe@it.uu.se

On Mon, 26 Nov 2007 20:34:38 +0900, Tejun Heo wrote:
> Make pdc_atapi_pkt() use values from qc->tf instead of creating its
> own.  This is to ease future ATAPI handling changes.
> 
> DONT APPLY YET
> ---
> Mikael, would this work?  Values other than lbam and lbah remain the
> same.  Does sata_promise have strict requirements for lbam and lbah?

...

>  	/* set feature and byte counter registers */
> -	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA) {
> +	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA)
>  		feature = PDC_FEATURE_ATAPI_PIO;
> -		/* set byte counter register to real transfer byte count */
> -		nbytes = qc->nbytes;
> -		if (nbytes > 0xffff)
> -			nbytes = 0xffff;
> -	} else {
> +	else
>  		feature = PDC_FEATURE_ATAPI_DMA;
> -		/* set byte counter register to 0 */
> -		nbytes = 0;
> -	}
> +
>  	buf[20] = (1 << 5) | ATA_REG_FEATURE;
>  	buf[21] = feature;
>  	buf[22] = (1 << 5) | ATA_REG_BYTEL;
> -	buf[23] = nbytes & 0xFF;
> +	buf[23] = qc->tf.lbam;
>  	buf[24] = (1 << 5) | ATA_REG_BYTEH;
> -	buf[25] = (nbytes >> 8) & 0xFF;
> +	buf[25] = qc->tf.lbah;

The original code matches what Promise' own driver does, including
the "set byte counter register to real transfer byte count" comment.
It's certainly possible that if lbah/lbam don't match ->nbytes,
the HW will go nuts. Their data sheets are very quiet about ATAPI.

I can test your proposed change next weekend when I'm back to where
my sata_promise test equipment is.

/Mikael
