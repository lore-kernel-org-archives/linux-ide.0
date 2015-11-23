From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ahci: don't use MSI when PCI is disabled
Date: Mon, 23 Nov 2015 20:34:30 +0100
Message-ID: <6160865.VIglm5oKj3@wuerfel>
References: <4754092.OYovO36g28@wuerfel> <CAPcyv4gSjWZ7OPqp9fwtc9yGV9g5AKkkCLDnU-F71XsHBgYUQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4gSjWZ7OPqp9fwtc9yGV9g5AKkkCLDnU-F71XsHBgYUQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Ricardo Neri <ricardo.neri@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Monday 23 November 2015 09:25:38 Dan Williams wrote:
> 
> If we had an "static inline ahci_irq_vector(int port)"  helper to
> compile out the struct msix_entry de-reference would that be
> sufficient?

Yes, that is probably a nicer way to do it. We should then also do
something like this:

@@ -2510,7 +2513,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	int irq = hpriv->irq;
 	int rc;
 
-	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
+	if (IS_ENABLED(CONFIG_PCI_MSI) && \
+	    hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
 		rc = ahci_host_activate_multi_irqs(host, sht);
 	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
 		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,

which will let gcc leave out the entire ahci_host_activate_multi_irqs()
function but still flag compile errors in it even if CONFIG_PCI is
disabled.

	Arnd
