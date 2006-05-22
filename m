From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: use polling pio for identify device
Date: Mon, 22 May 2006 02:24:07 -0400
Message-ID: <44715907.7060602@pobox.com>
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <446C5957.9040404@tw.ibm.com> <446C5B83.9000305@gmail.com> <446D9FCD.5050907@tw.ibm.com> <446DA604.8040207@gmail.com> <4471354C.5090201@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60806 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932496AbWEVGYQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 02:24:16 -0400
In-Reply-To: <4471354C.5090201@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Use polling pio for identify device.
> This can save some time to detect the phantom device 1 during boot.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> For the phantom slave device (found with some IBM DVD-RAM drive and
> Intel ICHx chip), irq-pio has to wait 30 seconds timeout to detect them.
> 
> Use polling pio can detect the phantom slave quicker. (Verified ok by Tejun.)
> 
> Patch again the current upstream branch (b74ba22f030eb7ab88f7d8954ad18ecc0ac5ce3c).
> For your review, thanks.
> 
> --- upstream/drivers/scsi/libata-core.c	2006-05-22 10:04:12.000000000 +0800
> +++ polling_identify/drivers/scsi/libata-core.c	2006-05-22 11:07:02.000000000 +0800
> @@ -1196,6 +1196,8 @@ static int ata_dev_read_id(struct ata_de
>  	}
>  
>  	tf.protocol = ATA_PROT_PIO;
> +	/* Use polling for early detection of phantom dev 1 */
> +	tf.flags |= ATA_TFLAG_POLLING;

Sorry I didn't jump into the thread earlier.  I'm trying out this new 
no-work-on-weekends thing, which is a change from my usual 
working-7-days-a-week thing.  :)

NAK.  The above change is going backwards from the direction we took by 
merging irq-pio, and it reintroduces problems that irq-pio solved. 
Additionally, for irq problems unrelated to libata (we will continue to 
see such problems FOREVER), this simply shifts the I-notice-a-problem 
moment from IDENTIFY DEVICE to SET FEATURES, or perhaps the first READ 
or WRITE.

SATA is inherently event driven (read: irq-driven), and PATA has 
traditionally been irq-driven in the Linux drivers/ide code.  Using 
polling for solving this specific problem just isn't enough 
justification.  We should be able to fix this elsewhere.  Take a look at 
the drivers/ide "bang at the door w/ IDENTIFY" probing method.  We took 
a different approach (device signature, etc.) but its still a useful 
working case to examine.

As an aside, phantom devices make me think that somewhere we might be 
getting device-select wrong, or accidentally skipping it entirely.

	Jeff



