From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
Date: Tue, 08 Apr 2008 15:45:35 +0400
Message-ID: <47FB5ADF.20608@ru.mvista.com>
References: <200804072027.17520.sshtylyov@ru.mvista.com> <200804072246.40223.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:39391 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752221AbYDHLqR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 07:46:17 -0400
In-Reply-To: <200804072246.40223.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>This function didn't actually check if a given BAR is in I/O space because of
>>using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test the resource
>>flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() check the
>>results failing if necessary, and move the printk() call to the failure path.

> This change is OK in itself but I worry that ide_pci_check_iomem() may now
> return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted in MEM
> resources always surviving ide_pci_check_iomem() calls before the fix) for
> some host drivers (siimage, scc_pata...) resulting in failed initialization.

    The SiI chips do have normal I/O resources at BAR0..BAR3. As for scc_pata, 
the control should not even get there because BAR0..BAR3 are *not* IDE 
command/control block bases on this chip (BAR0/1 are control/DMA bases if you 
look into setup_mmio_scc()) but they are treated as such by the code 
immediately following ide_pci_check_iomem() calls in ide_hwif_configure(), 
i.e. we might have an error here. The same can be said about the PowerMAC 
driver which has all its MMIO registers at BAR0.

> How's about removing this dead/broken function instead for now?

    If we indeed have a MMIO problem here, it's not in this function but in 
its callers.

> Thanks,
> Bart

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>The patch is against today's Linus' tree...

>> drivers/ide/setup-pci.c |   23 ++++++++++++-----------
>> 1 files changed, 12 insertions(+), 11 deletions(-)

>>Index: linux-2.6/drivers/ide/setup-pci.c
>>===================================================================
>>--- linux-2.6.orig/drivers/ide/setup-pci.c
>>+++ linux-2.6/drivers/ide/setup-pci.c
>>@@ -312,11 +312,12 @@ static int ide_pci_configure(struct pci_
>>  *	@d: IDE port info
>>  *	@bar: BAR number
>>  *
>>- *	Checks if a BAR is configured and points to MMIO space. If so
>>- *	print an error and return an error code. Otherwise return 0
>>+ *	Checks if a BAR is configured and points to MMIO space. If so,
>>+ *	return an error code. Otherwise return 0
>>  */
>> 
>>-static int ide_pci_check_iomem(struct pci_dev *dev, const struct ide_port_info *d, int bar)
>>+static int ide_pci_check_iomem(struct pci_dev *dev, const struct ide_port_info *d,
>>+			       int bar)
>> {
>> 	ulong flags = pci_resource_flags(dev, bar);
>> 	
>>@@ -324,14 +325,11 @@ static int ide_pci_check_iomem(struct pc
>> 	if (!flags || pci_resource_len(dev, bar) == 0)
>> 		return 0;
>> 
>>-	/* I/O space */		
>>-	if(flags & PCI_BASE_ADDRESS_IO_MASK)
>>+	/* I/O space */
>>+	if (flags & IORESOURCE_IO)
>> 		return 0;
>> 		
>> 	/* Bad */
>>-	printk(KERN_ERR "%s: IO baseregs (BIOS) are reported "
>>-			"as MEM, report to "
>>-			"<andre@linux-ide.org>.\n", d->name);
>> 	return -EINVAL;
>> }
>> 
>>@@ -360,9 +358,12 @@ static ide_hwif_t *ide_hwif_configure(st
>> 	struct hw_regs_s hw;
>> 
>> 	if ((d->host_flags & IDE_HFLAG_ISA_PORTS) == 0) {
>>-		/*  Possibly we should fail if these checks report true */
>>-		ide_pci_check_iomem(dev, d, 2*port);
>>-		ide_pci_check_iomem(dev, d, 2*port+1);
>>+		if (ide_pci_check_iomem(dev, d, 2 * port) ||
>>+		    ide_pci_check_iomem(dev, d, 2 * port + 1)) {
>>+			printk(KERN_ERR "%s: I/O baseregs (BIOS) are reported "
>>+					"as MEM for port %d!\n", d->name, port);
>>+			return NULL;
>>+		}
>>  
>> 		ctl  = pci_resource_start(dev, 2*port+1);
>> 		base = pci_resource_start(dev, 2*port);

    Above's the code that I was talking about...

WBR, Sergei
