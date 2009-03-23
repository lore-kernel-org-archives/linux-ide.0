From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE cable detection on Apple PowerBook
Date: Mon, 23 Mar 2009 13:57:03 +0300
Message-ID: <49C76AFF.5090008@ru.mvista.com>
References: <20090322101704.80473ee8.posco.grubb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:15080 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753161AbZCWK4Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Mar 2009 06:56:16 -0400
In-Reply-To: <20090322101704.80473ee8.posco.grubb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TOMARI Hisanobu <posco.grubb@gmail.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, benh@kernel.crashing.org

TOMARI Hisanobu wrote:

> This patch against 2.6.28.8 modifies the behavior of 80c cable detection 
> of drivers/ide/pmac.c.
> As IDE cable used on Apple PowerBook/iBook laptops are always of "Short 40" 
> type when the firmware says it's 80 conductor one, the cable detection should 
> return ATA_CBL_PATA40_SHORT on those machines.
> This enables to automatically use UDMA5 even with drives that doesn't correctly 
> detect those cables on Apple laptops.

> Signed-off-by: TOMARI Hisanobu <posco.grubb@gmail.com>

> --- linux-2.6.28.8/drivers/ide/pmac.c.orig	2009-03-21 23:07:19.177956922 +0900
> +++ linux-2.6.28.8/drivers/ide/pmac.c	2009-03-22 09:57:58.774048828 +0900
> @@ -917,10 +917,19 @@ static u8 pmac_ide_cable_detect(ide_hwif
>  		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
>  	struct device_node *np = pmif->node;
>  	const char *cable = of_get_property(np, "cable-type", NULL);
> +	struct device_node *root = of_find_node_by_path("/");
> +	const char *model = of_get_property(root, "model", NULL);
>  
>  	/* Get cable type from device-tree. */
>  	if (cable && !strncmp(cable, "80-", 3))
> +	  {

    Unacceptable style, brace should be on the same line with *if*; run your 
patch thru scripts/checkpatch.pl please...

> +	    /* Some drives fail to detect 80c cable in PowerBook */
> +	    /* These machine use proprietary short IDE cable anyway */

    s/machine/machines/

> +	    if (!strncmp(model,"PowerBook", 9))
> +		return ATA_CBL_PATA40_SHORT;
> +	    else
>  		return ATA_CBL_PATA80;
> +	  }
>  
>  	/*
>  	 * G5's seem to have incorrect cable type in device-tree.

WBR, Sergei
