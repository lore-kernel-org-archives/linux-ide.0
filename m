From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata - 2.6.21-rc4-git5, ata channel still badly configured
Date: Thu, 22 Mar 2007 15:44:58 +0900
Message-ID: <460225EA.9060409@gmail.com>
References: <20070321213757.GB3637@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030304000800000106040500"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:1389 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbXCVGpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 02:45:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so680471wxd
        for <linux-ide@vger.kernel.org>; Wed, 21 Mar 2007 23:45:03 -0700 (PDT)
In-Reply-To: <20070321213757.GB3637@mail.muni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------030304000800000106040500
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Lukas Hejtmanek wrote:
>> Subject    : ata_piix: PATA UDMA/100 configured as UDMA/33
>> References : http://lkml.org/lkml/2007/2/20/294
>> Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
>> Status     : unknown
> 
> ata_piix 0000:00:1f.1: version 2.10ac1
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
> scsi0 : ata_piix
> Time: acpi_pm clocksource has been installed.
> Switched to high resolution mode on CPU 0
> ata1.00: ATA-6: ST9100824A, 3.04, max UDMA/100
> ata1.00: 195371568 sectors, multi 16: LBA48
> ata1.01: ATAPI, max UDMA/33
> ata1.00: configured for UDMA/33
> ata1.01: configured for UDMA/33
> scsi1 : ata_piix
> ATA: abnormal status 0x7F on port 0x00010177
> scsi 0:0:0:0: Direct-Access     ATA      ST9100824A       3.04 PQ: 0 ANSI: 5
> SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)

Does this fix your problem?

-- 
tejun

--------------030304000800000106040500
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 361953a..c89664a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1743,12 +1743,17 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	struct ata_device *dev;
+	unsigned int new_mask = 0;
 	unsigned long flags;
 	int i, rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	/* For PATA drive side cable detection to work, IDENTIFY must
+	 * be done backwards such that PDIAG- is released by the slave
+	 * device before the master device is identified.
+	 */
+	for (i = ATA_MAX_DEVICES - 1; i >= 0; i--) {
 		unsigned int action, readid_flags = 0;
 
 		dev = &ap->device[i];
@@ -1760,13 +1765,13 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
 			if (ata_port_offline(ap)) {
 				rc = -EIO;
-				break;
+				goto err;
 			}
 
 			ata_eh_about_to_do(ap, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev, readid_flags);
 			if (rc)
-				break;
+				goto err;
 
 			ata_eh_done(ap, dev, ATA_EH_REVALIDATE);
 
@@ -1784,40 +1789,53 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 
 			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
 					     dev->id);
-			if (rc == 0) {
-				ehc->i.flags |= ATA_EHI_PRINTINFO;
-				rc = ata_dev_configure(dev);
-				ehc->i.flags &= ~ATA_EHI_PRINTINFO;
-			} else if (rc == -ENOENT) {
+			switch (rc) {
+			case 0:
+				new_mask |= 1 << i;
+				break;
+			case -ENOENT:
 				/* IDENTIFY was issued to non-existent
 				 * device.  No need to reset.  Just
 				 * thaw and kill the device.
 				 */
 				ata_eh_thaw_port(ap);
 				dev->class = ATA_DEV_UNKNOWN;
-				rc = 0;
-			}
-
-			if (rc) {
-				dev->class = ATA_DEV_UNKNOWN;
 				break;
+			default:
+				dev->class = ATA_DEV_UNKNOWN;
+				goto err;
 			}
+		}
+	}
 
-			if (ata_dev_enabled(dev)) {
-				spin_lock_irqsave(ap->lock, flags);
-				ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
-				spin_unlock_irqrestore(ap->lock, flags);
+	/* Configure new devices forward such that user doesn't see
+	 * device detection messages backwards.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
 
-				/* new device discovered, configure xfermode */
-				ehc->i.flags |= ATA_EHI_SETMODE;
-			}
-		}
+		if (!(new_mask & (1 << i)))
+			continue;
+
+		ehc->i.flags |= ATA_EHI_PRINTINFO;
+		rc = ata_dev_configure(dev);
+		ehc->i.flags &= ~ATA_EHI_PRINTINFO;
+		if (rc)
+			goto err;
+
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		/* new device discovered, configure xfermode */
+		ehc->i.flags |= ATA_EHI_SETMODE;
 	}
 
-	if (rc)
-		*r_failed_dev = dev;
+	return 0;
 
-	DPRINTK("EXIT\n");
+ err:
+	*r_failed_dev = dev;
+	DPRINTK("EXIT rc=%d\n", rc);
 	return rc;
 }
 

--------------030304000800000106040500--
