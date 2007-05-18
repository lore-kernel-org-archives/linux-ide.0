From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PATCH] ahci: disable 64bit dma on sb600
Date: Sat, 19 May 2007 00:19:28 +1000 (EST)
Message-ID: <188298.26701.qm@web52605.mail.re2.yahoo.com>
References: <464DA7A6.3010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52605.mail.re2.yahoo.com ([206.190.48.208]:32686 "HELO
	web52605.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754997AbXEROTc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 May 2007 10:19:32 -0400
In-Reply-To: <464DA7A6.3010303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, wolke.liu@amd.com
Cc: linux-ide@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> SB600 claims it can do 64bit DMA but it can't.  Disable it.
> 
> DON'T APPLY YET
> ---
> 
> Srihari, can you test this against 2.6.22-rc1-git7 just in case?  I'll
> send this upstream after you ack.

Tejun,

Of course. Yes, it's working great without mem=4095M parameter on AMD690G
chipset (Asus M2A-VM) with 4 GB of RAM & Seagate SATA drives on SB600 AHCI
SATA controller (against the current http://www.kernel.org/hg/linux-2.6 repo
at changeset 56901:02db36c53917, which I believe is 2.6.22-rc1-git7
equivalent).

:-)

>  Thanks.

Thank you.

>  ahci.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e00e1b9..bb94047 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -170,6 +170,7 @@ enum {
>  	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
>  	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
>  	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
> +	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
>  
>  	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> @@ -354,7 +355,8 @@ static const struct ata_port_info ahci_p
>  	/* board_ahci_sb600 */
>  	{
>  		.flags		= AHCI_FLAG_COMMON |
> -				  AHCI_FLAG_IGN_SERR_INTERNAL,
> +				  AHCI_FLAG_IGN_SERR_INTERNAL |
> +				  AHCI_FLAG_32BIT_ONLY,
>  		.pio_mask	= 0x1f, /* pio0-4 */
>  		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
>  		.port_ops	= &ahci_ops,
> @@ -492,6 +494,13 @@ static void ahci_save_initial_config(str
>  	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
>  	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
>  
> +	/* some chips lie about 64bit support */
> +	if ((cap & HOST_CAP_64) && (pi->flags & AHCI_FLAG_32BIT_ONLY)) {
> +		dev_printk(KERN_INFO, &pdev->dev,
> +			   "controller can't do 64bit DMA, forcing 32bit\n");
> +		cap &= ~HOST_CAP_64;
> +	}
> +
>  	/* fixup zero port_map */
>  	if (!port_map) {
>  		port_map = (1 << ahci_nr_ports(hpriv->cap)) - 1;
> 



      ___________________________________________________________________________________
How would you spend $50,000 to create a more sustainable environment in Australia?  Go to Yahoo!7 Answers and share your idea.
http://advision.webevents.yahoo.com/aunz/lifestyle/answers/y7ans-babp_reg.html

