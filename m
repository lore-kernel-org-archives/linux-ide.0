From: Krzysztof =?iso-8859-2?q?B=B3aszkowski?= <kb@sysmikro.com.pl>
Subject: Re: ATA_16 support on mptsas
Date: Fri, 27 Jun 2008 11:02:14 +0200
Message-ID: <200806271102.14951.kb@sysmikro.com.pl>
References: <660360F4F2570145BD872F298951B17A26420CD9@cosmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v007470.home.net.pl ([212.85.125.104]:53109 "HELO
	v007470.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750770AbYF0JBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 05:01:12 -0400
In-Reply-To: <660360F4F2570145BD872F298951B17A26420CD9@cosmail03.lsi.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Moore, Eric" <Eric.Moore@lsi.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "Stewart, Ken" <Ken.Stewart@lsi.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, DL-MPT Fusion Linux <DL-MPTFusionLinux@lsi.com>

Hello,

ATA_16 through SG is supported with recent firmware for LSI cards.
I verified non-dma/pio ATA commands only.

Regards,
Krzysztof Blaszkowski

On Monday 23 June 2008 21:40, Moore, Eric wrote:
> On Monday, June 23, 2008 10:00 AM, Krzysztof B=B3aszkowski wrote:
> > I found that any HDIO_DRIVE_CMD ioctl on sata drive connected
> > through mpsas
> > and backplane will fail. Basically the scsi_host_template structure=
 is
> > missing ioctl callback. after adding it and temporary
> > tweaking domain_device
> > structure associated to scsi_device (rphy only) i reached a
> > point where
> > ata_scsi_ioctl returns EIO and this why i need some clue on a
> > way of adding
> > such support similar way to aic94 where it has been done.
> >
> > I found also that mptsas leaves domain_device rather
> > uninitialized. the
> > example is rphy but there more fields i don't know if they
> > are revelant to
> > proper processing of HDIO_DRIVE_CMD.
> > i need additional references on libata design, call flow and
> > structures
> > relationship.
> >
> > probably it would be the best to design mptsas from scratch
> > using libsas but
> > this seems to me as huge work although if i was guided i
> > would probably
> > complete this.
>
> We have no plans to implement HDIO ioctls in our driver.   The SATL
> implementation is inside the mpt fusion firmware, and from the driver=
, we
> don't care whether the underlying protocal is SAS, SATA, Fibre Channe=
l, or
> SPI.   For all protocals, we send scsi commands to the controller fir=
mware
> using SCSI_IO opcode, with the following struct:
>
> typedef struct _MSG_SCSI_IO_REQUEST
> {
>     U8                      TargetID;           /* 00h */
>     U8                      Bus;                /* 01h */
>     U8                      ChainOffset;        /* 02h */
>     U8                      Function;           /* 03h */
>     U8                      CDBLength;          /* 04h */
>     U8                      SenseBufferLength;  /* 05h */
>     U8                      Reserved;           /* 06h */
>     U8                      MsgFlags;           /* 07h */
>     U32                     MsgContext;         /* 08h */
>     U8                      LUN[8];             /* 0Ch */
>     U32                     Control;            /* 14h */
>     U8                      CDB[16];            /* 18h */
>     U32                     DataLength;         /* 28h */
>     U32                     SenseBufferLowAddr; /* 2Ch */
>     SGE_IO_UNION            SGL;                /* 30h */
> } MSG_SCSI_IO_REQUEST, MPI_POINTER PTR_MSG_SCSI_IO_REQUEST,
>   SCSIIORequest_t, MPI_POINTER pSCSIIORequest_t;
>
> > I tried another approach where i used SG_IO ioctl and
> > prepared ATA_16 cdb
> > (just like libata does) but this failed on mptsas connected drives =
too
> > altough this way works on drives connected to ICH6.
>
> The SG tools will work with mpt fusion if your passing the ATA_12
> (opcode=3D0xA1) and ATA_16 (opcode=3D0x85).   This is implemented in =
fusion
> firmware.  If your failing, then your probably having old firmware.  =
I
> suggest that you upgrading by going to the download site  located her=
e:
> http://www.lsi.com/cm/DownloadSearch.do?locale=3DEN.    Ken Stewart i=
s from
> support, he should be able to assist you with upgrading the firmware =
if you
> encounter any problems.
>
> Eric Moore
