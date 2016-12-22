From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Thu, 22 Dec 2016 11:37:11 -0500
Message-ID: <20161222163711.GB29161@htj.duckdns.org>
References: <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org>
 <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org>
 <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org>
 <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org>
 <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33133 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936060AbcLVQhT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2016 11:37:19 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so15151045ywg.0
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2016 08:37:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

On Mon, Dec 19, 2016 at 09:12:49PM -0500, tedheadster wrote:
> Tejun,
>   apologies this took a while. Here is the patch I _think_ you were
> asking me to test:
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index bce2a8c..bfa63d1 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -1008,12 +1008,15 @@ static __init int legacy_init_one(struct
> legacy_probe *probe)
>         if (!ata_dev_absent(dev)) {
>             legacy_host[probe->slot] = host;
>             ld->platform_dev = pdev;
> +                       devres_remove_group(&pdev->dev, legacy_init_one);
>             return 0;
>         }
>     }
>         ata_host_detach(host);
>  fail:
>           platform_device_unregister(pdev);
> +       devres_release_group(&pdev->dev, legacy_init_one);
> +       printk("XXX pata_legacy: unregistering platform dev %p\n", pdev);
>     return ret;

The thing I'm puzzled about and can't reproduce here is that the
platform_device_unregister() call on the fail path should release the
irq resources without the explicit devres group operations.  I can
write up tracking each step but it'd probably be easier on your side
to track down why it's not getting called.

So, pata_legacy doesn't need anything changed, but in the probe fail
path, platform_device_unregister() should trigger
driver/base/core.c::device_release() which calls devres_release_all()
and release the irqs.

Thanks.

-- 
tejun
