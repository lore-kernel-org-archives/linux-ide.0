From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: libahci: make ahci_pmp_retry_softreset() as static
Date: Wed, 19 Feb 2014 16:38:55 +0400
Message-ID: <5304A5DF.8070302@cogentembedded.com>
References: <3035873.ZkIlzycZBr@daeseok-laptop.cloud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3035873.ZkIlzycZBr@daeseok-laptop.cloud.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Daeseok Youn <daeseok.youn@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 19-0202014 9:07, Daeseok Youn wrote:

>  From 2a428e5e45bca3fc38fad17b9e2e14c5e6514ca0 Mon Sep 17 00:00:00 2001
> From: Daeseok Youn <daeseok.youn@gmail.com>
> Date: Wed, 19 Feb 2014 10:56:37 +0900
> Subject: [PATCH] ata: libahci: make ahci_pmp_retry_softreset() as static

    This header is not needed.

> sparse says:

> drivers/ata/libahci.c:1390:5: warning:
>   symbol 'ahci_pmp_retry_softreset' was not declared. Should it be static?

> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
> ---
>   drivers/ata/libahci.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 36605ab..f9600fe 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1387,7 +1387,7 @@ static int ahci_bad_pmp_check_ready(struct ata_link *link)
>   	return ata_check_ready(status);
>   }
>
> -int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
> +static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
>   				unsigned long deadline)

     Realign this continuation line too, for it to start under *struct* on the 
first line.

WBR, Sergei
