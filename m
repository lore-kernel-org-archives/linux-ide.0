From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Wed, 22 Oct 2008 13:23:46 -0700
Message-ID: <20081022132346.38fbc84a@infradead.org>
References: <20081020214830.1586704c@infradead.org>
	<48FDA8BF.20206@ru.mvista.com>
	<48FF6595.5040203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35097 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121AbYJVUX3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 16:23:29 -0400
In-Reply-To: <48FF6595.5040203@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 22 Oct 2008 21:40:37 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello, I wrote:
> 
> >> Use the newly introduced pci_ioremap_bar() function in drivers/ide.
> >> pci_ioremap_bar() just takes a pci device and a bar number, with
> >> the goal of making it really hard to get wrong, while also having
> >> a central place to stick sanity checks.
> 
> >> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> > Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>     No, I'm takign back my ACK.
>     Since the patch intends to address all drivers/ide/, it's clearly
> no compolete -- siimage.c and scc_pata.c beg for the alike change (it
> will even permit to kill 4 local variables in the latter driver).

like this ?

>From 3f88a6936f7802a5d4af6c54a1ef353d14ff1ab2 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Wed, 22 Oct 2008 13:21:07 -0700
Subject: [PATCH] ide: two more pci_ioremap_bar() conversions

based on suggestion from Sergei Shtylyov, there are two more places
where using pci_ioremap_bar() makes sense.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ide/pci/scc_pata.c |   10 ++++------
 drivers/ide/pci/siimage.c  |    2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
index 9ce1d80..b4be295 100644
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -536,10 +536,6 @@ static u8 scc_udma_filter(ide_drive_t *drive)
 
 static int setup_mmio_scc (struct pci_dev *dev, const char *name)
 {
-	unsigned long ctl_base = pci_resource_start(dev, 0);
-	unsigned long dma_base = pci_resource_start(dev, 1);
-	unsigned long ctl_size = pci_resource_len(dev, 0);
-	unsigned long dma_size = pci_resource_len(dev, 1);
 	void __iomem *ctl_addr;
 	void __iomem *dma_addr;
 	int i, ret;
@@ -557,10 +553,12 @@ static int setup_mmio_scc (struct pci_dev *dev, const char *name)
 		return ret;
 	}
 
-	if ((ctl_addr = ioremap(ctl_base, ctl_size)) == NULL)
+	ctl_addr = pci_ioremap_bar(dev, 0);
+	if (!ctl_addr)
 		goto fail_0;
 
-	if ((dma_addr = ioremap(dma_base, dma_size)) == NULL)
+	dma_addr = pci_ioremap_bar(dev, 1);
+	if (!dma_addr)
 		goto fail_1;
 
 	pci_set_master(dev);
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index eb4faf9..c3107df 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -784,7 +784,7 @@ static int __devinit siimage_init_one(struct pci_dev *dev,
 			printk(KERN_WARNING DRV_NAME " %s: MMIO ports not "
 				"available\n", pci_name(dev));
 		} else {
-			ioaddr = ioremap(bar5, barsize);
+			ioaddr = pci_ioremap_bar(dev, 5);
 			if (ioaddr == NULL)
 				release_mem_region(bar5, barsize);
 		}
-- 
1.5.5.1



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
