From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.8-rc2] sata_nv.c
Date: Tue, 27 Jul 2004 13:07:07 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41068BBB.3090000@pobox.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95E1@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266434AbUG0RHU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jul 2004 13:07:20 -0400
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F95E1@hqemmail02.nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Chew wrote:
> This patch updates the NVIDIA libata-based SATA driver to support the
> CK804 SATA controller.

Please fix and resubmit:

1) [style] no need to explicitly init first enum to zero:

+typedef enum
+{
+       NFORCE2 = 0,
+       NFORCE3,
+       CK804
+} nv_host_type_t;


2) in Linux (and POSIX), 'struct foo' is preferred over 'foo_t':

+{
+       nv_host_type_t          host_type;
+       unsigned long           host_flags;
+       void                    (*enable_hotplug)(struct ata_probe_ent 
*probe_en
t);
+       void                    (*disable_hotplug)(struct ata_host_set 
*host_set
);
+       void                    (*check_hotplug)(struct ata_host_set 
*host_set);
+
+} nv_host_desc_t;


3) [style] single statements should not be enclosed by braces

+       if (host->host_desc->check_hotplug) {
+               host->host_desc->check_hotplug(host_set);
         }
...
+       if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+               return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+       } else {
+               return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+       }
...
+       // Enable hotplug event interrupts.
+       if (host->host_desc->enable_hotplug) {
+               host->host_desc->enable_hotplug(probe_ent);
+       }

etc.


4) [leak] driver appears to be missing a ->host_free hook, to free your 
nv_host_t structure.

+       host = kmalloc(sizeof(nv_host_t), GFP_KERNEL);


5) [bug] check ioremap return value for failure (==NULL)

+               mmio_base = ioremap(pci_resource_start(pdev, 5),
+                               pci_resource_len(pdev, 5));


6) [leak] probe_ent->mmio_base is not set for the MMIO case, therefore, 
iounmap() is never called for you by ata_pci_remove_one() [libata-core.c].


7) don't use host->scr_addr as a sly way to obtain your base address. 
Use host_set->mmio_base directly (casting from unsigned long if it's PIO 
rather than MMIO).


8) "avoid magic numbers".  Avoid decimal or hexidecimal constants in 
actual code.  Prefer to use macros/enums instead.

+       pci_read_config_byte(probe_ent->pdev, 0x50, &regval);
+       regval |= 0x04;
+       pci_write_config_byte(probe_ent->pdev, 0x50, regval);


