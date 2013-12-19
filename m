From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: AHCI driver support for AER error handling?
Date: Thu, 19 Dec 2013 21:00:20 +0100
Message-ID: <3072611.gif6MGBUDL@amdc1032>
References: <3E54258959B69E4282D79E01AB1F32B70465DB58@DFLE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25533 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3LSUAa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Dec 2013 15:00:30 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY200DUYKWTOG50@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Fri, 20 Dec 2013 05:00:29 +0900 (KST)
In-reply-to: <3E54258959B69E4282D79E01AB1F32B70465DB58@DFLE11.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


Hi,

On Thursday, December 19, 2013 06:03:21 PM Karicheri, Muralidharan wrote:
> All,
> 
> I am new to this mailing list. I got AER driver working for my platform with
> a pcie root complex driver. However one of my customer is using AHCI over
> PCI and I find that the driver currently doesn't provide error handler and
> ignore pci errors. Is this intentional? Could someone provide some input on
> this? I had to add code to enable error bits (PCI_COMMAND) and call
> pci_enable_pcie_error_reporting () to enable error reporting to the driver
> to test the AER driver. But curious why this is currently not supported in
> the driver. If there is any patch to address, please provide me a link.

Historically AHCI driver was added before AER support was available in
the kernel so the reason for the lack of AER support in AHCI driver may
just be that nobody ever bothered to add it (of course given that there
are AHCI controllers that actually support AER capability).

I'm not aware of any other patches addressing the issue so (once ready)
please post the results of your work to the list.

PS1 Documentation/PCI/pcieaer-howto.txt contains useful pointers on how
to test AER support by injecting errors (you probably know this already).

PS2 Please wrap your messages to 80 columns or less.  Thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks
> 
> static struct pci_driver ahci_pci_driver = {
>         .name                   = DRV_NAME,
>         .id_table               = ahci_pci_tbl,
>         .probe                  = ahci_init_one,
>         .remove                 = ata_pci_remove_one,
> #ifdef CONFIG_PM
>         .suspend                = ahci_pci_device_suspend,
>         .resume                 = ahci_pci_device_resume,
> #endif
> };
> 
> struct pci_driver {             
>         struct list_head node;  
>         const char *name;
>         const struct pci_device_id *id_table;   /* must be non-NULL for probe to be called */
>         int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);   /* New device inserted */
>         void (*remove) (struct pci_dev *dev);   /* Device removed (NULL if not a hot-plug capable driver) */
>         int  (*suspend) (struct pci_dev *dev, pm_message_t state);      /* Device suspended */
>         int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
>         int  (*resume_early) (struct pci_dev *dev);
>         int  (*resume) (struct pci_dev *dev);                   /* Device woken up */
>         void (*shutdown) (struct pci_dev *dev);
>         int (*sriov_configure) (struct pci_dev *dev, int num_vfs); /* PF pdev */
>         const struct pci_error_handlers *err_handler;
>         struct device_driver    driver;
>         struct pci_dynids dynids;
> };
> 
> Murali Karicheri
> Linux Kernel, Software Development

