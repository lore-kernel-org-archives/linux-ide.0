From: Pat LaVarre <p.lavarre@ieee.org>
Subject: [PATCH] libata-core when not ata_id_use_dmadir despite yes SiliconI
	mage
Date: 15 May 2004 08:20:07 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084630807.5082.42.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-ZvD21iFXeNosyolsX0e6"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:27119 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261421AbUEOOUa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 10:20:30 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--=-ZvD21iFXeNosyolsX0e6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > > Subject: Re: SATA ATAPI work in progress
> > > ...
> > > I doubt I can use this patch as is.  I believe,
> > > because I assembled my drive from components myself,
> > > its op xA1 Identify data has not changed,
> > > so I will see a misleading 0 False at:
> > > 
> > > #define ata_id_use_dmadir(dev) ((dev)->id[62] & (1 << 15))
> 
> Theory confirmed!

Consequently now:

In t13.org since the dawn of time, I see the requirement that compliant
ATAPI devices tolerate hosts creatively choosing to copy
(cmd->sc_data_direction != SCSI_DATA_WRITE) into (ata_taskfile.feature &
x04 ATAPI_DMADIR).

I see devices constructed with Silicon Image 3611CT80 1.4 require such a
courtesy from the host.

Therefore I propose that Linux, as host, offer that courtesy always.

Pat LaVarre

P.S. Of course I still agree the firmware of devices manufactured with
this perhaps excessively transparent SATA/ PATA bridge should set "word"
62 mask x8000 ata_id_use_dmadir, after that proposal in fact becomes a
t13.org standard, presuming that standards development process doesn't
move or flip that bit.

Indeed, after the proposal is standard, I'll argue all PATA devices
should set this bit, on the chance that their actual connection with the
host is such an extremely transparent SATA/ PATA bridge.

But that argument I expect to lose to the fear that some hosts will
choose to refuse to speak DMA with devices that set ata_id_use_dmadir,
rather than choosing to disclose (cmd->sc_data_direction !=
SCSI_DATA_WRITE).

P.P.S. In passing in include/linux/, I vote we teach Linux to enum
together all the bits of the ata_taskfile.feature parameter of ATA op
xA0 ATA_CMD_PACKET.

--- o/drivers/scsi/libata-core.c	2004-05-15 07:31:49.000000000 -0600
+++ linux-2.6.6-bk1/drivers/scsi/libata-core.c	2004-05-15 07:53:40.520947904 -0600
@@ -1168,8 +1168,10 @@ retry:
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
-		if (ata_id_use_dmadir(dev))
-			dev->flags |= ATA_DFLAG_DMADIR;
+		/* share cmd->sc_data_direction with device
+		 * even when (!ata_id_use_dmadir(dev)) claims not needed
+		 */
+		dev->flags |= ATA_DFLAG_DMADIR;
 
 		/* see if 16-byte commands supported */
 		tmp = dev->id[0] & 0x3;
--- o/include/linux/ata.h	2004-05-15 07:09:33.000000000 -0600
+++ linux-2.6.6-bk1/include/linux/ata.h	2004-05-15 07:58:15.181193200 -0600
@@ -84,8 +84,6 @@ enum {
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
 	ATA_ABORTED		= (1 << 2),	/* command aborted */
-	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
-						   0=to device, 1=to host */
 
 	/* ATA command block registers */
 	ATA_REG_DATA		= 0x00,
@@ -136,6 +134,8 @@ enum {
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,



--=-ZvD21iFXeNosyolsX0e6
Content-Disposition: attachment; filename=pel.patch.7b
Content-Type: text/x-troff-man; name=pel.patch.7b; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- o/drivers/scsi/libata-core.c	2004-05-15 07:31:49.000000000 -0600
+++ linux-2.6.6-bk1/drivers/scsi/libata-core.c	2004-05-15 07:53:40.520947904 -0600
@@ -1168,8 +1168,10 @@ retry:
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
-		if (ata_id_use_dmadir(dev))
-			dev->flags |= ATA_DFLAG_DMADIR;
+		/* share cmd->sc_data_direction with device
+		 * even when (!ata_id_use_dmadir(dev)) claims not needed
+		 */
+		dev->flags |= ATA_DFLAG_DMADIR;
 
 		/* see if 16-byte commands supported */
 		tmp = dev->id[0] & 0x3;
--- o/include/linux/ata.h	2004-05-15 07:09:33.000000000 -0600
+++ linux-2.6.6-bk1/include/linux/ata.h	2004-05-15 07:58:15.181193200 -0600
@@ -84,8 +84,6 @@ enum {
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
 	ATA_ABORTED		= (1 << 2),	/* command aborted */
-	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
-						   0=to device, 1=to host */
 
 	/* ATA command block registers */
 	ATA_REG_DATA		= 0x00,
@@ -136,6 +134,8 @@ enum {
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,

--=-ZvD21iFXeNosyolsX0e6--

