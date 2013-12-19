From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Subject: AHCI driver support for AER error handling?
Date: Thu, 19 Dec 2013 18:03:21 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B70465DB58@DFLE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55219 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab3LSSDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Dec 2013 13:03:23 -0500
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id rBJI3NWJ015455
	for <linux-ide@vger.kernel.org>; Thu, 19 Dec 2013 12:03:23 -0600
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id rBJI3Njl008378
	for <linux-ide@vger.kernel.org>; Thu, 19 Dec 2013 12:03:23 -0600
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

All,

I am new to this mailing list. I got AER driver working for my platform with a pcie root complex driver. However one of my customer is using AHCI over PCI and I find that the driver currently doesn't provide error handler and ignore pci errors. Is this intentional? Could someone provide some input on this? I had to add code to enable error bits (PCI_COMMAND) and call pci_enable_pcie_error_reporting () to enable error reporting to the driver to test the AER driver. But curious why this is currently not supported in the driver. If there is any patch to address, please provide me a link.

Thanks

static struct pci_driver ahci_pci_driver = {
        .name                   = DRV_NAME,
        .id_table               = ahci_pci_tbl,
        .probe                  = ahci_init_one,
        .remove                 = ata_pci_remove_one,
#ifdef CONFIG_PM
        .suspend                = ahci_pci_device_suspend,
        .resume                 = ahci_pci_device_resume,
#endif
};

struct pci_driver {             
        struct list_head node;  
        const char *name;
        const struct pci_device_id *id_table;   /* must be non-NULL for probe to be called */
        int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);   /* New device inserted */
        void (*remove) (struct pci_dev *dev);   /* Device removed (NULL if not a hot-plug capable driver) */
        int  (*suspend) (struct pci_dev *dev, pm_message_t state);      /* Device suspended */
        int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
        int  (*resume_early) (struct pci_dev *dev);
        int  (*resume) (struct pci_dev *dev);                   /* Device woken up */
        void (*shutdown) (struct pci_dev *dev);
        int (*sriov_configure) (struct pci_dev *dev, int num_vfs); /* PF pdev */
        const struct pci_error_handlers *err_handler;
        struct device_driver    driver;
        struct pci_dynids dynids;
};

Murali Karicheri
Linux Kernel, Software Development


