From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Cable detection fixes
Date: Fri, 02 Mar 2007 17:48:16 -0500
Message-ID: <45E8A9B0.2070205@garzik.org>
References: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54329 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992669AbXCBWsS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 17:48:18 -0500
In-Reply-To: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Alan wrote:
> 2.6.21-rc has horrible problems with libata and PATA cable types (and
> thus speeds). This occurs because Tejun fixed a pile of other bugs and
> we now do cable detect enforcement for drive side detection properly.
> 
> Unfortunately we don't do the process around cable detection right. Tejun
> identified the problem and pointed to the right Annex in the spec, this patch
> implements the needed changes.
> 
> The basic requirement is that we have to identify the slave before the
> master.
> 
> The patch switches the identify order so that we can do the drive side
> detection correctly. 

> @@ -1850,8 +1900,11 @@
>  	for (i = 0; i < ATA_MAX_DEVICES; i++)
>  		ap->device[i].pio_mode = XFER_PIO_0;
>  
> -	/* read IDENTIFY page and configure devices */
> -	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +	/* read IDENTIFY page and configure devices. We have to do the identify
> +	   specific sequence bass-ackwards so that PDIAG- is released by
> +	   the slave device */
> +
> +	for (i = ATA_MAX_DEVICES - 1; i >=  0; i--) {
>  		dev = &ap->device[i];
>  
>  		if (tries[i])
> @@ -1864,6 +1917,19 @@
>  				     dev->id);
>  		if (rc)
>  			goto fail;
> +	}
> +
> +	/* After the identify sequence we can now set up the devices. We do
> +	   this in the normal order so that the user doesn't get confused */
> +
> +	for(i = 0; i < ATA_MAX_DEVICES; i++) {
> +		dev = &ap->device[i];
> +		if (!ata_dev_enabled(dev))
> +			continue;
>  
>  		ap->eh_context.i.flags |= ATA_EHI_PRINTINFO;
>  		rc = ata_dev_configure(dev);

applied this part

