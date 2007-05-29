From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: implement ata_wait_after_reset()
Date: Mon, 28 May 2007 21:31:35 -0400
Message-ID: <465B8277.9010001@garzik.org>
References: <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com> <20070510072005.GA27316@linux-sh.org> <464301D3.5060306@gmail.com> <20070510124645.GA18534@linux-sh.org> <4643196B.7070806@gmail.com> <20070511005217.GA23186@linux-sh.org> <464439C8.7090309@gmail.com> <20070512034928.GB29259@linux-sh.org> <20070516003002.GA18863@linux-sh.org> <464B3505.20004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49545 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbXE2Bbm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 21:31:42 -0400
In-Reply-To: <464B3505.20004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, garyhade@us.ibm.com

Tejun Heo wrote:
> -	msleep(150);
> +	/* wait a while before checking status */
> +	ata_wait_after_reset(ap, deadline);
[...]
> -	msleep(150);
> +	/* wait a while before checking status */
> +	ata_wait_after_reset(ap, deadline);
>  
>  	/* Before we perform post reset processing we want to see if
>  	 * the bus shows 0xFF because the odd clown forgets the D7
> @@ -3543,8 +3583,8 @@ int sata_std_hardreset(struct ata_port *
>  		return 0;
>  	}
>  
> -	/* wait a while before checking status, see SRST for more info */
> -	msleep(150);
> +	/* wait a while before checking status */
> +	ata_wait_after_reset(ap, deadline);
>  
>  	rc = ata_wait_ready(ap, deadline);
[...]
> -	msleep(150);
> +	/* wait a while before checking status */
> +	ata_wait_after_reset(ap, deadline);
>  
>  	/* Before we perform post reset processing we want to see if
>  	 * the bus shows 0xFF because the odd clown forgets the D7
> Index: work/drivers/ata/sata_inic162x.c
> ===================================================================
> --- work.orig/drivers/ata/sata_inic162x.c
> +++ work/drivers/ata/sata_inic162x.c
> @@ -446,7 +446,7 @@ static int inic_hardreset(struct ata_por
>  		struct ata_taskfile tf;
>  
>  		/* wait a while before checking status */
> -		msleep(150);
> +		ata_wait_after_reset(ap, deadline);
>  
>  		rc = ata_wait_ready(ap, deadline);
[...]

The main thing that bothers me is not the increase in delay, but the 
fact that this create converts a delay/Status-poll sequence into a 
delay/Status-poll/Status-poll sequence.

ata_wait_after_reset() immediately before ata_wait_ready() seems highly 
redundant.  Why not just poll Status once?

	Jeff



