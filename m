From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3] ahci: move ahci_sb600_softreset to libahci.c and rename
 it
Date: Fri, 17 Jun 2011 15:34:26 +0400
Message-ID: <4DFB3BC2.3070706@ru.mvista.com>
References: <20110615101436.GT8141@htj.dyndns.org> <1308307158-1796-1-git-send-email-yuanlmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308307158-1796-1-git-send-email-yuanlmm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuan-Hsin Chen <yuanlmm@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org, Yuan-Hsin Chen <yhchen@faraday-tech.com>
List-Id: linux-ide@vger.kernel.org

Hello.

On 17-06-2011 14:39, Yuan-Hsin Chen wrote:

> From: Yuan-Hsin Chen<yhchen@faraday-tech.com>

> ahci_sb600_softreset was in ahci.c. This function is used
> to fix soft reset failure and renames as ahci_pmp_softreset
> in libahci.c.

> Signed-off-by: Yuan-Hsin Chen<yhchen@faraday-tech.com>
> ---
> v3:
> Move ahci_sb600_softreset to libahci.c and rename it.
> Add ahci_pmp_ops to libahci.c
> Add following stuff in your platform dependent code to use ahci_pmp_ops

> #include <linux/ahci_platform.h>
> #include<../../../drivers/ata/ahci.h>
>
> static struct ata_port_info ftsata100_pi =
> 	.flags = AHCI_FLAG_COMMON,
> 	.pio_mask = ATA_PIO4,
> 	.udma_mask = ATA_UDMA6,
> 	.port_ops = &ahci_pmp_ops,
> };
>
> static struct ahci_platform_data ftsata100_pdata = {
> 	.ata_port_info =&ftsata100_pi,
> };
>
> static struct platform_device ftsata100_device = {
> 	...
>          .dev	= {
> 		...
>                  .platform_data =&ftsata100_pdata,
>          },
> };

>   drivers/ata/ahci.c    |   55 +--------------------------------------------
>   drivers/ata/ahci.h    |    1 +
>   drivers/ata/libahci.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+), 53 deletions(-)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 71afe03..c67f621 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
[...]
> @@ -106,8 +104,8 @@ static struct ata_port_operations ahci_p5wdh_ops = {
>
>   static struct ata_port_operations ahci_sb600_ops = {
>   	.inherits		=&ahci_ops,
> -	.softreset		= ahci_sb600_softreset,
> -	.pmp_softreset		= ahci_sb600_softreset,
> +	.softreset		= ahci_pmp_softreset,
> +	.pmp_softreset		= ahci_pmp_softreset,
>   };
>
>   #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
[...]
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index d38c40f..c4cbee9 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -82,6 +82,8 @@ static void ahci_pmp_attach(struct ata_port *ap);
>   static void ahci_pmp_detach(struct ata_port *ap);
>   static int ahci_softreset(struct ata_link *link, unsigned int *class,
>   			  unsigned long deadline);
> +static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
> +			  unsigned long deadline);

    How come it's 'static' when you use it in ahci.c?

>   static int ahci_hardreset(struct ata_link *link, unsigned int *class,
>   			  unsigned long deadline);
>   static void ahci_postreset(struct ata_link *link, unsigned int *class);
[...]
> @@ -1329,6 +1338,56 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
>   }
>   EXPORT_SYMBOL_GPL(ahci_do_softreset);
>
> +static int ahci_pmp_check_ready(struct ata_link *link)
> +{
> +	void __iomem *port_mmio = ahci_port_base(link->ap);
> +	u8 status = readl(port_mmio + PORT_TFDATA)&  0xFF;
> +	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
> +
> +	/*
> +	 * There is no need to check TFDATA if BAD PMP is found due to HW bug,
> +	 * which can save timeout delay.
> +	 */
> +	if (irq_status&  PORT_IRQ_BAD_PMP)
> +		return -EIO;
> +
> +	printk("%s:TFT 0x%x\n", __func__, status);

    printk() should have a logging facility. Here you should have probably 
used pr_debug()...

WBR, Sergei
