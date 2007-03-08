From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 5/7] [RFC] xenon: add SATA support
Date: Thu, 08 Mar 2007 16:54:51 +0900
Message-ID: <45EFC14B.3090906@gmail.com>
References: <20070307180144.812594000@elitedvb.net>> <45EF2899.2030508@elitedvb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:12579 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965010AbXCHHyw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 02:54:52 -0500
Received: by nz-out-0506.google.com with SMTP id s1so323329nze
        for <linux-ide@vger.kernel.org>; Wed, 07 Mar 2007 23:54:51 -0800 (PST)
In-Reply-To: <45EF2899.2030508@elitedvb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linux-ide@vger.kernel.org

Hello,

Generally looks good.  Some questions and suggestions follow.

Felix Domke wrote:
> Index: linux-2.6.20/drivers/ata/libata-core.c
> ===================================================================
> --- linux-2.6.20.orig/drivers/ata/libata-core.c	2007-03-07
> 19:01:12.000000000 +0100
> +++ linux-2.6.20/drivers/ata/libata-core.c	2007-03-07 19:01:22.000000000
> +0100
> @@ -1478,7 +1478,7 @@
>  	}
> 
>  	tf.protocol = ATA_PROT_PIO;
> -	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
> +//	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */

Polling IDENTIFY doesn't work for you?  Care to explain how it's broken?

> Index: linux-2.6.20/drivers/ata/sata_xenon.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.20/drivers/ata/sata_xenon.c	2007-03-07 19:01:22.000000000
> +0100
> +	   Note on the DVD-ROM part:
> +
> +	   The drives usually require some tweaks to be usable under linux.
> +
> +	   You either need to hack the scsi layer, or, in case of the GDR3120L,
> +	   set 'modeB' in the bootloader.

Care to explain it further?  Or is it some cryptic embedded stuff?

> +extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
> +						 const struct ata_port_info *port);

This is an internal function and if you do this, your driver won't build
as a kernel module.  Please do as other drivers do.  probe_ent is in the
process of being removed, so looking ugly is okay for the time being.

> +static u32 xenon_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg,
> pdev->device);
> +	u32 val;
> +
> +	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
> +		return 0; /* assume no error */

Interesting, SError isn't there while other regs are?

> +static u32 xenon_scr_read (struct ata_port *ap, unsigned int sc_reg)
> +{
> +	if (sc_reg > SCR_CONTROL)
> +		return 0xffffffffU;
> +
> +	return xenon_scr_cfg_read(ap, sc_reg);
> +}

Just collapse xenon_scr_cfg_read() into xenon_scr_read().

> +static void xenon_scr_write (struct ata_port *ap, unsigned int sc_reg,
> u32 val)
> +{
> +	if (sc_reg > SCR_CONTROL)
> +		return;
> +
> +	xenon_scr_cfg_write(ap, sc_reg, val);
> +}

Ditto for write.

> +static int xenon_init_one (struct pci_dev *pdev, const struct
> pci_device_id *ent)
> +{
> +	static int printed_version;
> +	struct ata_probe_ent *probe_ent = NULL;
> +	int rc;
> +	int pci_dev_busy = 0;
> +
> +	if (!printed_version++)
> +		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc)
> +		return rc;

New drivers are generally accepted into libata-dev#upstream branch, and
it looks a bit different in the init path.  If you're a gitter, please
generate patch against libata-dev#upstream, if not the latest -mm should
be good enough.

Thanks.

-- 
tejun
