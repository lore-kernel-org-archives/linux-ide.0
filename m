From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: clear ering on resume
Date: Mon, 11 May 2009 14:34:39 -0400
Message-ID: <4A086FBF.7020901@garzik.org>
References: <49EFBC80.6070109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36785 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757427AbZEKSem (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 14:34:42 -0400
In-Reply-To: <49EFBC80.6070109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, vbotka@novell.com

Tejun Heo wrote:
> Error timestamps are in jiffies which doesn't run while suspended and
> PHY events during resume isn't too uncommon.  When the two are
> combined, it can lead to unnecessary speed downs if the machine is
> suspended and resumed repeatedly.  Clear error history on resume.
> 
> This was reported and verified in bnc#486803 by Vladimir Botka.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Vladimir Botka <vbotka@novell.com>
> ---
>  drivers/ata/libata-eh.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 0183131..ff0f496 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3494,6 +3494,8 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
>   */
>  static void ata_eh_handle_port_resume(struct ata_port *ap)
>  {
> +	struct ata_link *link;
> +	struct ata_device *dev;
>  	unsigned long flags;
>  	int rc = 0;
>  
> @@ -3508,6 +3510,17 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
>  
>  	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
>  
> +	/*
> +	 * Error timestamps are in jiffies which doesn't run while
> +	 * suspended and PHY events during resume isn't too uncommon.
> +	 * When the two are combined, it can lead to unnecessary speed
> +	 * downs if the machine is suspended and resumed repeatedly.
> +	 * Clear error history.
> +	 */
> +	ata_for_each_link(link, ap, HOST_FIRST)
> +		ata_for_each_dev(dev, link, ALL)
> +			ata_ering_clear(&dev->ering);
> +
>  	ata_acpi_set_state(ap, PMSG_ON);

applied


