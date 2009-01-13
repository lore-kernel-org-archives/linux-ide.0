From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] pata_via.c: Support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Tue, 13 Jan 2009 12:58:55 +0900
Message-ID: <496C117F.8050202@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087369D7@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32911 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZAMD7B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jan 2009 22:59:01 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087369D7@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, HaraldWelte@viatech.com, BruceChang@via.com.tw

Hello, Joseph.

JosephChan@via.com.tw wrote:
> This patch based on 2.6.28-git10.
> It supports VX855 and future chips whose IDE controller use 0x0571.
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> --- a/drivers/ata/pata_via.c	2009-01-10 00:35:04.000000000 +0800
> +++ b/drivers/ata/pata_via.c	2009-01-10 00:35:15.000000000 +0800
> @@ -97,6 +97,8 @@
>  	u8 rev_max;
>  	u16 flags;
>  } via_isa_bridges[] = {
> +	{ "vtxxxx",	PCI_DEVICE_ID_VIA_ANON,    0x00, 0x2f, VIA_UDMA_133 |
> +	VIA_BAD_AST },
>  	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, VIA_UDMA_133 |
>  	VIA_BAD_AST | VIA_SATA_PATA },
>  	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
> @@ -176,6 +178,14 @@
>  	if ((config->flags & VIA_SATA_PATA) && ap->port_no == 0)
>  		return ATA_CBL_SATA;
>  
> +	if (ap->port_no == 0 && pdev->device == 0xC409) {
> +		pci_read_config_dword(pdev, 0x52, &ata66);
> +		return (ata66 & 0x10)  ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
> +	} else if (ap->port_no == 1 && pdev->device == 0xC409) {
> +		DPRINTK("C409 only has one pata channel\n");
> +		return ATA_CBL_PATA_UNK;
> +	}

Eh.. can you add 0xC409 entry like other controllers and put necessary
restrictions there?

>  	/* Early chips are 40 wire */
>  	if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
>  		return ATA_CBL_PATA40;
> @@ -335,13 +345,13 @@
>   */
>  static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  {
> -	struct ata_taskfile tmp_tf;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	if (ap->ctl != ap->last_ctl && !(tf->flags & ATA_TFLAG_DEVICE)) {
> -		tmp_tf = *tf;
> -		tmp_tf.flags |= ATA_TFLAG_DEVICE;
> -		tf = &tmp_tf;
> +	if (tf->ctl != ap->last_ctl) {
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
> +		iowrite8(tf->device, ioaddr->device_addr);
>  	}
> +
>  	ata_sff_tf_load(ap, tf);

Can you please explain why this change is necessary?  And if it's
necessary, please put it in a separate patch.

Thanks.

-- 
tejun
