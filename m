From: Tobias Lorenz <tobias.lorenz@gmx.net>
Subject: Re: [PATCH 2.6.9-libata1-dev1] libata-scsi: hdparm support
Date: Sat, 23 Oct 2004 23:59:12 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098568752.8926.16.camel@server.lorenz.priv>
References: <1098487253.28916.12.camel@server.lorenz.priv>
	 <58cb370e04102305363da96ebd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:47285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261312AbUJWV7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Oct 2004 17:59:15 -0400
In-Reply-To: <58cb370e04102305363da96ebd@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi,

Bartlomiej Zolnierkiewicz wrote:
> dev->id
> 
> HDIO_GET_IDENTITY (as used by 'hdparm -i') should return _original_
> drive ID (dev->id should be returned) so currently used mode may not
> be reported correctly.

The used mode isn't reported yet. Only cylinders, sectors, heads, model
and firmware version are supported by now.

dev is of type ata_device, so dev->id is 
u16                     id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */

Where in dev->id are the model and revision strings encoded ? Here is a comparison:
ata1: dev 0 cfg 49:2f00 82:74eb 83:4bea 84:4000 85:7469 86:0802 87:4003 88:203f
ata_dump_id: 49==0x2f00 53==0x0007 63==0x0007 64==0x0003 75==0x001f
ata_dump_id: 80==0x003c 81==0x0015 82==0x74eb 83==0x4bea 84==0x4000
ata_dump_id: 88==0x203f 93==0x600b

ata_scsiop_inq_std: ENTER
  Vendor: ATA Model: IC35L060AVER07-0 Rev: 1.01
  Type: Direct-Access ANSI SCSI revision: 05 

> 'hdparm -I' should be already supported by current libata-dev tree.
hdparm -I needs implementations for the HDIO_GET_MULTCOUNT and
HDIO_GET_IDENTITY commands in ata_scsi_ioctl to report informations.
Both were not implemented.

Toby


