From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Thu, 27 Sep 2007 02:19:33 -0400
Message-ID: <46FB4B75.9030407@garzik.org>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu> <46F9D6A8.8010809@garzik.org> <46F9EFC9.9030209@dunaweb.hu> <46F9F05F.40905@garzik.org> <46F9F223.4000406@dunaweb.hu> <15F501D1A78BD343BE8F4D8DB854566B059FE1AB@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45414 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbXI0GTm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 02:19:42 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1AB@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, Peer Chen <pchen@nvidia.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

Kuan Luo wrote:
> hi,
> i saw the below changes  from
> http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commi
> tdiff;h=5a5a9e1890b8260686218a68862d880daee1a817
> 
> [libata] sata_nv: Clean up ATA_FLAG_NCQ usage; bit test micro-opt
> 
>  @@ -622,7 +622,9 @@ static const struct ata_port_info nv_port_info[] =
> {
>         /* SWNCQ */
>         {
>                 .sht            = &nv_swncq_sht,
> -               .flags          = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
> +               .flags          = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
> +                                 ATA_FLAG_NCQ,
> +               .link_flags     = ATA_LFLAG_HRST_TO_RESUME,
>                 .pio_mask       = NV_PIO_MASK,
>                 .mwdma_mask     = NV_MWDMA_MASK,
>                 .udma_mask      = NV_UDMA_MASK,
> 
> If swncq_enabled is set zero by user, nv_swncq_host_init would not be
> called .
>  Then ncq should be disabled and the libata shouldn't send ncq cmd. 
>  I am not sure whether the  ATA_FLAG_NCQ flag which is in default set
> makes libata send ncq cmd even when swncq_enable is 0?
> 
> nv_init_one
> 	} else if (type == SWNCQ && swncq_enabled) {
> 		dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ
> mode\n");
> 		nv_swncq_host_init(host);

Thanks for watching!  Yes, that looks like a problem.

I still feel the flags usage I removed was problematic.  A better 
solution, I think, would be to do follow the ADMA example of switching 
the port_info type during early initialization:

	if (type >= CK804 && adma_enabled) {
		type = ADMA;

which in our case would result in

	if (type == SWNCQ && !swncq_enabled)
		type = GENERIC;

Or, if you prefer, we could take the opposite route, _not_ set SWNCQ in 
the pci_device_id table, and instead do something like

	if (type >= MCP65 && swncq_enabled)
		type = SWNCQ;

(MCP65 is just a pulled-out-of-thin-air example)

Regards,

	Jeff


