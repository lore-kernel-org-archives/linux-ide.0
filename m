From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF flash IDE failure to attach with 2.6.20+
Date: Tue, 19 Jun 2007 14:00:54 +0900
Message-ID: <46776306.5030300@gmail.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070006070709030707030809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:10814 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbXFSFBB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 01:01:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2465997wah
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 22:01:00 -0700 (PDT)
In-Reply-To: <46770edc.101d640a.4fdf.4eae@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

This is a multi-part message in MIME format.
--------------070006070709030707030809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Hall wrote:
>>> For some reason, mwdma doesn't work in libata now.  I'm not sure why
>>> tho.  Alan, can you enlighten us?
>> No idea at all. All my hardware is still happy. 2.6.20 is an "old"
>> kernel
>> however so it does predate the fixes you did for ata_piix mode setup ?
> 
> Old - yes, but more stable in all other respects it seems to the .21 series.
> Are these patches available for me to try on .20 or are there dependencies
> on 21? 
> 

I suppose you were using ata_piix too in older kernel, right?  Can you
post the boot dmesg of 2.6.19?  We used to ignore mwdma mode before and
enabled it at some point after that.  That may be the cause here.

Also, please try the attached patch on top of 2.6.20.

-- 
tejun

--------------070006070709030707030809
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9c07b88..924e447 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -685,8 +685,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 	if (adev->class == ATA_DEV_ATA)
 		control |= 4;	/* PPE enable */
 
+	/* PIO configuration clears DTE unconditionally.  It will be
+	 * programmed in set_dmamode which is guaranteed to be called
+	 * after set_piomode if any DMA mode is available.
+	 */
 	pci_read_config_word(dev, master_port, &master_data);
 	if (is_slave) {
+		/* clear TIME1|IE1|PPE1|DTE1 */
+		master_data &= 0xff0f;
 		/* Enable SITRE (seperate slave timing register) */
 		master_data |= 0x4000;
 		/* enable PPE1, IE1 and TIME1 as needed */
@@ -694,12 +700,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data &= (ap->port_no ? 0x0f : 0xf0);
 		/* Load the timing nibble for this slave */
-		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+		slave_data |= ((timings[pio][0] << 2) | timings[pio][1])
+						<< (ap->port_no ? 4 : 0);
 	} else {
-		/* Master keeps the bits in a different format */
-		master_data &= 0xccf8;
+		/* clear ISP|RCT|TIME0|IE0|PPE0|DTE0 */
+		master_data &= 0xccf0;
 		/* Enable PPE, IE and TIME as appropriate */
 		master_data |= control;
+		/* load ISP and RCT */
 		master_data |=
 			(timings[pio][0] << 12) |
 			(timings[pio][1] << 8);
@@ -816,7 +824,7 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
 			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
 			master_data |= control << 4;
 			pci_read_config_byte(dev, 0x44, &slave_data);
-			slave_data &= (0x0F + 0xE1 * ap->port_no);
+			slave_data &= (ap->port_no ? 0x0f : 0xf0);
 			/* Load the matching timing */
 			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
@@ -828,8 +836,11 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
 				(timings[pio][0] << 12) |
 				(timings[pio][1] << 8);
 		}
-		udma_enable &= ~(1 << devid);
-		pci_write_config_word(dev, master_port, master_data);
+
+		if (ap->udma_mask) {
+			udma_enable &= ~(1 << devid);
+			pci_write_config_word(dev, master_port, master_data);
+		}
 	}
 	/* Don't scribble on 0x48 if the controller does not support UDMA */
 	if (ap->udma_mask)

--------------070006070709030707030809--
