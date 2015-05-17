From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Sun, 17 May 2015 08:33:32 +0100
Message-ID: <20150517073331.GA30529@agordeev.usersys.redhat.com>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430725538-22162-1-git-send-email-rric@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tejun Heo <tj@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, Robert Richter <rrichter@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, May 04, 2015 at 09:45:37AM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch adds generic support for MSI-X interrupts to the SATA PCI
> driver. Only single interrupt support is implemented. Thus, per-port
> interrupts can not yet be enabled.
> 
> The driver now checks the device for the existence of MSI-X and tries
> to enable the interrupt. Otherwise, if a device is not MSI-X capable,
> the initialization is skipped and MSI or intx interrupts are
> configured.

Hi Robert,

Sorry for jumping in late.

I have took a cursory look at your code and have a major concern.

You enable MSI-X for a single chip, but introduce a change to the
generic AHCI code.

In general MSI-X case, what makes you believe that IRQ vectors are
assigned continuously?

(Interface ahci_host_activate() kinda expects a contiguous vector
range, but MSI-X does not guarantee that at all).

Thanks!

> This patch also enables AHCI for Cavium Thunder SoCs that uses MSI-X.
> 
> v2:
>  * determine irq vector from pci_dev->msi_list
> 
> Based on a patch from Sunil Goutham <sgoutham@cavium.com>.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/Kconfig |  1 +
>  drivers/ata/ahci.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1f9a20a3677..2d95bbc0557e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -157,6 +157,7 @@ config ARCH_THUNDER
>  	bool "Cavium Inc. Thunder SoC Family"
>  	help
>  	  This enables support for Cavium's Thunder Family of SoCs.
> +	select SATA_AHCI
>  
>  config ARCH_VEXPRESS
>  	bool "ARMv8 software model (Versatile Express)"
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 49f1e6890587..36c88f6d8490 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -42,6 +42,7 @@
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/gfp.h>
> +#include <linux/msi.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <linux/libata.h>
> @@ -52,6 +53,7 @@
>  
>  enum {
>  	AHCI_PCI_BAR_STA2X11	= 0,
> +	AHCI_PCI_BAR_CAVIUM	= 0,
>  	AHCI_PCI_BAR_ENMOTUS	= 2,
>  	AHCI_PCI_BAR_STANDARD	= 5,
>  };
> @@ -500,6 +502,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* Enmotus */
>  	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
>  
> +	/* Cavium */
> +	{ PCI_DEVICE(0x177d, 0xa01c), .driver_data = board_ahci },
> +
>  	/* Generic, PCI class code for AHCI */
>  	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
> @@ -1202,11 +1207,41 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
>  {}
>  #endif
>  
> -static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> -				struct ahci_host_priv *hpriv)
> +static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
> +			  struct ahci_host_priv *hpriv)
> +{
> +	int rc, nvec;
> +	struct msix_entry entry = {};
> +
> +	/* check if msix is supported */
> +	nvec = pci_msix_vec_count(pdev);
> +	if (nvec <= 0)
> +		return 0;
> +
> +	/* per-port msix interrupts are not supported */
> +	if (n_ports > 1 && nvec >= n_ports)
> +		return -ENOSYS;
> +
> +	/* only enable the first entry (entry.entry = 0) */
> +	rc = pci_enable_msix_exact(pdev, &entry, 1);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 1;
> +}
> +
> +static int __ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> +				  struct ahci_host_priv *hpriv)
>  {
>  	int rc, nvec;
>  
> +	nvec = ahci_init_msix(pdev, n_ports, hpriv);
> +	if (nvec > 0)
> +		return nvec;
> +
> +	if (nvec && nvec != -ENOSYS)
> +		dev_err(&pdev->dev, "failed to enable MSI-X: %d", nvec);
> +
>  	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
>  		goto intx;
>  
> @@ -1250,6 +1285,35 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
>  	return 0;
>  }
>  
> +static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
> +{
> +	struct msi_desc *desc;
> +
> +	list_for_each_entry(desc, &dev->msi_list, list) {
> +		if (desc->msi_attrib.entry_nr == entry)
> +			return desc;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> +				struct ahci_host_priv *hpriv)
> +{
> +	struct msi_desc *desc;
> +
> +	__ahci_init_interrupts(pdev, n_ports, hpriv);
> +
> +	if (!pdev->msix_enabled)
> +		return pdev->irq;
> +
> +	desc = msix_get_desc(pdev, 0);	/* first entry */
> +	if (!desc)
> +		return -ENODEV;
> +
> +	return desc->irq;
> +}
> +
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	unsigned int board_id = ent->driver_data;
> @@ -1260,6 +1324,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	struct ata_host *host;
>  	int n_ports, i, rc;
>  	int ahci_pci_bar = AHCI_PCI_BAR_STANDARD;
> +	int irq;
>  
>  	VPRINTK("ENTER\n");
>  
> @@ -1285,11 +1350,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		dev_info(&pdev->dev,
>  			 "PDC42819 can only drive SATA devices with this driver\n");
>  
> -	/* Both Connext and Enmotus devices use non-standard BARs */
> +	/* Some devices use non-standard BARs */
>  	if (pdev->vendor == PCI_VENDOR_ID_STMICRO && pdev->device == 0xCC06)
>  		ahci_pci_bar = AHCI_PCI_BAR_STA2X11;
>  	else if (pdev->vendor == 0x1c44 && pdev->device == 0x8000)
>  		ahci_pci_bar = AHCI_PCI_BAR_ENMOTUS;
> +	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
> +		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
>  
>  	/*
>  	 * The JMicron chip 361/363 contains one SATA controller and one
> @@ -1411,7 +1478,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 */
>  	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
>  
> -	ahci_init_interrupts(pdev, n_ports, hpriv);
> +	irq = ahci_init_interrupts(pdev, n_ports, hpriv);
> +	if (irq < 0)
> +		return irq;
>  
>  	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
>  	if (!host)
> @@ -1463,7 +1532,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pci_set_master(pdev);
>  
> -	return ahci_host_activate(host, pdev->irq, &ahci_sht);
> +	return ahci_host_activate(host, irq, &ahci_sht);
>  }
>  
>  module_pci_driver(ahci_pci_driver);
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
