From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ide/pmac: housekeeping
Date: Mon, 07 Feb 2011 15:07:07 +0300
Message-ID: <4D4FE06B.1080705@ru.mvista.com>
References: <201102071152.19326.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60379 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab1BGMIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2011 07:08:23 -0500
In-Reply-To: <201102071152.19326.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 07-02-2011 13:52, Bartlomiej Zolnierkiewicz wrote:

> * remove legacy IDE_PMAC_DEBUG debugging code
> * rename struct pmac_ide_hwif to struct pmac_ide_priv
> * remove pmac_ide_hwif_t
> * remove needless {dev,pci}_get_drvdata() casts

> Compile-time tested only.

> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
[...]

> Index: b/drivers/ide/pmac.c
> ===================================================================
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
[...]
> @@ -698,11 +683,6 @@ set_timings_mdma(ide_drive_t *drive, int
>   		cycleTime = tm[i].cycleTime;
>   		accessTime = tm[i].accessTime;
>   		recTime = tm[i].recoveryTime;
> -
> -#ifdef IDE_PMAC_DEBUG
> -		printk(KERN_ERR "%s: MDMA, cycleTime: %d, accessTime: %d, recTime:
> %d\n",

    Hm, the patch is line-wrapped...

WBR, Sergei
