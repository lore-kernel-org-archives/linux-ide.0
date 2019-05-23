From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 02/10] ata: ahci: Support per-port interrupts
Date: Thu, 23 May 2019 02:36:25 -0700
Message-ID: <20190523093625.GA26136@infradead.org>
References: <20190521143023.31810-1-miquel.raynal@bootlin.com>
 <20190521143023.31810-3-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190521143023.31810-3-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -434,7 +434,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>  	if (!hpriv)
>  		return -ENOMEM;
>  
> -	hpriv->irq = pdev->irq;
> +	hpriv->irqs[0] = pdev->irq;
>  	hpriv->flags |= (unsigned long)pi.private_data;

Who allocates ->irqs for the non-ahci.c case?

> @@ -95,6 +96,14 @@ static void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>  	}
>  }
>  
> +int ahci_get_per_port_irq_vector(struct ata_host *host, int port)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	return hpriv->irqs[port];
> +}
> +EXPORT_SYMBOL_GPL(ahci_get_per_port_irq_vector);

This function seems a little misnamed.  The only multi-irq support in
the AHCI spec itself is PCIe MSI/MSI-X, which is not handled by this
function, but instead in the PCI layer using pci_irq_vector and the
ahci_get_irq_vector callback in ahci.c.

In fact it seems like this scheme particular to your device config,
why don't we just add a specific libahci-using subdriver for it?  That
would also get rid of the whole ->irq to ->irqs change.
