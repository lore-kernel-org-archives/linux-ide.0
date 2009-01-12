From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/1] pata_via.c: Support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Mon, 12 Jan 2009 13:58:54 +0300
Message-ID: <496B226E.60108@ru.mvista.com>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087369D7@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28164 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751555AbZALK7E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jan 2009 05:59:04 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087369D7@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, HaraldWelte@viatech.com, tj@kernel.org, BruceChang@via.com.tw

Hello.

JosephChan@via.com.tw wrote:

> This patch based on 2.6.28-git10.
> It supports VX855 and future chips whose IDE controller use 0x0571.
>
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
>
> --- a/include/linux/pci_ids.h	2009-01-09 23:28:18.000000000 +0800
> +++ b/include/linux/pci_ids.h	2009-01-10 00:35:15.000000000 +0800
> @@ -1370,6 +1370,7 @@
>  #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
>  #define PCI_DEVICE_ID_VIA_838X_1	0xB188
>  #define PCI_DEVICE_ID_VIA_83_87XX_1	0xB198
> +#define PCI_DEVICE_ID_VIA_ANON		0xFFFF
>  
>  #define PCI_VENDOR_ID_SIEMENS           0x110A
>  #define PCI_DEVICE_ID_SIEMENS_DSCC4     0x2102
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
> +
>   

   Why not:

	if (pdev->device == 0xC409)
		if (ap->port_no == 0) {
			pci_read_config_dword(pdev, 0x52, &ata66);
			return (ata66 & 0x10)  ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
		} else if (ap->port_no == 1) {
			DPRINTK("C409 only has one pata channel\n");
			return ATA_CBL_PATA_UNK;
	}


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
>  }
>   

   This looks like an unrelated fix...

MBR, Sergei


