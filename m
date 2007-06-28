From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken LBA48 support
Date: Thu, 28 Jun 2007 12:14:57 -0400
Message-ID: <87f94c370706280914v7b52a7d7k31d323b9d88da19b@mail.gmail.com>
References: <4683DCD3.1040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:56263 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbXF1QO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 12:14:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so613409ugf
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 09:14:57 -0700 (PDT)
In-Reply-To: <4683DCD3.1040303@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 6/28/07, Tejun Heo <htejun@gmail.com> wrote:
> sata_inic162x can't do LBA48 properly yet.  Whine loudly about it to
> reduce confusion.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_inic162x.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Index: work/drivers/ata/sata_inic162x.c
> ===================================================================
> --- work.orig/drivers/ata/sata_inic162x.c
> +++ work/drivers/ata/sata_inic162x.c
> @@ -664,8 +664,12 @@ static int inic_init_one(struct pci_dev
>         void __iomem * const *iomap;
>         int i, rc;
>
> -       if (!printed_version++)
> +       if (!printed_version++) {
>                 dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
> +               printk(KERN_WARNING "WARNING: sata_inic162x doesn't support "
> +                      "LBA48 yet. Devices larger than\n         "
> +                      "2^28 - 1 sectors (~127GiB) won't work.\n");
> +       }
>
>         /* alloc host */
>         host = ata_host_alloc_pinfo(&pdev->dev, ppi, NR_PORTS);
> -

Does it simply fail?  Or does it corrupt?

In my Windows experience, if you try to write data past ~128GiB and
you don't have LBA48 support you get a wraparound effect that causes
corruption of the data below ~128GiB.  I've seen it happen several
times under Win2K in particular.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
