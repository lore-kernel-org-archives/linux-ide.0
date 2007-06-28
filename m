From: Mark Lord <liml@rtr.ca>
Subject: Re: CF flash PATA on libata failure to attach
Date: Thu, 28 Jun 2007 13:37:13 -0400
Message-ID: <4683F1C9.2060505@rtr.ca>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2078 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759993AbXF1Rgf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 13:36:35 -0400
In-Reply-To: <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: linux-ide@vger.kernel.org

Andrew Hall wrote:
 > Hi Mark,
 >
 > The device is a Nexcom NSA1083 appliance:
 >
 > http://www.nexcom.com/product/productshow.jsp?iid=13&pid=878
 >
 > It's an OEM appliance that uses the Intel 965 chipset. We use it as one of
 > three platforms for our access control and compliance products as it has 8
 > built in Ethernet ports and a dual core processor - with built in compact
 > flash. The older appliance that this new (1083) one is superseding also had
 > built in CF although this one apparently had separate PATA and SATA
 > controllers, whereas the 1083 has only one 4 channel ICH8 Intel SATA
 > controller which interfaces to one CF connector and one IDE connector via a
 > SATA to PATA bridge ( I don't know exactly what this bridge is or how it
 > interfaces to the SATA bus - but I can probably find this out from the
 > manufacturer). The CF is a standard 512MB Sandisk/Kingston chip that we boot
 > from and write configuration data to.
..

I'm betting that the SATA/PATA converter is getting confused with
the ata_piix driver's attempt to use MDMA2 on it.

PIO appears to be working fine -- the BIOS uses it to boot,
and libata uses it to do the IDENTIFY operation.

So, try this hack, which should force ata_piix to use only PIO
for the ICH8 chipset. So long as you don't have any real SATA
drives, this might do the trick.

Cheers

--- linux/drivers/ata/ata_piix.c.orig 2007-06-27 11:20:51.000000000 -0400
+++ linux/drivers/ata/ata_piix.c 2007-06-28 13:32:27.000000000 -0400
@@ -526,8 +526,8 @@
.flags = PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
PIIX_FLAG_AHCI,
.pio_mask = 0x1f, /* pio0-4 */
- .mwdma_mask = 0x07, /* mwdma0-2 */
- .udma_mask = 0x7f, /* udma0-6 */
+ .mwdma_mask = 0x00, /* mwdma0-2 */
+ .udma_mask = 0x00, /* udma0-6 */
.port_ops = &piix_sata_ops,
},

@@ -537,8 +537,8 @@
.flags = PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
PIIX_FLAG_AHCI,
.pio_mask = 0x1f, /* pio0-4 */
- .mwdma_mask = 0x07, /* mwdma0-2 */
- .udma_mask = 0x7f, /* udma0-6 */
+ .mwdma_mask = 0x00, /* mwdma0-2 */
+ .udma_mask = 0x00, /* udma0-6 */
.port_ops = &piix_sata_ops,
},

