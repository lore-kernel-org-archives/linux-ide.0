From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]: [RFC] Fix error handlnig in hwif-init and sgiioc4 driver
Date: Tue, 8 Feb 2005 17:16:25 +0100
Message-ID: <58cb370e05020808167016ac0d@mail.gmail.com>
References: <41F79A30.4040900@sgi.com>
	 <58cb370e050203064648e81449@mail.gmail.com> <4208C84D.1050104@sgi.com>
	 <4208E094.1020403@sgi.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.202]:10971 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261561AbVBHQQ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 11:16:26 -0500
Received: by wproxy.gmail.com with SMTP id 67so1070735wri
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2005 08:16:26 -0800 (PST)
In-Reply-To: <4208E094.1020403@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-ide@vger.kernel.org

On Tue, 08 Feb 2005 10:53:56 -0500, Prarit Bhargava <prarit@sgi.com> wrote:
> Bartlomiej pointed out that the sgiioc4.c changes have made their way
                                                ^^^^^^^^
all changes

> into Linus' tree.
> 
> Here's an updated change set.
> 
> Thanks,
> 
> P.
> 
> 
> Signed-off-by: Prarit Bhargava <prarit@sgi.com>
> 
> ===== ide-probe.c 1.90 vs edited =====
> --- 1.90/drivers/ide/ide-probe.c        2004-12-10 14:12:14 -05:00
> +++ edited/ide-probe.c  2005-02-08 10:41:46 -05:00
> @@ -841,7 +841,10 @@
>         if (fixup)
>                 fixup(hwif);
> 
> -       hwif_init(hwif);
> +       if (hwif_init(hwif) < 0) {
> +               printk("%s: Failed to initialize IDE interface\n", hwif->name);
> +               return -1;
> +       }
> 
>         if (hwif->present) {
>                 u16 unit = 0;

this one chunk was in merged patch already

> @@ -1245,20 +1248,22 @@
>         int old_irq, unit;
> 
>         if (!hwif->present)
> -               return 0;
> +               return -ENODEV;

this is wrong, there is return 1 (not 0) now because of fix needed
for the previous patch (error message for interface with no drives)

No problem, I can hand-merge this patch but these changes
need some description, "fix hwif_init() return codes" perhaps?
