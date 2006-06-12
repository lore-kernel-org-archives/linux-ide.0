From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE
	command(v5)
Date: Mon, 12 Jun 2006 12:23:24 +0800
Message-ID: <1150086204.5721.37.camel@forrest26.sh.intel.com>
References: <1150084894.5721.32.camel@forrest26.sh.intel.com>
	 <448CEB2D.3060102@garzik.org>  <448CEBCE.9080206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18106 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750783AbWFLEf3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 00:35:29 -0400
In-Reply-To: <448CEBCE.9080206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Mon, 2006-06-12 at 00:21 -0400, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > zhao, forrest wrote:
> >> This patch makes libata "Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE
> >> command" and clean the things up(e.g. revalidate and rescan).
> >>
> >> Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
> > 
> > applied
> 
> Um... please make sure all your patches build!
> 
> I had to apply the attached patch to get it to work.
> 
> 	Jeff
> 
> 
> 
> Plain text document attachment (patch)
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 39e6b77..61eea57 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -522,6 +522,7 @@ struct ata_port {
>  
>  	struct work_struct	port_task;
>  	struct work_struct	hotplug_task;
> +	struct work_struct	scsi_rescan_task;
>  
>  	unsigned int		hsm_task_state;

Oh, sorry for that. I had tested the patch before sending it out. 
But don't know why this line is missing. Do I need to re-send the whole
patch?

BTW. the disk of my develop machine for SATA was corrupted 10 minutes
ago after I applied the AHCI suspend/resume patch against #upstream, I
had to recover it painfully. Haven't expected that it can cause such bad
damage :(

Forrest
