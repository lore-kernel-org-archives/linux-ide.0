From: Tejun Heo <htejun@gmail.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 1 Dec 2005 20:20:15 +0900
Message-ID: <20051201112015.GA10462@htj.dyndns.org>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:38065 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932148AbVLALUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 06:20:22 -0500
Received: by zproxy.gmail.com with SMTP id 14so270078nzn
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 03:20:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <438EC502.1090103@keytradebank.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean-Fran?ois Stenuit <jfs@keytradebank.com>
Cc: Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

On Thu, Dec 01, 2005 at 10:40:18AM +0100, Jean-Fran?ois Stenuit wrote:
> 
> Hi Keith,
> 
> I have been able to reproduce the bug (randomly - needing a few reboots 
> to make it happen) on a 2.6.15-rc3 kernel.
> 
> System is an HP DL140G2 with following SATA controller (from lspci -vv) :
> 
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
> Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
>        Subsystem: Hewlett-Packard Company: Unknown device 3208
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 17
>        Region 0: I/O ports at <unassigned>
>        Region 1: I/O ports at <unassigned>
>        Region 2: I/O ports at <unassigned>
>        Region 3: I/O ports at <unassigned>
>        Region 4: I/O ports at 1470 [size=16]

Hi,

Can you try the following patch?  It adds a module parameter
override_PCS.  If your piix module is built into the kernel, adding
the following to the kernel paramter shoudl work.

ata_piix.override_PCS=n

Where, n is one of

0: normal behavior
1: ignore PCS and always try to probe ports
2: overwrite PCS such that all ENABLED bits are 1

First, try with override_PCS=0 and make not of the printed combined
and orig_mask values on success and failure cases.  Then, try with
override_PCS=1, if it also fails, try with override_PCS=2.

You can tell if an override option works or not by comparing the
combined and orig_mask value to the failure case.  If the machine
boots successfully with the same combined/orig_mask values as the
failure case, it means that the override option works.

BTW, all these are based on the previous message in which you said
that when boot failed the kernel printed the following log message.

"ata1: SATA port has no device."

Right?


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 887b2b9..639da80 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -340,6 +340,9 @@ static void piix_pata_phy_reset(struct a
 	ata_bus_reset(ap);
 }
 
+static int override_PCS;
+module_param(override_PCS, int, 0700);
+
 /**
  *	piix_sata_probe - Probe PCI device for present SATA devices
  *	@ap: Port associated with the PCI device we wish to probe
@@ -367,6 +370,17 @@ static int piix_sata_probe (struct ata_p
 
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask = (int) pcs & 0xff;
+	printk("ata%u: combined=%d orig_mask=0x%x\n", ap->id, combined, orig_mask);
+
+	switch (override_PCS) {
+	case 1:
+		printk("ata%u: ignoring PCS\n", ap->id);
+		return 1;
+	case 2:
+		printk("ata%u: turning on PCS ENABLED bits\n", ap->id);
+		pci_write_config_byte(pdev, ICH5_PCS, 0x0f);
+		return 1;
+	}
 
 	/* TODO: this is vaguely wrong for ICH6 combined mode,
 	 * where only two of the four SATA ports are mapped
