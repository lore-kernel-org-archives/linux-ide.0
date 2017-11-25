From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] pata_pdc2027x: Remove unnecessary error check and
 coding style error.
Date: Fri, 24 Nov 2017 20:37:58 -0800
Message-ID: <1511584678.8230.16.camel@perches.com>
References: <9c2e4c1081be44da4460072ae6129d29c7e6d6bc.1511583254.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9c2e4c1081be44da4460072ae6129d29c7e6d6bc.1511583254.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, 2017-11-25 at 09:45 +0530, Arvind Yadav wrote:
> Here, The function pdc_hardware_init always return zero. So it is not
> necessary to check its return value.
> 
> Fix these checkpatch.pl error:
> 
> ERROR: space prohibited after that '~' (ctx:WxW)
> +		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
> 
> ERROR: spaces required around that '?' (ctx:VxW)
> +	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
> 
> ERROR: that open brace { should be on the previous line
> +	const struct ata_port_info *ppi[] =
> +		{ &pdc2027x_port_info[board_idx], NULL };
[]
> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
[]
> @@ -520,7 +520,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
>  	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
>  	u16 pll_ctl;
>  	long pll_clock_khz = pll_clock / 1000;
> -	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
> +	long pout_required = board_idx ? PDC_133_MHZ:PDC_100_MHZ;

If spaces are used around the ?, use spaces around the : too

> @@ -753,8 +753,7 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
>  	//pci_enable_intx(pdev);
>  
>  	/* initialize adapter */
> -	if (pdc_hardware_init(host, board_idx) != 0)
> -		return -EIO;
> +	pdc_hardware_init(host, board_idx);

If this is so, then please make the function return void
