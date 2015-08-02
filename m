From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] Check return code from pdc20621_i2c_read()
Date: Sun, 2 Aug 2015 14:09:16 +0300
Message-ID: <55BDFA5C.3040506@cogentembedded.com>
References: <1438510340-21568-1-git-send-email-barletz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33532 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbHBLJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Aug 2015 07:09:18 -0400
Received: by lbbyj8 with SMTP id yj8so65422532lbb.0
        for <linux-ide@vger.kernel.org>; Sun, 02 Aug 2015 04:09:17 -0700 (PDT)
In-Reply-To: <1438510340-21568-1-git-send-email-barletz@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 8/2/2015 1:12 PM, Tomer Barletz wrote:

> The variable spd0 might be used uninitialized when pdc20621_i2c_read()
> fails.
> This also generates a compilation warning with gcc 5.1.

> Signed-off-by: Tomer Barletz <barletz@gmail.com>
> ---
>   drivers/ata/sata_sx4.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index 3a18a8a..bed311b 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1238,8 +1238,11 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_host *host)
>   	readl(mmio + PDC_SDRAM_CONTROL);
>
>   	/* Turn on for ECC */
> -	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -			  PDC_DIMM_SPD_TYPE, &spd0);
> +	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +	                       PDC_DIMM_SPD_TYPE, &spd0)) {
> +		printk(KERN_ERR "Failed in i2c read: device=0x%d, subaddr=0x%d\n", PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);

    Please use pr_err() instead. And "0x%d" makes no sense at all, please use 
"%#x" instead.

[...]
> @@ -1380,8 +1383,11 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>
>   	/* ECC initiliazation. */
>
> -	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -			  PDC_DIMM_SPD_TYPE, &spd0);
> +	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +	                       PDC_DIMM_SPD_TYPE, &spd0)) {
> +		printk(KERN_ERR "Failed in i2c read: device=0x%d, subaddr=0x%d\n", PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);

    Likewise.

MNR, Sergei

