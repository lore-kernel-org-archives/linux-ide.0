From: "George Kibardin" <george-kibardin@yandex.ru>
Subject: RE: 80 wire cable detection patch
Date: Thu, 10 Jan 2008 10:52:26 +0300
Message-ID: <S7456062AbYAJHud/20080110075034Z+333@mail.yandex.ru>
References: <200801100026.25364.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp8.yandex.ru ([213.180.200.213]:50981 "EHLO smtp8.yandex.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbYAJH5G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 02:57:06 -0500
Received: from [62.231.16.21] ([62.231.16.21]:44877 "EHLO mxpkibardin"
        smtp-auth: "george-kibardin" TLS-CIPHER: <none> TLS-PEER-CN1: <none>)
        by mail.yandex.ru with ESMTP id S7456062AbYAJHud (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 10:50:33 +0300
In-Reply-To: <200801100026.25364.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org


I'm sorry, I should have guessed !!
(I applied those little change to my code manually and then to the patch :)

Thanks,
George

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
Sent: Thursday, January 10, 2008 2:26 AM
To: George Kibardin
Cc: linux-ide@vger.kernel.org
Subject: Re: 80 wire cable detection patch


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

Ehm, this was not changed in the code before generating patch but in the
patch itself so the patch won't apply... :(

> +       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
> +               goto no_80w;
> +
>        /*
>         * FIXME:
>         * - change master/slave IDENTIFY order

This time I just applied fix by hand and added missing patch summary
("ide: fix cable detection for SATA bridges") but in the future please make
sure that the patch applies and has a meaningful description.

Thanks,
Bart

