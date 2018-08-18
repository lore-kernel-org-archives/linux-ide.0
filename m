From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCHv2] ide: Use NULL to compare with pointer-typed value
 rather than 0
Date: Sat, 18 Aug 2018 18:53:58 +0300
Message-ID: <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
References: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 08/18/2018 09:16 AM, zhong jiang wrote:

> We should use NULL to compare with pointer-typed value rather than
> 0. The issue is detected with the help of Coccinelle.

   Your description stopped to match the patch in v2.
   Actually, this X ==  NULL to !x preference is largely spocific to netdev...
Although, IDE maintainer is the same now person. :-)  
 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/ide/pmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index c5b902b..ca36a97 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -1682,7 +1682,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>  	/* We won't need pci_dev if we switch to generic consistent
>  	 * DMA routines ...
>  	 */
> -	if (dev == NULL || pmif->dma_regs == 0)
> +	if (!dev || !pmif->dma_regs)
>  		return -ENODEV;
>  	/*
>  	 * Allocate space for the DBDMA commands.

MBR, Sergei
