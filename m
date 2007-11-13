From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/13] ide: move drive->using_dma check to callers of
 ->dma_host_on method
Date: Tue, 13 Nov 2007 14:23:32 +0300
Message-ID: <47398934.8030100@ru.mvista.com>
References: <200711130002.20962.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:31839 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753301AbXKMLXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 06:23:20 -0500
In-Reply-To: <200711130002.20962.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

> Index: b/drivers/ide/ide-dma.c
> ===================================================================
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
> @@ -470,7 +470,7 @@ EXPORT_SYMBOL(ide_dma_off);
>  
>  void ide_dma_host_on(ide_drive_t *drive)
>  {
> -	if (drive->using_dma) {
> +	if (1) {

    Why so?

>  		ide_hwif_t *hwif	= HWIF(drive);
>  		u8 unit			= (drive->select.b.unit & 0x01);
>  		u8 dma_stat		= hwif->INB(hwif->dma_status);

WBR, Sergei
