From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Fri, 04 Apr 2008 03:40:22 -0400
Message-ID: <47F5DB66.5000002@garzik.org>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40088 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbYDDHkY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:40:24 -0400
In-Reply-To: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, zboszor@dunaweb.hu, hancockr@shaw.ca, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

akpm@linux-foundation.org wrote:
> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> 
> unchangelogged patch.
> 
> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> Cc: Robert Hancock <hancockr@shaw.ca>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_nv.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/ata/sata_nv.c~ata-swncq-should-be-enabled-by-default drivers/ata/sata_nv.c
> --- a/drivers/ata/sata_nv.c~ata-swncq-should-be-enabled-by-default
> +++ a/drivers/ata/sata_nv.c
> @@ -532,7 +532,7 @@ MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
>  MODULE_VERSION(DRV_VERSION);
>  
>  static int adma_enabled = 1;
> -static int swncq_enabled;
> +static int swncq_enabled = 1;
>  
>  static void nv_adma_register_mode(struct ata_port *ap)
>  {
> @@ -2485,5 +2485,5 @@ module_exit(nv_exit);
>  module_param_named(adma, adma_enabled, bool, 0444);
>  MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: true)");
>  module_param_named(swncq, swncq_enabled, bool, 0444);
> -MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: false)");
> +MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: true)");

applied... we'll see how testing goes



