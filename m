From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Mon, 20 Dec 2010 14:19:54 +0300
Message-ID: <4D0F3BDA.7080404@ru.mvista.com>
References: <1292769160-24420-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:41547 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab0LTLU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Dec 2010 06:20:58 -0500
In-Reply-To: <1292769160-24420-1-git-send-email-wuzhangjin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: "Martin K. Petersen" <mkp@mkp.net>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

Hello.

On 19-12-2010 17:32, Wu Zhangjin wrote:

> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
> variant), so, remove the dependency of X86_32 and fix the building
> errors under the other platforms via only reserving the X86_32 specific
> parts for X86_32.

> pata_amd also supports cs5536 IDE controller, but this one saves about
> 33k for the compressed kernel image(vmlinuz for MIPS).

> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> Signed-off-by: Chen Jie <chenj@lemote.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
[...]

> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> index 21ee23f..643488b 100644
> --- a/drivers/ata/pata_cs5536.c
> +++ b/drivers/ata/pata_cs5536.c
> @@ -37,7 +37,17 @@
>   #include<linux/delay.h>
>   #include<linux/libata.h>
>   #include<scsi/scsi_host.h>
> +
> +#ifdef CONFIG_X86_32
>   #include<asm/msr.h>
> +static int use_msr;
> +module_param_named(msr, use_msr, int, 0644);
> +MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
> +#else
> +#define rdmsr(x, y, z) do { } while (0)
> +#define wrmsr(x, y, z) do { } while (0)
> +#define use_msr 0
> +#endif
>
>   #define DRV_NAME	"pata_cs5536"
>   #define DRV_VERSION	"0.0.7"

    I think you should increment the driver version too.

WBR, Sergei
