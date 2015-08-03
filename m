From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_sx4: Check return code from pdc20621_i2c_read()
Date: Mon, 3 Aug 2015 21:52:44 +0300
Message-ID: <55BFB87C.1010405@cogentembedded.com>
References: <55BF8E29.6000200@cogentembedded.com>
 <1438627595-17126-1-git-send-email-barletz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438627595-17126-1-git-send-email-barletz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 08/03/2015 09:46 PM, Tomer Barletz wrote:

> The variable spd0 might be used uninitialized when pdc20621_i2c_read()
> fails.
> This also generates a compilation warning with gcc 5.1.

> Signed-off-by: Tomer Barletz <barletz@gmail.com>
> ---
>   drivers/ata/sata_sx4.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index 3a18a8a..e1c1423 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1238,8 +1238,12 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_host *host)
>   	readl(mmio + PDC_SDRAM_CONTROL);
>
>   	/* Turn on for ECC */
> -	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -			  PDC_DIMM_SPD_TYPE, &spd0);
> +	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +	                       PDC_DIMM_SPD_TYPE, &spd0)) {

    That won't do, you didn't fix the indentation here.

> +		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n",
> +		       PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
> +		return 1;
> +	}
>   	if (spd0 == 0x02) {
>   		data |= (0x01 << 16);
>   		writel(data, mmio + PDC_SDRAM_CONTROL);
> @@ -1380,8 +1384,12 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>
>   	/* ECC initiliazation. */
>
> -	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -			  PDC_DIMM_SPD_TYPE, &spd0);
> +	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +	                       PDC_DIMM_SPD_TYPE, &spd0)) {

    And here.

> +		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n",
> +		       PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
> +		return 1;
> +	}
>   	if (spd0 == 0x02) {
>   		void *buf;
>   		VPRINTK("Start ECC initialization\n");

MBR, Sergei
