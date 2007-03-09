From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [git patches] libata (and devres) fixes
Date: Fri, 9 Mar 2007 22:24:42 +0100
Message-ID: <b637ec0b0703091324q7f15fddbpc8c24b4e1131e3f4@mail.gmail.com>
References: <20070309163148.GA12848@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965822AbXCIVYt@vger.kernel.org>
In-Reply-To: <20070309163148.GA12848@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-ide@vger.kernel.org

Hi.
This update gives a new warning:

libata version 2.20 loaded.
ata_piix 0000:00:1f.1: version 2.10ac1
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x000118c0 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x000118c8 irq 15
scsi0 : ata_piix
ata1.00: ATA-6: TOSHIBA MK8025GAS, KA024A, max UDMA/100
ata1.00: 156301488 sectors, multi 16: LBA
ata1.01: ATAPI, max MWDMA2
ata1.00: configured for UDMA/33
ata1.01: configured for MWDMA2
scsi1 : ata_piix
ata2: port disabled. ignoring.
ata2: reset failed, giving up    <--- THIS IS NEW.

However, I think it's just bogus as there is ata2 is disabled on this laptop.

Regards,
Fabio





On 3/9/07, Jeff Garzik <jeff@garzik.org> wrote:
>
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
>
> to receive the following updates:
>
>  drivers/ata/ata_piix.c    |   11 +++--------
>  drivers/ata/libata-core.c |   19 ++++++++++++-------
>  drivers/ata/sata_nv.c     |    8 +++++++-
>  drivers/base/core.c       |    7 +++++++
>  4 files changed, 29 insertions(+), 16 deletions(-)
>
> Alan Cox (1):
>       ata_piix: Remove ugly layering violation
>
> Petr Vandrovec (1):
>       Fix simplex adapters with libata
>
> Robert Hancock (1):
>       sata_nv: revert use of notifiers for now
>
> Tejun Heo (2):
>       libata: fix ata_host_release() free order
>       devres: release resources on device_del()
>
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index dc42ba1..b952c58 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -93,7 +93,7 @@
>  #include <linux/libata.h>
>
>  #define DRV_NAME       "ata_piix"
> -#define DRV_VERSION    "2.10"
> +#define DRV_VERSION    "2.10ac1"
>
>  enum {
>         PIIX_IOCFG              = 0x54, /* IDE I/O configuration register */
> @@ -667,14 +667,9 @@ static int ich_pata_prereset(struct ata_port *ap)
>  {
>         struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>
> -       if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
> -               ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
> -               ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
> -               return 0;
> -       }
> -
> +       if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
> +               return -ENOENT;
>         ich_pata_cbl_detect(ap);
> -
>         return ata_std_prereset(ap);
>  }
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index dc362fa..3c1f883 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3455,7 +3455,8 @@ static void ata_dev_xfermask(struct ata_device *dev)
>                                "device is on DMA blacklist, disabling DMA\n");
>         }
>
> -       if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed != ap) {
> +       if ((host->flags & ATA_HOST_SIMPLEX) &&
> +            host->simplex_claimed && host->simplex_claimed != ap) {
>                 xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>                 ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
>                                "other device, disabling DMA\n");
> @@ -5684,18 +5685,22 @@ static void ata_host_release(struct device *gendev, void *res)
>         for (i = 0; i < host->n_ports; i++) {
>                 struct ata_port *ap = host->ports[i];
>
> -               if (!ap)
> -                       continue;
> -
> -               if (ap->ops->port_stop)
> +               if (ap && ap->ops->port_stop)
>                         ap->ops->port_stop(ap);
> -
> -               scsi_host_put(ap->scsi_host);
>         }
>
>         if (host->ops->host_stop)
>                 host->ops->host_stop(host);
>
> +       for (i = 0; i < host->n_ports; i++) {
> +               struct ata_port *ap = host->ports[i];
> +
> +               if (ap)
> +                       scsi_host_put(ap->scsi_host);
> +
> +               host->ports[i] = NULL;
> +       }
> +
>         dev_set_drvdata(gendev, NULL);
>  }
>
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 388d07f..9d9670a 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -874,8 +874,14 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
>
>                         if (status & (NV_ADMA_STAT_DONE |
>                                       NV_ADMA_STAT_CPBERR)) {
> -                               u32 check_commands = notifier | notifier_error;
> +                               u32 check_commands;
>                                 int pos, error = 0;
> +
> +                               if(ata_tag_valid(ap->active_tag))
> +                                       check_commands = 1 << ap->active_tag;
> +                               else
> +                                       check_commands = ap->sactive;
> +
>                                 /** Check CPBs for completed commands */
>                                 while ((pos = ffs(check_commands)) && !error) {
>                                         pos--;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index cf2a398..89ebe36 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -787,6 +787,13 @@ void device_del(struct device * dev)
>         device_remove_attrs(dev);
>         bus_remove_device(dev);
>
> +       /*
> +        * Some platform devices are driven without driver attached
> +        * and managed resources may have been acquired.  Make sure
> +        * all resources are released.
> +        */
> +       devres_release_all(dev);
> +
>         /* Notify the platform of the removal, in case they
>          * need to do anything...
>          */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
