From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 09:08:14 -0400
Message-ID: <49DDF33E.6000102@garzik.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>	<49DDEF02.7090004@garzik.org> <20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000203030808010601090302"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37407 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760186AbZDINIS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 09:08:18 -0400
In-Reply-To: <20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000203030808010601090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Thu, 09 Apr 2009 08:50:10 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan Cox wrote:
>>> Something like this then ?
>>>
>>>
>>> The legacy old IDE API for this is a bit primitive so we try and map stuff
>>> sensibly onto it.
>>>
>>> - Add flags2 as we ran out of flags
>>> - Set PIO over DMA devices to report 32bit
>>> - Add ability to change the PIO32 settings if the controller permits it
>>> - Add that functionality into the sff drivers
>>> - Add that functionality into the VLB legacy driver
>>> - Turn on the 32bit PIO on the ninja32 and add support there
>>>
>>> Signed-off-by: Alan Cox <alan@linux.intel.com>
>> I think the flag2 stuff needs a closer look WRT driver setup, but 
>> overall looks good.
>>
>> Consider it ACK'd, if I cannot come up with anything better for flags2 
> 
> The alternative would be to remove the private 8 flags from flags but
> that means fairly excessive changes to all the devices

Well the obvious alternative is attached...  kick the can down the road.


> [Looks smug and notes that he pointed out that driver private flags in
> the same field would turn out to be a bad idea early on ...]

True.  At present the flags are inherited from the ata_port_info 
structure, so introducing a driver_flags field isn't as trivial as it 
might seem, unfortunately.

With the attached patch, you can use ->flags for the two new flags, and 
you can set those bits in the driver where you set the other 
ATA_FLAG_xxx bits.

	Jeff




--------------000203030808010601090302
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index b1fd7d6..c7bd4b4 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -127,9 +127,9 @@ enum {
 				  ATA_FLAG_PIO_POLLING,
 
 	/* ap->flags bits */
-	PDC_FLAG_GEN_II		= (1 << 24),
-	PDC_FLAG_SATA_PATA	= (1 << 25), /* supports SATA + PATA */
-	PDC_FLAG_4_PORTS	= (1 << 26), /* 4 ports */
+	PDC_FLAG_GEN_II		= (1 << 29),
+	PDC_FLAG_SATA_PATA	= (1 << 30), /* supports SATA + PATA */
+	PDC_FLAG_4_PORTS	= (1 << 31), /* 4 ports */
 };
 
 struct pdc_port_priv {
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index e67ce8e..d21afc7 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -57,9 +57,9 @@ enum {
 	/*
 	 * host flags
 	 */
-	SIL_FLAG_NO_SATA_IRQ	= (1 << 28),
-	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
-	SIL_FLAG_MOD15WRITE	= (1 << 30),
+	SIL_FLAG_NO_SATA_IRQ	= (1 << 29),
+	SIL_FLAG_RERR_ON_DMA_ACT= (1 << 30),
+	SIL_FLAG_MOD15WRITE	= (1 << 31),
 
 	SIL_DFL_PORT_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 77aa8d7..3852a1c 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -247,7 +247,7 @@ enum {
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_AN | ATA_FLAG_PMP,
-	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
+	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 31), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
 };
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 7257f2d..3c37ed0 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -59,9 +59,9 @@
 
 enum {
 	/* ap->flags bits */
-	K2_FLAG_SATA_8_PORTS		= (1 << 24),
-	K2_FLAG_NO_ATAPI_DMA		= (1 << 25),
-	K2_FLAG_BAR_POS_3			= (1 << 26),
+	K2_FLAG_SATA_8_PORTS		= (1 << 29),
+	K2_FLAG_NO_ATAPI_DMA		= (1 << 30),
+	K2_FLAG_BAR_POS_3		= (1 << 31),
 
 	/* Taskfile registers offsets */
 	K2_SATA_TF_CMD_OFFSET		= 0x00,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b450a26..42ab418 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -207,7 +207,7 @@ enum {
 	 */
 	ATA_FLAG_DISABLED	= (1 << 23), /* port is disabled, ignore it */
 
-	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
+	/* bits 29:31 of ap->flags are reserved for LLD specific flags */
 
 	/* struct ata_port pflags */
 	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */

--------------000203030808010601090302--
