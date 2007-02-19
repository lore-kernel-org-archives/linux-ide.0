From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH 12/15] ide: make ide_hwif_t.ide_dma_host_on void
Date: Mon, 19 Feb 2007 23:20:28 +0100
Message-ID: <20070219222028.GA9297@aepfle.de>
References: <20070203135301.2546.54884.sendpatchset@localhost.localdomain> <20070203135307.2546.94874.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40983 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbXBSWUI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 17:20:08 -0500
Content-Disposition: inline
In-Reply-To: <20070203135307.2546.94874.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 03, Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: make ide_hwif_t.ide_dma_host_on void

> +++ b/drivers/ide/ppc/pmac.c
> @@ -1984,10 +1984,8 @@ static void pmac_ide_dma_host_off(ide_dr
>  {
>  }
>  
> -static int
> -pmac_ide_dma_host_on (ide_drive_t *drive)
> +static int pmac_ide_dma_host_on(ide_drive_t *drive)
>  {
> -	return 0;
>  }
>  
>  static int

This missed the s/int/void/
