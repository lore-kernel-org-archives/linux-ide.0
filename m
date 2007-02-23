From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-eh: Add a simple mechanism for silencing error
 reporting
Date: Fri, 23 Feb 2007 05:27:05 -0500
Message-ID: <45DEC179.1080308@garzik.org>
References: <20070205161124.48bf16c6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44839 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbXBWK1I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:27:08 -0500
In-Reply-To: <20070205161124.48bf16c6@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Alan wrote:
> We want to be able to issue commands that fail silently some of the time
> (set_features/xfer rate to CF 1.4 devices, perhaps some others such as
> user SG_IO commands ought to be silent too as the error is for the app)
> 
> This is a minimal implementation, we can extend it so the QUIET flag
> isn't quiet about errors that are not command errors but indicate
> infrastructre problems (CRC errors, HSM violation, DeviceFault) if need
> be.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-eh.c linux-2.6.20-rc6-mm3/drivers/ata/libata-eh.c
> --- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-eh.c	2007-01-31 14:20:39.000000000 +0000
> +++ linux-2.6.20-rc6-mm3/drivers/ata/libata-eh.c	2007-01-31 14:27:25.000000000 +0000
> @@ -1407,6 +1407,8 @@
>  			continue;
>  		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
>  			continue;
> +		if (qc->tf.flags & ATA_TFLAG_QUIET)
> +			continue;
>  
>  		nr_failed++;
>  	}

I would rather pass an ok-to-fail-without-recovery type flag to EH. 
This TFLAG_QUIET approach is poorly defined, probably temporary, and not 
really interesting for upstream

	Jeff



