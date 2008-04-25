From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Fri, 25 Apr 2008 10:59:02 +0900
Message-ID: <48113AE6.6060904@gmail.com>
References: <480F231A.7020401@gmail.com> <200804250217.34418.volker.armin.hemmann@tu-clausthal.de> <4811298A.4070903@gmail.com> <200804250317.16396.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.248]:63322 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755608AbYDYB7I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 21:59:08 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1957147rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 18:59:08 -0700 (PDT)
In-Reply-To: <200804250317.16396.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
>  static void ahci_enable_ahci(void __iomem *mmio)
>  {
> +       int i;
>         u32 tmp;
> 
>         /* turn on AHCI_EN */
>         tmp = readl(mmio + HOST_CTL);
> -       if (!(tmp & HOST_AHCI_EN)) {
> +       if (tmp & HOST_AHCI_EN)
> +               return;
> +
> +       /* Some controllers need AHCI_EN to be written multiple times.
> +        * Try a few times before giving up.
> +        */
> +       for (i = 0; i < 5; i++) {
>                 tmp |= HOST_AHCI_EN;
>                 writel(tmp, mmio + HOST_CTL);
>                 tmp = readl(mmio + HOST_CTL);   /* flush && sanity check */
> -               WARN_ON(!(tmp & HOST_AHCI_EN));
> +               if (tmp & HOST_AHCI_EN)
> +                       return;
> +               msleep(10);
>         }
> +
> +       WARN_ON(1);
>  }

Heh... your patch is white-space broken.  Just save whole mail to a file 
and use filterdiff to extract patch.  Copy & pasting doesn't always work.

-- 
tejun
