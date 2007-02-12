From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_vsc with iq3124h regression in 2.6.20
Date: Sun, 11 Feb 2007 19:19:32 -0800
Message-ID: <45CFDCC4.6050400@gmail.com>
References: <1171063609.29541.6.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:6304 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933044AbXBLGpQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 01:45:16 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1553187wri
        for <linux-ide@vger.kernel.org>; Sun, 11 Feb 2007 22:45:15 -0800 (PST)
In-Reply-To: <1171063609.29541.6.camel@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com, liml@rtr.ca

Dan Williams wrote:
> The error interrupt handling code is still in there and is working.  The
> following patch works for me.
> 
> ---
> sata_vsc: handle unexpected interrupts when executing a polled IDENTIFY
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/ata/sata_vsc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
> index 0fa1b89..7425d62 100644
> --- a/drivers/ata/sata_vsc.c
> +++ b/drivers/ata/sata_vsc.c
> @@ -258,7 +258,9 @@ static irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance)
>  					/* Clear interrupt status */
>  					ata_chk_status(ap);
>  					handled++;
> -				}
> +				} else if (qc->tf.command == ATA_CMD_ID_ATA)
> +					/* 31244 interrupts on polled IDENTIFY commands */
> +					ata_chk_status(ap);
>  			}
>  		}
>  	}

I see.  Can you please...

1. move per-port interrupt handling code (everything inside the for 
loop) to a separate function

2. make the if/else control block look like the following?

   if (unlikely(no irq))
	return 0;
   if (intr command in progress)
	return ata_host_intr()
   if (error_intr())
	error intr handling sans irq clearing.

   clear IRQ
   return 1;

3. Post the patch (probably two patches, one to separate out 
vsc_port_intr() and another to fix the problem) with proper subject lines.

Thanks.

-- 
tejun

