From: "Moore, Eric" <Eric.Moore@lsi.com>
Subject: RE: ATA_16 support on mptsas
Date: Mon, 23 Jun 2008 13:40:03 -0600
Message-ID: <660360F4F2570145BD872F298951B17A26420CD9@cosmail03.lsi.com>
References: <200806231800.08659.kb@sysmikro.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail0.lsil.com ([147.145.40.20]:62181 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763030AbYFWTlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 15:41:47 -0400
In-Reply-To: <200806231800.08659.kb@sysmikro.com.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-2?Q?Krzysztof_B=B3aszkowski?= <kb@sysmikro.com.pl>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "Stewart, Ken" <Ken.Stewart@lsi.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, DL-MPT Fusion Linux <DL-MPTFusionLinux@lsi.com>

On Monday, June 23, 2008 10:00 AM, Krzysztof B=B3aszkowski wrote:
>
> I found that any HDIO_DRIVE_CMD ioctl on sata drive connected
> through mpsas
> and backplane will fail. Basically the scsi_host_template structure i=
s
> missing ioctl callback. after adding it and temporary
> tweaking domain_device
> structure associated to scsi_device (rphy only) i reached a
> point where
> ata_scsi_ioctl returns EIO and this why i need some clue on a
> way of adding
> such support similar way to aic94 where it has been done.
>
> I found also that mptsas leaves domain_device rather
> uninitialized. the
> example is rphy but there more fields i don't know if they
> are revelant to
> proper processing of HDIO_DRIVE_CMD.
> i need additional references on libata design, call flow and
> structures
> relationship.
>
> probably it would be the best to design mptsas from scratch
> using libsas but
> this seems to me as huge work although if i was guided i
> would probably
> complete this.
>

We have no plans to implement HDIO ioctls in our driver.   The SATL imp=
lementation is inside the mpt fusion firmware, and from the driver, we =
don't care whether the underlying protocal is SAS, SATA, Fibre Channel,=
 or SPI.   For all protocals, we send scsi commands to the controller f=
irmware using SCSI_IO opcode, with the following struct:

typedef struct _MSG_SCSI_IO_REQUEST
{
    U8                      TargetID;           /* 00h */
    U8                      Bus;                /* 01h */
    U8                      ChainOffset;        /* 02h */
    U8                      Function;           /* 03h */
    U8                      CDBLength;          /* 04h */
    U8                      SenseBufferLength;  /* 05h */
    U8                      Reserved;           /* 06h */
    U8                      MsgFlags;           /* 07h */
    U32                     MsgContext;         /* 08h */
    U8                      LUN[8];             /* 0Ch */
    U32                     Control;            /* 14h */
    U8                      CDB[16];            /* 18h */
    U32                     DataLength;         /* 28h */
    U32                     SenseBufferLowAddr; /* 2Ch */
    SGE_IO_UNION            SGL;                /* 30h */
} MSG_SCSI_IO_REQUEST, MPI_POINTER PTR_MSG_SCSI_IO_REQUEST,
  SCSIIORequest_t, MPI_POINTER pSCSIIORequest_t;

>
> I tried another approach where i used SG_IO ioctl and
> prepared ATA_16 cdb
> (just like libata does) but this failed on mptsas connected drives to=
o
> altough this way works on drives connected to ICH6.
>

The SG tools will work with mpt fusion if your passing the ATA_12 (opco=
de=3D0xA1) and ATA_16 (opcode=3D0x85).   This is implemented in fusion =
firmware.  If your failing, then your probably having old firmware.  I =
suggest that you upgrading by going to the download site  located here:=
 http://www.lsi.com/cm/DownloadSearch.do?locale=3DEN.    Ken Stewart is=
 from support, he should be able to assist you with upgrading the firmw=
are if you encounter any problems.

Eric Moore








