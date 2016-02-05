From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
Date: Fri, 5 Feb 2016 11:41:22 -0500
Message-ID: <20160205164122.GB4401@htj.duckdns.org>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
 <1454620826-22554-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1454620826-22554-2-git-send-email-stripathi@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: suman Tripathi <stripathi@apm.com>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com, arnd@arndb.de, jcm@redhat.com, patches@apm.com, linux-ide@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Fri, Feb 05, 2016 at 02:50:24AM +0530, suman Tripathi wrote:
...
> @@ -2504,15 +2505,28 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int irq = hpriv->irq;
>  	int rc;
> +	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
> 
> +	ahci_irq_handler = hpriv->ahci_irq_intr;
> +
> +	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
> +		if (!ahci_irq_handler)
> +			rc = ahci_host_activate_multi_irqs(host, sht);
> +		else
> +			dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
> +				 and custom irq handler implemented\n");
> +
> +	} else {
> +		if (!ahci_irq_handler) {
> +			ahci_irq_handler = (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
> +			 		    ahci_single_edge_irq_intr :
> +					    ahci_single_level_irq_intr);
> +		}
> +	}

I wrote this before but can't we do this in save_initial_config the
same way ->start_engine override is handled?

-- 
tejun
