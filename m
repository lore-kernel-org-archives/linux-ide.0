From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: enable 32bit PIO on SATA piix
Date: Tue, 12 Jan 2010 14:38:46 -0500
Message-ID: <4B4CCFC6.5000503@garzik.org>
References: <4B4ADB3F.2080505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45885 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0ALTis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 14:38:48 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so21719035yxe.33
        for <linux-ide@vger.kernel.org>; Tue, 12 Jan 2010 11:38:48 -0800 (PST)
In-Reply-To: <4B4ADB3F.2080505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 01/11/2010 03:03 AM, Tejun Heo wrote:
> Commit 871af1210f13966ab911ed2166e4ab2ce775b99d enabled 32bit PIO for
> PATA piix but didn't for SATA.  There's no reason not to use 32bit PIO
> on SATA piix.  Enable it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Alan Cox<alan@lxorguk.ukuu.org.uk>
> ---
>   drivers/ata/ata_piix.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: ata/drivers/ata/ata_piix.c
> ===================================================================
> --- ata.orig/drivers/ata/ata_piix.c
> +++ ata/drivers/ata/ata_piix.c
> @@ -329,7 +329,7 @@ static struct ata_port_operations ich_pa
>   };
>
>   static struct ata_port_operations piix_sata_ops = {
> -	.inherits		=&ata_bmdma_port_ops,
> +	.inherits		=&ata_bmdma32_port_ops,
>   };

applied


