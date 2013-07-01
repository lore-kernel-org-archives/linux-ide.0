From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms
Date: Mon, 1 Jul 2013 16:57:35 +0530
Message-ID: <CAGxe1ZEHWQUXmjgmGGkpy3wgxoS8ti0-eYZPHkQKzjD9pWqZ0Q@mail.gmail.com>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
	<1372672975-2997-5-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:49570 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab3GAL1f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 07:27:35 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so1951622qak.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2013 04:27:35 -0700 (PDT)
In-Reply-To: <1372672975-2997-5-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Hello Richard,

Instead of writing a separate driver for the changes you mentioned in
the commit message. you can just add those changes to
the platform data (pdata-> init).

On 1 July 2013 15:32, Richard Zhu <richard.zhuhongxing@gmail.com> wrote:
> imx6q contains one Synopsys AHCI SATA controller,
> But it can't shares ahci_platform driver with other
> controllers.
> Because there are some misalignments of the bits
> definitions of the HBA registers and the Vendor
> Specific registers
>  - CAP_SSS(bit20) of the HOST_CAP is writable, default
>  value is '0', should be configured to be '1'
>  - bit0 (only one AHCI SATA port on imx6q) of the
>  HOST_PORTS_IMPL should be set to be '1'.(default 0)
>  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
>  should be configured regarding to the frequency of AHB
>  bus clock.
>
> Setup its own ahci sata driver, enable the imx6q ahci
> sata support, and update the ahci sata binding document.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |    2 +-
>  drivers/ata/Kconfig                                |    8 +
>  drivers/ata/Makefile                               |    1 +
>  drivers/ata/sata_imx.c                             |  349 ++++++++++++++++++++
>  4 files changed, 359 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ata/sata_imx.c
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index b519f9b..e252620 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -4,7 +4,7 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
>  Each SATA controller should have its own node.
>
>  Required properties:
> -- compatible        : compatible list, contains "calxeda,hb-ahci" or "snps,spear-ahci"
> +- compatible        : compatible list, contains "calxeda,hb-ahci", "snps,spear-ahci" or "snps, imx-ahci"
>  - interrupts        : <interrupt mapping for SATA IRQ>
>  - reg               : <registers mapping>
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index a5a3ebc..893fa0b 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -236,6 +236,14 @@ config SATA_HIGHBANK
>
>           If unsure, say N.
>
> +config SATA_IMX
> +       tristate "Freescale iMX AHCI SATA support"
> +       help
> +         This option enables support for the Freescale iMX SoC's
> +         onboard AHCI SATA.
> +
> +         If unsure, say N.
> +
>  config SATA_MV
>         tristate "Marvell SATA support"
>         help
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index c04d0fd..c40b328 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SATA_INIC162X)   += sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)       += sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)         += sata_dwc_460ex.o
>  obj-$(CONFIG_SATA_HIGHBANK)    += sata_highbank.o libahci.o
> +obj-$(CONFIG_SATA_IMX)         += sata_imx.o libahci.o
>
>  # SFF w/ custom DMA
>  obj-$(CONFIG_PDC_ADMA)         += pdc_adma.o
> diff --git a/drivers/ata/sata_imx.c b/drivers/ata/sata_imx.c
> new file mode 100644
> index 0000000..2be92e8
> --- /dev/null
> +++ b/drivers/ata/sata_imx.c
> @@ -0,0 +1,349 @@
> +/*
> + * Freescale IMX AHCI SATA platform driver
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/kernel.h>
> +#include <linux/gfp.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/libata.h>
> +#include <linux/ahci_platform.h>
> +#include "ahci.h"
> +
> +enum {
> +       HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
> +};
> +
> +static void ahci_imx_host_stop(struct ata_host *host);
> +
> +static struct ata_port_operations ahci_imx_platform_ops = {
> +       .inherits       = &ahci_ops,
> +       .host_stop      = ahci_imx_host_stop,
> +};
> +
> +static const struct ata_port_info ahci_imx_port_info = {
> +       .flags          = AHCI_FLAG_COMMON,
> +       .pio_mask       = ATA_PIO4,
> +       .udma_mask      = ATA_UDMA6,
> +       .port_ops       = &ahci_imx_platform_ops,
> +};
> +
> +static struct scsi_host_template ahci_imx_platform_sht = {
> +       AHCI_SHT("sata_imx"),
> +};
> +
> +/*
> + * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
> + * and IP vendor specific register HOST_TIMER1MS.
> + *
> + * Configure CAP_SSS (support stagered spin up).
> + * Implement the port0.
> + * Get the ahb clock rate, and configure the TIMER1MS register.
> + */
> +static int imx_sata_init(void __iomem *mmio)
> +{
> +       int ret;
> +       struct clk *ahb_clk;
> +
> +       ret = readl(mmio + HOST_CAP);
> +       if (!(ret & HOST_CAP_SSS))
> +               writel(ret |= HOST_CAP_SSS, mmio + HOST_CAP);
> +       ret = readl(mmio + HOST_PORTS_IMPL);
> +       if (!(ret & 0x1))
> +               writel((ret | 0x1), mmio + HOST_PORTS_IMPL);
> +       ahb_clk = clk_get_sys(NULL, "ahb");
> +       if (IS_ERR(ahb_clk)) {
> +               pr_err("no ahb clock.\n");
> +               ret = PTR_ERR(ahb_clk);
> +               return ret;
> +       }
> +       ret = clk_get_rate(ahb_clk) / 1000;
> +       clk_put(ahb_clk);
> +       writel(ret, mmio + HOST_TIMER1MS);
> +
> +       return ret;
> +}
> +
> +static int ahci_imx_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +       struct ata_port_info pi = ahci_imx_port_info;
> +       const struct ata_port_info *ppi[] = { &pi, NULL };
> +       struct ahci_host_priv *hpriv;
> +       struct ata_host *host;
> +       struct resource *mem;
> +       int irq;
> +       int n_ports;
> +       int i;
> +       int rc;
> +
> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!mem) {
> +               dev_err(dev, "no mmio space\n");
> +               return -EINVAL;
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq <= 0) {
> +               dev_err(dev, "no irq\n");
> +               return -EINVAL;
> +       }
> +
> +       if (pdata && pdata->ata_port_info)
> +               pi = *pdata->ata_port_info;
> +
> +       hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
> +       if (!hpriv) {
> +               dev_err(dev, "can't alloc ahci_host_priv\n");
> +               return -ENOMEM;
> +       }
> +
> +       hpriv->flags |= (unsigned long)pi.private_data;
> +
> +       hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
> +       if (!hpriv->mmio) {
> +               dev_err(dev, "can't map %pR\n", mem);
> +               return -ENOMEM;
> +       }
> +
> +       hpriv->clk = clk_get(dev, NULL);
> +       if (IS_ERR(hpriv->clk)) {
> +               dev_err(dev, "can't get clock\n");
> +       } else {
> +               rc = clk_prepare_enable(hpriv->clk);
> +               if (rc) {
> +                       dev_err(dev, "clock prepare enable failed");
> +                       goto free_clk;
> +               }
> +       }
> +
> +       /*
> +        * Some platforms might need to prepare for mmio region access,
> +        * which could be done in the following init call. So, the mmio
> +        * region shouldn't be accessed before init (if provided) has
> +        * returned successfully.
> +        */
> +       if (pdata && pdata->init) {
> +               rc = pdata->init(dev, hpriv->mmio);
> +               if (rc)
> +                       goto disable_unprepare_clk;
> +       }
> +
> +       rc = imx_sata_init(hpriv->mmio);
> +       if (rc < 0)
> +               goto pdata_exit;
> +
> +       ahci_save_initial_config(dev, hpriv,
> +               pdata ? pdata->force_port_map : 0,
> +               pdata ? pdata->mask_port_map  : 0);
> +
> +       /* prepare host */
> +       if (hpriv->cap & HOST_CAP_NCQ)
> +               pi.flags |= ATA_FLAG_NCQ;
> +
> +       if (hpriv->cap & HOST_CAP_PMP)
> +               pi.flags |= ATA_FLAG_PMP;
> +
> +       ahci_set_em_messages(hpriv, &pi);
> +
> +       /* CAP.NP sometimes indicate the index of the last enabled
> +        * port, at other times, that of the last possible port, so
> +        * determining the maximum port number requires looking at
> +        * both CAP.NP and port_map.
> +        */
> +       n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
> +
> +       host = ata_host_alloc_pinfo(dev, ppi, n_ports);
> +       if (!host) {
> +               rc = -ENOMEM;
> +               goto pdata_exit;
> +       }
> +
> +       host->private_data = hpriv;
> +
> +       if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> +               host->flags |= ATA_HOST_PARALLEL_SCAN;
> +       else
> +               dev_info(dev, "ahci: SSS flag set, parallel bus scan disabled\n");
> +
> +       if (pi.flags & ATA_FLAG_EM)
> +               ahci_reset_em(host);
> +
> +       for (i = 0; i < host->n_ports; i++) {
> +               struct ata_port *ap = host->ports[i];
> +
> +               ata_port_desc(ap, "mmio %pR", mem);
> +               ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
> +
> +               /* set enclosure management message type */
> +               if (ap->flags & ATA_FLAG_EM)
> +                       ap->em_message_type = hpriv->em_msg_type;
> +
> +               /* disabled/not-implemented port */
> +               if (!(hpriv->port_map & (1 << i)))
> +                       ap->ops = &ata_dummy_port_ops;
> +       }
> +
> +       rc = ahci_reset_controller(host);
> +       if (rc)
> +               goto pdata_exit;
> +
> +       ahci_init_controller(host);
> +       ahci_print_info(host, "platform");
> +
> +       rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
> +                              &ahci_imx_platform_sht);
> +       if (rc)
> +               goto pdata_exit;
> +
> +       return 0;
> +pdata_exit:
> +       if (pdata && pdata->exit)
> +               pdata->exit(dev);
> +disable_unprepare_clk:
> +       if (!IS_ERR(hpriv->clk))
> +               clk_disable_unprepare(hpriv->clk);
> +free_clk:
> +       if (!IS_ERR(hpriv->clk))
> +               clk_put(hpriv->clk);
> +       return rc;
> +}
> +
> +static void ahci_imx_host_stop(struct ata_host *host)
> +{
> +       struct device *dev = host->dev;
> +       struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +       struct ahci_host_priv *hpriv = host->private_data;
> +
> +       if (pdata && pdata->exit)
> +               pdata->exit(dev);
> +
> +       if (!IS_ERR(hpriv->clk)) {
> +               clk_disable_unprepare(hpriv->clk);
> +               clk_put(hpriv->clk);
> +       }
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ahci_imx_suspend(struct device *dev)
> +{
> +       struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +       struct ata_host *host = dev_get_drvdata(dev);
> +       struct ahci_host_priv *hpriv = host->private_data;
> +       void __iomem *mmio = hpriv->mmio;
> +       u32 ctl;
> +       int rc;
> +
> +       if (hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
> +               dev_err(dev, "firmware update required for suspend/resume\n");
> +               return -EIO;
> +       }
> +
> +       /*
> +        * AHCI spec rev1.1 section 8.3.3:
> +        * Software must disable interrupts prior to requesting a
> +        * transition of the HBA to D3 state.
> +        */
> +       ctl = readl(mmio + HOST_CTL);
> +       ctl &= ~HOST_IRQ_EN;
> +       writel(ctl, mmio + HOST_CTL);
> +       readl(mmio + HOST_CTL); /* flush */
> +
> +       rc = ata_host_suspend(host, PMSG_SUSPEND);
> +       if (rc)
> +               return rc;
> +
> +       if (pdata && pdata->suspend)
> +               return pdata->suspend(dev);
> +
> +       if (!IS_ERR(hpriv->clk))
> +               clk_disable_unprepare(hpriv->clk);
> +
> +       return 0;
> +}
> +
> +static int ahci_imx_resume(struct device *dev)
> +{
> +       struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +       struct ata_host *host = dev_get_drvdata(dev);
> +       struct ahci_host_priv *hpriv = host->private_data;
> +       int rc;
> +
> +       if (!IS_ERR(hpriv->clk)) {
> +               rc = clk_prepare_enable(hpriv->clk);
> +               if (rc) {
> +                       dev_err(dev, "clock prepare enable failed");
> +                       return rc;
> +               }
> +       }
> +
> +       if (pdata && pdata->resume) {
> +               rc = pdata->resume(dev);
> +               if (rc)
> +                       goto disable_unprepare_clk;
> +       }
> +
> +       if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
> +               rc = ahci_reset_controller(host);
> +               if (rc)
> +                       goto disable_unprepare_clk;
> +
> +               ahci_init_controller(host);
> +       }
> +
> +       ata_host_resume(host);
> +
> +       return 0;
> +
> +disable_unprepare_clk:
> +       if (!IS_ERR(hpriv->clk))
> +               clk_disable_unprepare(hpriv->clk);
> +
> +       return rc;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, ahci_imx_suspend, ahci_imx_resume);
> +
> +static const struct of_device_id ahci_of_match[] = {
> +       { .compatible = "snps,imx-ahci", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
> +static struct platform_driver ahci_imx_driver = {
> +       .probe = ahci_imx_probe,
> +       .remove = ata_platform_remove_one,
> +       .driver = {
> +               .name = "imx-ahci",
> +               .owner = THIS_MODULE,
> +               .of_match_table = ahci_of_match,
> +               .pm = &ahci_imx_pm_ops,
> +       },
> +};
> +module_platform_driver(ahci_imx_driver);
> +
> +MODULE_DESCRIPTION("FREESCALE IMX AHCI SATA platform driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("sata:imx");
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
