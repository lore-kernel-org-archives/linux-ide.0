From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] atiixp: missing parentheses?
Date: Tue, 17 Feb 2009 17:25:38 +0300
Message-ID: <499AC8E2.60406@ru.mvista.com>
References: <499AB75F.6060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24981 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753439AbZBQOZR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2009 09:25:17 -0500
In-Reply-To: <499AB75F.6060709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Roel Kluin wrote:

> This looks odd, is below what was intended? note that timing_shift can
> only be 16, 8 or 0. Maybe intended was 24, 16, 8 or 0? then we should do:

    Looking at the libata driver, yes, it should be 0, 8, 16, and 24.

> int timing_shift = ((drive->dn & 2) ? 16 : 0) + ((drive->dn & 1) ? 0 : 8);
> --------------------------->8-------------8<------------------------------
> Add missing parentheses

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

> diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
> index b2735d2..b7813ec 100644
> --- a/drivers/ide/atiixp.c
> +++ b/drivers/ide/atiixp.c
> @@ -52,7 +52,7 @@ static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
>  	unsigned long flags;
> -	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
> +	int timing_shift = (drive->dn & 2) ? 16 : 0 + ((drive->dn & 1) ? 0 : 8);
>  	u32 pio_timing_data;
>  	u16 pio_mode_data;
>  
> @@ -85,7 +85,7 @@ static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
>  {
>  	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
>  	unsigned long flags;
> -	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
> +	int timing_shift = (drive->dn & 2) ? 16 : 0 + ((drive->dn & 1) ? 0 : 8);
>  	u32 tmp32;
>  	u16 tmp16;
>  	u16 udma_ctl = 0;

    Why didn't you add parens around the first ?: then? They are surely 
needed. Though this clearly needs to be simplified to (drive->dn * 8).

MBR, Sergei
