From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise FastTrak TX4000 (pdc20619), hdparm support for libata,
 smart
Date: Thu, 21 Oct 2004 19:35:35 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <417847C7.9000509@pobox.com>
References: <1098304343.30313.13.camel@server.lorenz.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271102AbUJUXft
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 19:35:49 -0400
In-Reply-To: <1098304343.30313.13.camel@server.lorenz.priv>
List-Id: linux-ide@vger.kernel.org
To: Tobias Lorenz <tobias.lorenz@gmx.net>
Cc: Boris Buchheimer <boris@buchheimer.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tobias Lorenz wrote:


(copied to linux-ide@vger.kernel.org, where the ATA hackers hang out)


> based on linux-2.6.9 + your 2.6.9-libata1-dev1.patch, we made a patch to
> support the Promise FastTrak TX4000 4-port PATA hardware raid
> controller. It is very similar to the sata_promise.c driver, so we added
> the support there.
> 
> We also started to support information tranfer via the hd_driveid
> structure to the hdparm utility in the libata layer. At the moment, we
> only transfer cylinders, sectors, heads, model and firmware version. Our
> intention was to display the supported and the used UDMA mode(s), but we
> didn't find the correct structures yet to get these infos...
> 
> Finally, we tried to use the smart utilities. That's also the reason, we
> we choose your development patch. We found out, that smartctl from the
> smartsuite package, uses scsi-3 smart commands, when trying to access a
> scsi disk device (/dev/sd?). That makes smart access with that utility
> not working. Then we used ide-smart from the ide-smart package. It
> always uses ide smart commands, also to scsi disk devices, and that
> makes it working.
> 
> I hope you include that patch and it get's added to the linux kernel. I
> would be happy to see my name somewhere there. :-)

I would be happy to facilitate that...  libata contributors are always 
welcome.  ;-)


> Todo is just to change/complete the description of the driver and to add
> us to the Changelog/Credits/History/... section(s).

This is pretty good stuff.

I would request that you work with me a bit, as I would like you to make 
a few minor changes.

Comments:

1) [administrivia]  Please submit patches to linux-ide@vger.kernel.org 
and jgarzik@pobox.com email addresses.

2) [administrivia]  There is a standard email format for patches, which 
makes it easier to merge your Linux kernel changes, that I request you 
use.  Details:
	http://linux.yyz.us/patch-format.html
	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

In particular we request a "signed-off-by: ..." line accompany each 
patch and patch description.


> ------------------------------------------------------------------------
> 
> --- linux-2.6.9/drivers/scsi/libata-scsi.c	2004-10-20 22:07:50.000000000 +0200
> +++ linux-2.6.7-patched/drivers/scsi/libata-scsi.c	2004-10-20 19:25:15.000000000 +0200
> @@ -215,6 +215,17 @@
>  	struct ata_port *ap;
>  	struct ata_device *dev;
>  	int val = -EINVAL, rc = -EINVAL;
> +	struct hd_driveid drv_id = {
> +		.cyls		= 0,
> +		.sectors	= 0,
> +		.heads		= 0,
> +		.fw_rev		= "",
> +		.model		= "",
> +		.cur_cyls	= 0,
> +		.cur_heads	= 0,
> +		.cur_sectors	= 0,
> +	};
> +	int geom[3];
>  
>  	ap = (struct ata_port *) &scsidev->host->hostdata[0];
   	if (!ap)
> @@ -249,7 +260,25 @@
>  			return -EACCES;
>  		return ata_task_ioctl(scsidev, arg);
>  
> +	case HDIO_GET_MULTCOUNT:
> +		printk("HDIO_GET_MULTCOUNT not yet implemented\n");
> +		rc = -EOPNOTSUPP;
> +		break;
> +
> +	case HDIO_GET_IDENTITY:
> +		ata_std_bios_param(scsidev, NULL, dev->n_sectors, geom);
> +		drv_id.cur_heads	= drv_id.heads		= geom[0];
> +		drv_id.cur_sectors	= drv_id.sectors	= geom[1];
> +		drv_id.cur_cyls		= drv_id.cyls		= geom[2];
> +		strncpy((char *) &drv_id.model, scsidev->model, sizeof(drv_id.model));
> +		strncpy((char *) &drv_id.fw_rev, scsidev->rev, sizeof(drv_id.fw_rev));
> +		if(copy_to_user((char *) arg, (char *) &drv_id,
> +				 sizeof(drv_id)))
> +			return(-EFAULT);
> +		return 0;
> +		
>  	default:
> +		printk("command was: %#x\n", cmd);
>  		rc = -EOPNOTSUPP;
>  		break;

3) Since the default return value is EOPNOTSUPP, I would rather not 
include a "not implemented yet" implementation :)  So, please remove the 
HDIO_GET_MULTCOUNT part of the patch.

4) Also, per the "split up logical changes" standard, please send this 
change in a separate patch (and separate email).


> -static struct pci_device_id pdc_sata_pci_tbl[] = {
> -	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +static struct pci_device_id pdc_ata_pci_tbl[] = {
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_2037x },
> -	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_2037x },
> -	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_2037x },
> -	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_2037x },
> -	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_20319 },
> -	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_20319 },
> +	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20619, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_20619 },

5) [style]  While your patch _is_ 100% correct, my own personal feeling 
is that PCI device ids have very little value as constants in 
include/linux/pci_ids.h.  Therefore, I actually prefer to use the 
hexidecimal constant rather than a named constant.

6) [summary]  Overall, I do not see any bugs or problems in your 
sata_promise patch.  However...  I need to ponder a "human" question... 
  does it make sense to add support for a PATA controller to a module 
named 'sata_promise'?

I wish to avoid code duplication of course, but this is an issue I would 
like to address.

Perhaps we could apply your patch, then rename the kernel module to 
'ata_promise'.  [we can use the MODULE_ALIAS facility to smooth the user 
transition]

	Jeff




