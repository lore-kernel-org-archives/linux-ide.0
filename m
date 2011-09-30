From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Fri, 30 Sep 2011 20:55:01 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A16E830DE@ORSMSX101.amr.corp.intel.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
	<CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
	<20110925000345.GD29319@htj.dyndns.org>
	<CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
	<CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
	<CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
	<20110930030913.GE10425@mtj.dyndns.org>
 <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26636 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471Ab1I3UzD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2011 16:55:03 -0400
In-Reply-To: <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>, Tejun Heo <htejun@gmail.com>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

>Looks It is really a nice and clean idea to fix the problem, follows
>the patch, which
>has been tested OK to recognize DVD in machine with device ID 0x1c00
>chipset.
>
>Seth, could you help to test the patch on your machines with other pci
>device
>IDs(0x1c01, 0x1d00, 0x1e00, 0x1e01)?

I've tested it on two of the three platforms.  Everything looks good.  I'll try to get all DeviceIDs tested by the end of the day.

-Seth

>
>diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>index 43107e9..70095be 100644
>--- a/drivers/ata/ata_piix.c
>+++ b/drivers/ata/ata_piix.c
>@@ -113,6 +113,8 @@ enum {
> 	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
> 	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
>
>+	PIIX_FLAG_PIO16		= ATA_FLAG_PIO16,
>+
> 	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
> 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
>
>@@ -147,6 +149,7 @@ enum piix_controller_ids {
> 	ich8m_apple_sata,	/* locks up on second port enable */
> 	tolapai_sata,
> 	piix_pata_vmw,			/* PIIX4 for VMware, spurious
>DMA_ERR */
>+	ich8_sata_snb,
> };
>
> struct piix_map_db {
>@@ -177,6 +180,7 @@ static int piix_sidpr_scr_write(struct ata_link
>*link,
> static int piix_sidpr_set_lpm(struct ata_link *link, enum
>ata_lpm_policy policy,
> 			      unsigned hints);
> static bool piix_irq_check(struct ata_port *ap);
>+static int piix_port_start(struct ata_port *ap);
> #ifdef CONFIG_PM
> static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t
>mesg);
> static int piix_pci_device_resume(struct pci_dev *pdev);
>@@ -298,21 +302,21 @@ static const struct pci_device_id piix_pci_tbl[] =
>{
> 	/* SATA Controller IDE (PCH) */
> 	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
> 	/* SATA Controller IDE (CPT) */
>-	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>+	{ 0x8086, 0x1c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
> 	/* SATA Controller IDE (CPT) */
>-	{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>+	{ 0x8086, 0x1c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
> 	/* SATA Controller IDE (CPT) */
> 	{ 0x8086, 0x1c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> 	/* SATA Controller IDE (CPT) */
> 	{ 0x8086, 0x1c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> 	/* SATA Controller IDE (PBG) */
>-	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>+	{ 0x8086, 0x1d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
> 	/* SATA Controller IDE (PBG) */
> 	{ 0x8086, 0x1d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> 	/* SATA Controller IDE (Panther Point) */
>-	{ 0x8086, 0x1e00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>+	{ 0x8086, 0x1e00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
> 	/* SATA Controller IDE (Panther Point) */
>-	{ 0x8086, 0x1e01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>+	{ 0x8086, 0x1e01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
> 	/* SATA Controller IDE (Panther Point) */
> 	{ 0x8086, 0x1e08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> 	/* SATA Controller IDE (Panther Point) */
>@@ -338,6 +342,7 @@ static struct scsi_host_template piix_sht = {
> static struct ata_port_operations piix_sata_ops = {
> 	.inherits		= &ata_bmdma32_port_ops,
> 	.sff_irq_check		= piix_irq_check,
>+	.port_start		= piix_port_start,
> };
>
> static struct ata_port_operations piix_pata_ops = {
>@@ -478,6 +483,7 @@ static const struct piix_map_db *piix_map_db_table[]
>= {
> 	[ich8_2port_sata]	= &ich8_2port_map_db,
> 	[ich8m_apple_sata]	= &ich8m_apple_map_db,
> 	[tolapai_sata]		= &tolapai_map_db,
>+	[ich8_sata_snb]		= &ich8_map_db,
> };
>
> static struct ata_port_info piix_port_info[] = {
>@@ -606,6 +612,19 @@ static struct ata_port_info piix_port_info[] = {
> 		.port_ops	= &piix_vmw_ops,
> 	},
>
>+	/*
>+	 * some Sandybridge chipsets have broken 32 mode up to now,
>+	 * see https://bugzilla.kernel.org/show_bug.cgi?id=40592
>+	 */
>+	[ich8_sata_snb] =
>+	{
>+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR |
>PIIX_FLAG_PIO16,
>+		.pio_mask	= ATA_PIO4,
>+		.mwdma_mask	= ATA_MWDMA2,
>+		.udma_mask	= ATA_UDMA6,
>+		.port_ops	= &piix_sata_ops,
>+	},
>+
> };
>
> static struct pci_bits piix_enable_bits[] = {
>@@ -649,6 +668,14 @@ static const struct ich_laptop ich_laptop[] = {
> 	{ 0, }
> };
>
>+static int piix_port_start(struct ata_port *ap)
>+{
>+	if (!(ap->flags & PIIX_FLAG_PIO16))
>+		ap->pflags |= ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE;
>+
>+	return ata_bmdma_port_start(ap);
>+}
>+
> /**
>  *	ich_pata_cable_detect - Probe host controller cable detect info
>  *	@ap: Port for which cable detect info is desired
>diff --git a/include/linux/libata.h b/include/linux/libata.h
>index efd6f98..dc68de5 100644
>--- a/include/linux/libata.h
>+++ b/include/linux/libata.h
>@@ -207,6 +207,7 @@ enum {
> 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw
>activity
> 					      * led */
> 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
>+	ATA_FLAG_PIO16		= (1 << 24),  /*16bit PIO */
>
> 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
>
>--
>Ming Lei
