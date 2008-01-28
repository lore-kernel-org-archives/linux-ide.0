From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6 patch] ata_piix.c: make piix_merge_scr() static
Date: Tue, 29 Jan 2008 08:02:28 +0900
Message-ID: <479E5F04.3000009@gmail.com>
References: <20080128221019.GN8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:42569 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762243AbYA1XCp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 18:02:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3281387wah.23
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 15:02:42 -0800 (PST)
In-Reply-To: <20080128221019.GN8767@does.not.exist>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> piix_merge_scr() can become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> f272ad2ac4274a59f0b43cfd65488c51855132d4 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index a65c8ae..1a5c3bf 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1068,7 +1068,7 @@ static void piix_sidpr_write(struct ata_device *dev, unsigned int reg, u32 val)
>  	iowrite32(val, hpriv->sidpr + PIIX_SIDPR_DATA);
>  }
>  
> -u32 piix_merge_scr(u32 val0, u32 val1, const int * const *merge_tbl)
> +static u32 piix_merge_scr(u32 val0, u32 val1, const int * const *merge_tbl)
>  {
>  	u32 val = 0;
>  	int i, mi;

Ah.. right.  Thanks.  I somehow forgot static in front of it.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
