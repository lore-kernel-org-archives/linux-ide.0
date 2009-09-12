From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Can't burn CDs/DVDs
Date: Sat, 12 Sep 2009 11:07:38 -0600
Message-ID: <4AABD55A.9030800@gmail.com>
References: <20090911193017.d47e167e.cjsthompson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:64902 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbZILRHj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Sep 2009 13:07:39 -0400
Received: by ywh4 with SMTP id 4so2668802ywh.5
        for <linux-ide@vger.kernel.org>; Sat, 12 Sep 2009 10:07:42 -0700 (PDT)
In-Reply-To: <20090911193017.d47e167e.cjsthompson@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christoph .J Thompson" <cjsthompson@gmail.com>
Cc: linux-ide@vger.kernel.org

On 09/11/2009 11:30 AM, Christoph .J Thompson wrote:
> This is an issue I've had for a while, but since I rarely burn CDs or=
 DVDs I forget about it. But still I'd like to be able not to have to r=
eboot to Windows XP to burn that occasional CD/DVD. So as you can gathe=
r both drives work with Nero/Windows XP so *something* is fishy with Li=
nux. It used to work on Linux up until some point which I don't really =
remember.
>
> I did not switch to libata/pata_via because it's still marked as expe=
rimental (should I?). I don't have any SATA drives.

The commonly used libata PATA drivers are no longer considered=20
experimental, in particular pata_via is not.

>
> This message seems to be interresting:
>
> cdrecord: Warning: The DMA speed test has been skipped.
>
> As on my system cdparanoia barfs if I don't disable DMA on the drive =
I'm trying to rip from.

ugh.. this sort of thing being a reason to try libata instead :-) In th=
e=20
long term that would likely be best as the IDE drivers are no longer=20
very widely used and are less maintained.

>
> Any help to fix this would be really welcome.
>
> ---
>
> # cdrecord -vvv dev=3D/dev/hdc haiku-alpha.iso
> cdrecord: No write mode specified.
> cdrecord: Asuming -sao mode.
> cdrecord: If your drive does not accept -sao, try -tao.
> cdrecord: Future versions of cdrecord may have different drive depend=
ent defaults.
> Cdrecord-ProDVD-ProBD-Clone 2.01.01a57 (i686-pc-linux-gnu) Copyright =
(C) 1995-2009 J=F6rg Schilling
> TOC Type: 1 =3D CD-ROM
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.9'.
> Using libscg transport code version 'schily-scsi-linux-sg.c-1.92'
> SCSI buffer size: 64512
> atapi: 1
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 2
> Capabilities   :
> Vendor_info    : 'PHILIPS '
> Identifikation : 'PCRW5232P       '
> Revision       : 'P2.2'
> Device seems to be: Generic mmc CD-RW.
> Current: none
> Profile: CD-RW
> Profile: CD-R
> Profile: CD-ROM
> Feature: 'Profile List' (current) (persistent)
> Feature: 'Core' (current) (persistent)
> Feature: 'Morphing' (current) (persistent)
> Feature: 'Removable Medium' (current) (persistent)
> Feature: 'Random Readable'
> Feature: 'Multi Read' (current) (persistent)
> Feature: 'CD Read'
> Feature: 'Random Writable'
> Feature: 'Incremental Streaming Writable'
> Feature: 'Formattable'
> Feature: 'Restricted Overwrite'
> Feature: 'CD Track at Once'
> Feature: 'CD Mastering'
> Feature: 'Power Management' (current) (persistent)
> Feature: 'S.M.A.R.T.'
> Feature: 'CD Audio analog play' (current)
> Feature: 'Time-out' (current) (persistent)
> Drive current speed: 48
> Drive default speed: 52
> Drive max speed    : 52
> Selected speed     : 52
> Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED
> Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RA=
W/R96R
> cdrecord: Warning: The DMA speed test has been skipped.
> FIFO size      : 4194304 =3D 4096 KB
> Track 01: data   379 MB
> track: 1 start: 0 pregap: 150
> Total size:      436 MB (43:13.44) =3D 194508 sectors
> Lout start:      436 MB (43:15/33) =3D 194508 sectors
>   41 00 00 14 00 00 00 00
>   41 01 00 10 00 00 00 00
>   41 01 01 10 00 00 02 00
>   41 AA 01 14 00 2B 0F 21
> Track 1 start 0
> Track 2 start 194508
>   41 00 A0 00 00 00 00 01 00 00 00 00
>   41 00 A1 00 00 00 00 01 00 00 00 00
>   41 00 A2 00 00 00 00 43 15 33 00 00
>   41 00 01 00 00 00 00 00 02 00 00 00
> cdrecord: Success. test unit ready: scsi sendcmd: no error
> CDB:  00 00 00 00 00 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 3A 00 00 00
> Sense Key: 0x2 Not Ready, Segment 0
> Sense Code: 0x3A Qual 0x00 (medium not present) Fru 0x0
> Sense flags: Blk 0 (not valid)
> cmd finished after 0.001s timeout 200s
> cdrecord: No disk / Wrong disk!

It's not clear what command it's complaining about that has failed.=20
=46irst it says that test unit ready succeeded, then it says that the=20
drive reported a "medium not present" error. Is there any way to enable=
=20
any more debugging in cdrecord? If you retry the burning attempt does=20
the same thing happen?
