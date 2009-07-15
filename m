From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix follow-up SRST failure path
Date: Tue, 14 Jul 2009 22:43:39 -0400
Message-ID: <4A5D425B.5030201@garzik.org>
References: <4A540F95.70604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46569 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbZGOCpV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Jul 2009 22:45:21 -0400
In-Reply-To: <4A540F95.70604@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Tejun Heo wrote:
> ata_eh_reset() was missing error return handling after follow-up SRST
> allowing EH to continue the normal probing path after reset failure.
> This was discovered while testing new WD 2TB drives which take longer
> than 10 secs to spin up and cause the first follow-up SRST to time
> out.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-eh.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 94919ad..d37808b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2517,6 +2517,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  
>  			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
>  			rc = ata_do_reset(link, reset, classes, deadline, true);
> +			if (rc) {
> +				failed_link = link;
> +				goto fail;
> +			}
>  		}

applied


