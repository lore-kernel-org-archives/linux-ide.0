From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
Date: Wed, 17 Feb 2016 17:12:04 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602171710350.19512@nanos>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tchalamarla@caviumnetworks.com
Cc: tj@kernel.org, stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Tue, 16 Feb 2016, tchalamarla@caviumnetworks.com wrote:
> +#ifdef CONFIG_ARM64
> +/* Due to ERRATA#22536, ThunderX need to handle
> + * HOST_IRQ_STAT differently.
> + * Work around is to make sure all pending IRQs
> + * are served before leaving handler
> + */
> +static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
> +{
> +	struct ata_host *host = dev_instance;
> +	struct ahci_host_priv *hpriv;
> +	unsigned int rc = 0;
> +	void __iomem *mmio;
> +	u32 irq_stat, irq_masked;
> +	unsigned int handled = 1;
> +
> +	VPRINTK("ENTER\n");

Come on. This VPRINK stuff is really pointless. Enable irq tracepoints, they
already track the enter/exit of interrupt handlers ....

Thanks,

	tglx
