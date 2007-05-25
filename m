From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: fix pio/mwdma programming
Date: Fri, 25 May 2007 19:16:58 +0200
Message-ID: <46571A0A.2030305@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070430182939.GD4156@artsapartment.org> <4636ADBE.8080508@gmail.com> <20070524195943.GC7734@artsapartment.org> <4655FBA4.9050702@garzik.org> <4655FDBF.3000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:26580 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbXEYRRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 13:17:10 -0400
Received: by nz-out-0506.google.com with SMTP id n1so384824nzf
        for <linux-ide@vger.kernel.org>; Fri, 25 May 2007 10:17:10 -0700 (PDT)
In-Reply-To: <4655FDBF.3000401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Art Haas <ahaas@airmail.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Fix various bugs in pio/mwdma mode programming.

* Control bits in the timing register wasn't cleared properly while
  programming PIO mode.

* MWDMA mode programming cleared the wrong part of control bits.

* MWDMA mode programming cleared udma_mask even when the controller
  doesn't support UDMA.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Art Haas <ahaas@airmail.net>
---
Patch is against libata-dev#upstream.  Thanks.

 drivers/ata/ata_piix.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9c07b88..924e447 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -685,8 +685,14 @@ static void piix_set_piomode (struct ata
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
@@ -694,12 +700,14 @@ static void piix_set_piomode (struct ata
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
@@ -816,7 +824,7 @@ static void do_pata_set_dmamode (struct
 			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
 			master_data |= control << 4;
 			pci_read_config_byte(dev, 0x44, &slave_data);
-			slave_data &= (0x0F + 0xE1 * ap->port_no);
+			slave_data &= (ap->port_no ? 0x0f : 0xf0);
 			/* Load the matching timing */
 			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
 			pci_write_config_byte(dev, 0x44, slave_data);
@@ -828,8 +836,11 @@ static void do_pata_set_dmamode (struct
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
