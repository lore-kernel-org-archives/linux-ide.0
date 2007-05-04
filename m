From: "Jeroen Janssen" <jeroen.janssen@gmail.com>
Subject: Re: [PATCH] sata_via: add missing PM hooks
Date: Fri, 4 May 2007 15:21:11 +0200
Message-ID: <e34e42440705040621n5d6b8c98g84796a3ce3fcbfb8@mail.gmail.com>
References: <e34e42440705030542r1574dfdre143e2d43edd44d6@mail.gmail.com>
	 <4639F59B.1080009@gmail.com>
	 <e34e42440705040122r2ec59952w2684039868808fcb@mail.gmail.com>
	 <463AF6C6.1050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:26924 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbXEDNVN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 09:21:13 -0400
Received: by an-out-0708.google.com with SMTP id b33so824506ana
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 06:21:12 -0700 (PDT)
In-Reply-To: <463AF6C6.1050402@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

Thanks very much! This indeed solved the problem.
Anything I can to help get it included in the next kernel release?

Best regards,

Jeroen Janssen

On 5/4/07, Tejun Heo <htejun@gmail.com> wrote:
> For some reason, sata_via is missing PM hooks.  Add them.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This patch is against 2.6.21 but you can use it over 2.6.20 too.  Does
> this fix your problem?
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
