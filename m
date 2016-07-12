From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Tue, 12 Jul 2016 13:27:26 +0200
Message-ID: <2928643.x6ZsLjxZ9e@amdc1976>
References: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46140 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210AbcGLL2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 07:28:32 -0400
In-reply-to: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: kernel-tram@lists.ubuntu.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


Hi,

On Tuesday, July 12, 2016 12:16:19 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
> bits 11:8 specify the primary drive cmd_high_time, however,
> currently just 3 bits of the 4 are being used because the mask
> is 0x700 and not 0x0f00.  Fix the mask, allowing for the 40MHz clock
> to be detected.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for the patch, could you also fix also the old driver
(drivers/ide/hpt366.c)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_hpt366.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
> index e5fb752..a219a50 100644
> --- a/drivers/ata/pata_hpt366.c
> +++ b/drivers/ata/pata_hpt366.c
> @@ -368,7 +368,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	/* PCI clocking determines the ATA timing values to use */
>  	/* info_hpt366 is safe against re-entry so we can scribble on it */
> -	switch ((reg1 & 0x700) >> 8) {
> +	switch ((reg1 & 0xf00) >> 8) {
>  	case 9:
>  		hpriv = &hpt366_40;
>  		break;

