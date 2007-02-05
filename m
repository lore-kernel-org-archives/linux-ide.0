From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh: Add a simple mechanism for silencing error
 reporting
Date: Tue, 06 Feb 2007 02:29:16 +0900
Message-ID: <45C7696C.1050406@gmail.com>
References: <20070205161124.48bf16c6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:13114 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbXBER3Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 12:29:25 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1665346nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 09:29:25 -0800 (PST)
In-Reply-To: <20070205161124.48bf16c6@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

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
> @@ -1446,6 +1448,8 @@
>  
>  		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
>  			continue;
> +		if (qc->tf.flags & ATA_TFLAG_QUIET)
> +			continue;
>  
>  		ata_dev_printk(qc->dev, KERN_ERR,
>  			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "

I think the result can be a bit confusing if ehc->i.err_mask is set
(port/dev exception message without failed command report).  How about
counting nr_quiet and doing if (nr_failed == nr_quiet) return right
after the counting block?

-- 
tejun
