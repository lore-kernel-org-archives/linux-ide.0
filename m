From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: get-identity ioctl in libata?
Date: Tue, 8 Mar 2005 09:14:17 +0100
Message-ID: <58cb370e0503080014a97ac0e@mail.gmail.com>
References: <422D2E24.3060208@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.199]:6988 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261871AbVCHIOR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Mar 2005 03:14:17 -0500
Received: by wproxy.gmail.com with SMTP id 68so1770835wra
        for <linux-ide@vger.kernel.org>; Tue, 08 Mar 2005 00:14:17 -0800 (PST)
In-Reply-To: <422D2E24.3060208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tobias Lorenz <tobias.lorenz@gmx.net>

Hi Jeff,

My concerns are following:
* it is not complete HDIO_GET_IDENTIFY implementation
  (applications may assume otherwise)
* you may need to add byte-swapping of the fields in the future
  (currently it is fine)
* same info is available via pass-thru inteface

Bartlomiej

On Mon, 07 Mar 2005 23:46:28 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bart,
> 
> Did you say that there was some problem with the patch to add
> HDIO_GET_IDENTITY support to libata (attached)?
> 
> I forget what the issues were, and this has been sitting in
> libata-dev-2.6 for a while.
> 
>         Jeff
> 
> 
> diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> --- a/drivers/scsi/libata-scsi.c        2005-03-07 23:44:42 -05:00
> +++ b/drivers/scsi/libata-scsi.c        2005-03-07 23:44:42 -05:00
> @@ -72,6 +72,17 @@
>         struct ata_port *ap;
>         struct ata_device *dev;
>         int val = -EINVAL, rc = -EINVAL;
> +       struct hd_driveid drv_id = {
> +               .cyls           = 0,
> +               .sectors        = 0,
> +               .heads          = 0,
> +               .fw_rev         = "",
> +               .model          = "",
> +               .cur_cyls       = 0,
> +               .cur_heads      = 0,
> +               .cur_sectors    = 0,
> +       };
> +       int geom[3];
> 
>         ap = (struct ata_port *) &scsidev->host->hostdata[0];
>         if (!ap)
> @@ -94,6 +105,17 @@
>                 val = (unsigned long) arg;
>                 if (val != 0)
>                         return -EINVAL;
> +               return 0;
> +
> +       case HDIO_GET_IDENTITY:
> +               ata_std_bios_param(scsidev, NULL, dev->n_sectors, geom);
> +               drv_id.cur_heads        = drv_id.heads          = geom[0];
> +               drv_id.cur_sectors      = drv_id.sectors        = geom[1];
> +               drv_id.cur_cyls         = drv_id.cyls           = geom[2];
> +               strncpy((char *) &drv_id.model, scsidev->model, sizeof(drv_id.model));
> +               strncpy((char *) &drv_id.fw_rev, scsidev->rev, sizeof(drv_id.fw_rev));
> +               if(copy_to_user((char *) arg, (char *) &drv_id, sizeof(drv_id)))
> +                       return(-EFAULT);
>                 return 0;
> 
>         default:
> 
> 
>
