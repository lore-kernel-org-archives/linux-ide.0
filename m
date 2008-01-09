From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 80 wire cable detection patch
Date: Thu, 10 Jan 2008 00:26:25 +0100
Message-ID: <200801100026.25364.bzolnier@gmail.com>
References: <477D0BDF.6020801@yandex.ru> <200801051921.45084.bzolnier@gmail.com> <47812554.4060606@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:33846 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbYAIXO4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 18:14:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so154593ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 15:14:55 -0800 (PST)
In-Reply-To: <47812554.4060606@yandex.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Kibardin <george-kibardin@yandex.ru>
Cc: linux-ide@vger.kernel.org


Hi,

On Sunday 06 January 2008, George Kibardin wrote:
> Signed-off-by: George Kibardin <george-kibardin@yandex.ru>
> 
> --- drivers/ide/ide-iops.c.orig 2008-01-03 18:35:23.000000000 +0300
> +++ drivers/ide/ide-iops.c      2008-01-03 18:12:29.000000000 +0300
> @@ -612,12 +612,12 @@
>                printk(KERN_DEBUG "%s: skipping word 93 validity check\n",
>                                  drive->name);
> 
> -       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
> -               goto no_80w;
> -
>        if (ide_dev_is_sata(id) && !ivb)
>                return 1;

Ehm, this was not changed in the code before generating patch but in
the patch itself so the patch won't apply... :(

> +       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
> +               goto no_80w;
> +
>        /*
>         * FIXME:
>         * - change master/slave IDENTIFY order

This time I just applied fix by hand and added missing patch summary
("ide: fix cable detection for SATA bridges") but in the future please
make sure that the patch applies and has a meaningful description.

Thanks,
Bart
