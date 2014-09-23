From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 1/2] ahci-platform: Bump max number of clocks to 5
Date: Tue, 23 Sep 2014 11:05:40 +0200
Message-ID: <542137E4.2030808@redhat.com>
References: <1411416586-18320-1-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411416586-18320-1-git-send-email-galak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

Thanks, this new set looks good to me, and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


On 09/22/2014 10:09 PM, Kumar Gala wrote:
> Qualcomm IPQ806x SoCs with SATA controllers need 5 clocks to be enabled.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v4/v5:
> * Updated to upstream changes
> 
>  drivers/ata/ahci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 59ae0ee..90156ff 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -53,7 +53,7 @@
>  
>  enum {
>  	AHCI_MAX_PORTS		= 32,
> -	AHCI_MAX_CLKS		= 4,
> +	AHCI_MAX_CLKS		= 5,
>  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
>  	AHCI_DMA_BOUNDARY	= 0xffffffff,
>  	AHCI_MAX_CMDS		= 32,
> 
