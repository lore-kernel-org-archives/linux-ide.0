From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] libata-core when not ata_id_use_dmadir despite yes SiliconI mage
Date: Sat, 15 May 2004 16:33:10 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405151633.10473.bzolnier@elka.pw.edu.pl>
References: <1084630807.5082.42.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37591 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262873AbUEOObD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 10:31:03 -0400
In-Reply-To: <1084630807.5082.42.camel@patibmrh9>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Saturday 15 of May 2004 16:20, Pat LaVarre wrote:
> > > > Subject: Re: SATA ATAPI work in progress
> > > > ...
> > > > I doubt I can use this patch as is.  I believe,
> > > > because I assembled my drive from components myself,
> > > > its op xA1 Identify data has not changed,
> > > > so I will see a misleading 0 False at:
> > > >
> > > > #define ata_id_use_dmadir(dev) ((dev)->id[62] & (1 << 15))
> >
> > Theory confirmed!
>
> Consequently now:
>
> In t13.org since the dawn of time, I see the requirement that compliant
> ATAPI devices tolerate hosts creatively choosing to copy
> (cmd->sc_data_direction != SCSI_DATA_WRITE) into (ata_taskfile.feature &
> x04 ATAPI_DMADIR).
>
> I see devices constructed with Silicon Image 3611CT80 1.4 require such a
> courtesy from the host.
>
> Therefore I propose that Linux, as host, offer that courtesy always.

Makes sense.

Jeff, if you decide to do this remember to kill ata_id_use_dmadir()
and ATA_DFLAG_DMADIR completely.  [ I'm sure you will. :-) ]

> Pat LaVarre
>
> P.S. Of course I still agree the firmware of devices manufactured with
> this perhaps excessively transparent SATA/ PATA bridge should set "word"
> 62 mask x8000 ata_id_use_dmadir, after that proposal in fact becomes a
> t13.org standard, presuming that standards development process doesn't
> move or flip that bit.
>
> Indeed, after the proposal is standard, I'll argue all PATA devices
> should set this bit, on the chance that their actual connection with the
> host is such an extremely transparent SATA/ PATA bridge.
>
> But that argument I expect to lose to the fear that some hosts will
> choose to refuse to speak DMA with devices that set ata_id_use_dmadir,
> rather than choosing to disclose (cmd->sc_data_direction !=
> SCSI_DATA_WRITE).
>
> P.P.S. In passing in include/linux/, I vote we teach Linux to enum
> together all the bits of the ata_taskfile.feature parameter of ATA op
> xA0 ATA_CMD_PACKET.
>
> --- o/drivers/scsi/libata-core.c	2004-05-15 07:31:49.000000000 -0600
> +++ linux-2.6.6-bk1/drivers/scsi/libata-core.c	2004-05-15
> 07:53:40.520947904 -0600 @@ -1168,8 +1168,10 @@ retry:
>  		if (ata_id_is_ata(dev))		/* sanity check */
>  			goto err_out_nosup;
>
> -		if (ata_id_use_dmadir(dev))
> -			dev->flags |= ATA_DFLAG_DMADIR;
> +		/* share cmd->sc_data_direction with device
> +		 * even when (!ata_id_use_dmadir(dev)) claims not needed
> +		 */
> +		dev->flags |= ATA_DFLAG_DMADIR;
>
>  		/* see if 16-byte commands supported */
>  		tmp = dev->id[0] & 0x3;
> --- o/include/linux/ata.h	2004-05-15 07:09:33.000000000 -0600
> +++ linux-2.6.6-bk1/include/linux/ata.h	2004-05-15 07:58:15.181193200 -0600
> @@ -84,8 +84,6 @@ enum {
>  	ATA_ERR			= (1 << 0),	/* have an error */
>  	ATA_SRST		= (1 << 2),	/* software reset */
>  	ATA_ABORTED		= (1 << 2),	/* command aborted */
> -	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
> -						   0=to device, 1=to host */
>
>  	/* ATA command block registers */
>  	ATA_REG_DATA		= 0x00,
> @@ -136,6 +134,8 @@ enum {
>
>  	/* ATAPI stuff */
>  	ATAPI_PKT_DMA		= (1 << 0),
> +	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
> +						   0=to device, 1=to host */
>
>  	/* cable types */
>  	ATA_CBL_NONE		= 0,

