From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Mon, 12 Dec 2016 12:01:54 -0500
Message-ID: <20161212170154.GA13864@htj.duckdns.org>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
 <20161130145322.252f7403@lxorguk.ukuu.org.uk>
 <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org>
 <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org>
 <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org>
 <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36602 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbcLLRB5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2016 12:01:57 -0500
Received: by mail-qt0-f196.google.com with SMTP id n34so10595134qtb.3
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2016 09:01:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

On Fri, Dec 09, 2016 at 12:57:02PM -0500, tedheadster wrote:
> ​Tejun,
>   here is the patch I applied:
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index 4fe9d21..5c6c578 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -963,6 +963,9 @@ static __init int legacy_init_one(struct legacy_probe
> *probe)
>         if (IS_ERR(pdev))
>                 return PTR_ERR(pdev);
> 
> +       if (!devres_open_group(&pdev->dev, legacy_init_one, GFP_KERNEL))
> +               return -ENOMEM;

Can you please drop the explicit group open/remove/release?

>         ret = -EBUSY;
>         if (devm_request_region(&pdev->dev, io, 8, "pata_legacy") == NULL ||
>             devm_request_region(&pdev->dev, io + 0x0206, 1,
> @@ -1009,11 +1012,14 @@ static __init int legacy_init_one(struct
> legacy_probe *probe)
>                 if (!ata_dev_absent(dev)) {
>                         legacy_host[probe->slot] = host;
>                         ld->platform_dev = pdev;
> +                       devres_remove_group(&pdev->dev, legacy_init_one);
>                         return 0;
>                 }
>         }
>         ata_host_detach(host);
>  fail:
> +       devres_release_group(&pdev->dev, legacy_init_one);
> +       printk("XXX pata_legacy: unregistering platform dev %p\n", pdev);
>         platform_device_unregister(pdev);

So, the thing is that when the platform device is released here, it
should automatically trigger release of all resources attached to it
through...

>         return ret;
>  }
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a235085..8e8948e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -214,6 +214,7 @@ static void device_release(struct kobject *kobj)
>          * is deleted but alive, so release devres here to avoid
>          * possible memory leak.
>          */
> +       printk("XXX device_release: invoking devres_release_all\n");
>         devres_release_all(dev);

the devres_release_all() call here.

Can you please try to verify that devres_release_all() is being
invoked from platform device release?  I'll try to see if I can repro
the problem here.

thanks.

-- 
tejun
