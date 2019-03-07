From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 01/10] ata: libahci: Ensure the host interrupt status
 bits are cleared
Date: Thu, 7 Mar 2019 16:25:02 +0000
Message-ID: <57c2d67c-7411-0fca-933e-a76379f3165c@arm.com>
References: <20190306102146.13005-1-miquel.raynal@bootlin.com>
 <20190306102146.13005-2-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190306102146.13005-2-miquel.raynal@bootlin.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 06/03/2019 10:21, Miquel Raynal wrote:
> ahci_multi_irqs_intr_hard() is going to be used as interrupt handler
> to support SATA per-port interrupts. The current logic is to check and
> clear the SATA port interrupt status register only. To avoid spurious
> IRQs and interrupt storms, it will be needed to clear the port
> interrupt bit in the host interrupt status register as well.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/ata/libahci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index b5f57c69c487..66d4906a5013 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1912,7 +1912,10 @@ static void ahci_port_intr(struct ata_port *ap)
>  static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
>  {
>  	struct ata_port *ap = dev_instance;
> +	struct ata_host *host = ap->host;
> +	struct ahci_host_priv *hpriv = host->private_data;
>  	void __iomem *port_mmio = ahci_port_base(ap);
> +	void __iomem *mmio = hpriv->mmio;
>  	u32 status;
>  
>  	VPRINTK("ENTER\n");
> @@ -1924,6 +1927,10 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
>  	ahci_handle_port_interrupt(ap, port_mmio, status);
>  	spin_unlock(ap->lock);
>  
> +	spin_lock(&host->lock);
> +	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
> +	spin_unlock(&host->lock);

What's not clear here is under which circumstances this is required.
This write should be atomic (if it isn't, you have bigger problems), and
it is at best unclear what you're avoiding by taking the host lock.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
