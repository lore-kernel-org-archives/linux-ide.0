From: "Jeroen Janssen" <jeroen.janssen@gmail.com>
Subject: Re: [PATCH] sata_via: add missing PM hooks
Date: Tue, 8 May 2007 11:54:43 +0200
Message-ID: <e34e42440705080254v2fdd5069yccb946f71dec5231@mail.gmail.com>
References: <463B357A.4090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:3610 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934656AbXEHJyo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 05:54:44 -0400
Received: by an-out-0708.google.com with SMTP id d18so217956and
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 02:54:43 -0700 (PDT)
In-Reply-To: <463B357A.4090703@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Hi,

Any idea how I can track that this has been picked up/applied (I
looked at some of the git repositories on kernel.org, but as far as I
can tell, this patch is not in yet).

Best regards,

Jeroen Janssen

On 5/4/07, Tejun Heo <htejun@gmail.com> wrote:
> For some reason, sata_via is missing PM hooks.  Add them.  Spotted by
> Jeroen Janssen <jeroen.janssen@gmail.com>.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jeroen Janssen <jeroen.janssen@gmail.com>
> ---
> I have no idea how we missed this.  This is for both libata-dev &&
> -stable.  Thanks.
>
> Index: tree0/drivers/ata/sata_via.c
> ===================================================================
> --- tree0.orig/drivers/ata/sata_via.c
> +++ tree0/drivers/ata/sata_via.c
> @@ -97,6 +97,10 @@ static struct pci_driver svia_pci_driver
>         .name                   = DRV_NAME,
>         .id_table               = svia_pci_tbl,
>         .probe                  = svia_init_one,
> +#ifdef CONFIG_PM
> +       .suspend                = ata_pci_device_suspend,
> +       .resume                 = ata_pci_device_resume,
> +#endif
>         .remove                 = ata_pci_remove_one,
>  };
>
> @@ -116,6 +120,10 @@ static struct scsi_host_template svia_sh
>         .slave_configure        = ata_scsi_slave_config,
>         .slave_destroy          = ata_scsi_slave_destroy,
>         .bios_param             = ata_std_bios_param,
> +#ifdef CONFIG_PM
> +       .suspend                = ata_scsi_device_suspend,
> +       .resume                 = ata_scsi_device_resume,
> +#endif
>  };
>
>  static const struct ata_port_operations vt6420_sata_ops = {
>
