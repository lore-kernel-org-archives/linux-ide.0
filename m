From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH #upstream-fixes] libata: don't use 32bit PIO for small transfers
Date: Wed, 14 Sep 2011 15:44:43 +0800
Message-ID: <CACVXFVO0LzxSj=7Q054gcK5x9fDuNniE0GteKmpYNOXWAc-0gw@mail.gmail.com>
References: <20110906042101.GE18425@mtj.dyndns.org>
	<20110906104952.0c930a93@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55140 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab1INHop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2011 03:44:45 -0400
Received: by ywb5 with SMTP id 5so1192501ywb.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2011 00:44:44 -0700 (PDT)
In-Reply-To: <20110906104952.0c930a93@bob.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, seth.heasley@intel.com

Hi Tejun and Alan,

Thanks for your spending time on the bug.

On Tue, Sep 6, 2011 at 5:49 PM, Alan Cox <alan@linux.intel.com> wrote:

>
> So NACK.
>
> Add a piix_sata_data_xfer32_maybe() function to the ata_piix driver
> specifically for this chipset.

Could you accept the quirk patch below to make these controllers working
at least now?

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 43107e9..eb7ea56 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -341,11 +341,12 @@ static struct ata_port_operations piix_sata_ops = {
 };

 static struct ata_port_operations piix_pata_ops = {
-	.inherits		= &piix_sata_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
 	.prereset		= piix_pata_prereset,
+	.sff_irq_check		= piix_irq_check,
 };

 static struct ata_port_operations piix_vmw_ops = {
@@ -1585,6 +1586,15 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 				"on poweroff and hibernation\n");
 	}

+	/*
+	 * Sandybridge chipset H61/P67/H67 have broken 32 mode up to now
+	 * see https://bugzilla.kernel.org/show_bug.cgi?id=40592
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x1c00)
+		piix_sata_ops.inherits = &ata_bmdma_port_ops;
+	else
+		piix_sata_ops.inherits = &ata_bmdma32_port_ops;
+
 	port_info[0] = piix_port_info[ent->driver_data];
 	port_info[1] = piix_port_info[ent->driver_data];



thanks,
-- 
Ming Lei
