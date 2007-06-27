From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] libata: fix infinite EH waiting bug
Date: Wed, 27 Jun 2007 02:45:53 -0400
Message-ID: <468207A1.6000301@garzik.org>
References: <467FB94F.1040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38006 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758575AbXF0Gpz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:55 -0400
In-Reply-To: <467FB94F.1040000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> When EH gives up after repeated exceptions, it doesn't't clear the
> PENDING bit on exit which leaves PENDING bit set without EH actually
> scheduled.  This makes ata_port_wait_eh() to wait forever makes rmmod
> hang on such port.  Fix it by clearing the flag.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index d807098..fbdfefb 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -336,6 +336,7 @@ void ata_scsi_error(struct Scsi_Host *host)
>  			}
>  			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
>  					"tries, giving up\n", ATA_EH_MAX_REPEAT);
> +			ap->pflags &= ~ATA_PFLAG_EH_PENDING;
>  		}
>  

applied


