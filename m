From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 08 May 2007 10:39:14 +0200
Message-ID: <46403732.3000507@gmail.com>
References: <47878.46146.qm@web52606.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030908000304020601080309"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:1179 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934725AbXEHIj1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 04:39:27 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1889654wra
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 01:39:27 -0700 (PDT)
In-Reply-To: <47878.46146.qm@web52606.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

This is a multi-part message in MIME format.
--------------030908000304020601080309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Srihari Vijayaraghavan wrote:
> Even now, when 4 GB of RAM is installed, by default, the SATA drives aren't
> recongnised in Linux, except when I pass mem=4095MB. If I pass mem=4095M, alas
> only 3.6 of RAM is detected under Linux!

Aha, there's the clue.

> Here's the relevant section from dmesg:
>  BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000dfee0000 (usable)
>  BIOS-e820: 00000000dfee0000 - 00000000dfee3000 (ACPI NVS)
>  BIOS-e820: 00000000dfee3000 - 00000000dfef0000 (ACPI data)
>  BIOS-e820: 00000000dfef0000 - 00000000dff00000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
> Entering add_active_range(0, 0, 159) 0 entries of 3200 used
> Entering add_active_range(0, 256, 917216) 1 entries of 3200 used
> end_pfn_map = 1048576
> ...
> Memory: 3570504k/3668864k available (2465k kernel code, 97972k reserved, 1445k
> data, 332k init)
> ...
> 
> Surprisingly, this usable ~3.6 GB equals to the initial two e820 sections
> only. I believe, when mem= parameter is used, the third 'usable' section
> (between 0x100000000 - 0x120000000) isn't used at all by Linux.

Nothing to be surprised about.  You're telling the kernel that the
highest address it can use is 4G - 1, that is, 0xffffffff, so the kernel
correctly ignores any memory above that address.

> I wonder if there is a trick involved in using mem= or memmap= needs to used
> also (if so, I don't know yet how to construct memmap= parameter).

No no, don't use memmap unless you're sure that the BIOS is completely
screwed up and the e820 map is bogus, which BTW isn't true in your case.

> To recap:
>     System is very stable with the new case, power supply & fans
>     SATA drives aren't by default detected when 4 GB of RAM is used
>     SATA drives are detected by default when only 2 GB of RAM is physically
> installed (ie, with both pairs of 2 GB of DIMMs individually)
>     SATA drives are detected when mem=4095M (the reported memory size in the
> BIOS) is used, but only ~3.6 GB of RAM is used (suspected that the final e820
> usable section, though detected, is not used).
> 
> Thank you for your help so far. I really appreciated that.

It just seems sb600 claims that it can do DMA above 4G while it actually
can't.  Can you test the attached patch?

Conke, can you check whether this is caused by the ahci controller
itself or the PCI bridge above it?

Thanks.

-- 
tejun

--------------030908000304020601080309
Content-Type: text/x-patch;
 name="sb600-force-32bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb600-force-32bit.patch"

---
 drivers/ata/ahci.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: tree0/drivers/ata/ahci.c
===================================================================
--- tree0.orig/drivers/ata/ahci.c
+++ tree0/drivers/ata/ahci.c
@@ -170,6 +170,7 @@ enum {
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
 	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
 	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
+	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
 };
 
 struct ahci_cmd_hdr {
@@ -370,7 +371,8 @@ static const struct ata_port_info ahci_p
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_IGN_SERR_INTERNAL,
+				  AHCI_FLAG_IGN_SERR_INTERNAL |
+				  AHCI_FLAG_32BIT_ONLY,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -1579,6 +1581,12 @@ static int ahci_host_init(struct ata_pro
 		probe_ent->n_ports = cap_n_ports;
 
 	using_dac = hpriv->cap & HOST_CAP_64;
+	if (using_dac && (probe_ent->port_flags & AHCI_FLAG_32BIT_ONLY)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "controller can't do 64bit DMA, forcing 32bit\n");
+		using_dac = 0;
+	}
+
 	if (using_dac &&
 	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);

--------------030908000304020601080309--
