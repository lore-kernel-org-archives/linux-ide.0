From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date: Fri, 15 Jun 2012 14:04:28 +0400
Message-ID: <4FDB08AC.8010208@mvista.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com> <1339747801-28691-10-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61987 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756246Ab2FOKFI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2012 06:05:08 -0400
Received: by lahd3 with SMTP id d3so1942000lah.19
        for <linux-ide@vger.kernel.org>; Fri, 15 Jun 2012 03:05:06 -0700 (PDT)
In-Reply-To: <1339747801-28691-10-git-send-email-chenhc@lemote.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

Hello.

On 15-06-2012 12:09, Huacai Chen wrote:

> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> Signed-off-by: Hua Yan<yanh@lemote.com>

    You  should have CCed the 'linux-ide' mailing list.

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

    No, this #ifdef'ery won't do. You should add a new board type.

MBR, Sergei
