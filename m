From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH V6 6/7] ata: ahci_tegra: disable DIPM
Date: Tue, 23 Jan 2018 17:53:01 +0200
Message-ID: <cdff68f3-9a4c-3591-0882-073ffad16e5e@kapsi.fi>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
 <1515482234-24716-7-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515482234-24716-7-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/09/2018 09:17 AM, Preetham Chandru Ramchandra wrote:
> From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> tegra does not support DIPM and it should be disabled

Nit: Tegra should be capitalized

otherwise,
Reviewed-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

> 
> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/ata/ahci_tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index a59a97b1b2e5..013880de6412 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -460,7 +460,7 @@ static struct ata_port_operations ahci_tegra_port_ops = {
>   };
>   
>   static const struct ata_port_info ahci_tegra_port_info = {
> -	.flags		= AHCI_FLAG_COMMON,
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
>   	.pio_mask	= ATA_PIO4,
>   	.udma_mask	= ATA_UDMA6,
>   	.port_ops	= &ahci_tegra_port_ops,
> 
