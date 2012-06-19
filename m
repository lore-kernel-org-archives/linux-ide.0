From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH V2 11/16] ata: Use 32-bit DMA in AHCI for Loongson-3.
Date: Tue, 19 Jun 2012 08:32:58 -0400
Message-ID: <4FE0717A.7070109@garzik.org>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com> <1340088624-25550-12-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47627 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab2FSMdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2012 08:33:03 -0400
Received: by gglu4 with SMTP id u4so4541171ggl.19
        for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2012 05:33:02 -0700 (PDT)
In-Reply-To: <1340088624-25550-12-git-send-email-chenhc@lemote.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

On 06/19/2012 02:50 AM, Huacai Chen wrote:
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ebaf67e..3e3cfd8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] = {
>   	},
>   	[board_ahci_sb700] =	/* for SB700 and SB800 */
>   	{
> +#ifndef CONFIG_CPU_LOONGSON3
>   		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
> +#else
> +		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
> +						AHCI_HFLAG_32BIT_ONLY),
> +#endif
>   		.flags		= AHCI_FLAG_COMMON,


NAK -- the place to fix this up is ahci_init_one()

