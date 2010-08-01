From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Sun, 1 Aug 2010 15:15:09 -0600
Message-ID: <AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se>
	<4C3D134B.2090604@gmail.com>
	<Pine.LNX.4.61.1007140955080.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007171422530.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007211433360.24693@envy.nxs.se>
	<4C531A40.6080804@gmail.com>
	<Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59671 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0HAVPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Aug 2010 17:15:10 -0400
Received: by iwn7 with SMTP id 7so3415222iwn.19
        for <linux-ide@vger.kernel.org>; Sun, 01 Aug 2010 14:15:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

On Sun, Aug 1, 2010 at 8:27 AM, Tomas Lund <tlund@nxs.se> wrote:
> On Fri, 30 Jul 2010, Robert Hancock wrote:
>
>> On 07/21/2010 06:38 AM, Tomas Lund wrote:
>>>
>>> On Wed, 21 Jul 2010, Tomas Lund wrote:
>>>
>>>> Put the "LYCOM SATA PE-103 2-CH" back in the server with the Gigab=
yte
>>>> 965P-DS4 motherboard and installed the debian backports kernel
>>>> 2.6.32-bpo.5-amd64.
>>>>
>>>> Problem persists and a dmesg and console output (since dmesg buffe=
r is
>>>> too small to fit everything) is available at:
>>>>
>>>> http://tlund.pp.se/sil24/console_2.6.32-bpo.5-amd64.txt
>>>> http://tlund.pp.se/sil24/dmesg_2.6.32-bpo.5-amd64.txt
>>>
>>> Tested Debian 2.6.26-2-amd64, files at the same place.
>>
>> What does "hdparm -I" show when run on the drive attached to that
>> controller?
>
> # hdparm -I /dev/sdb
>
> /dev/sdb:
>
> ATA device, with non-removable media
> =A0 =A0 =A0 =A0Model Number: =A0 =A0 =A0 SAMSUNG HD103SJ
> =A0 =A0 =A0 =A0Serial Number: =A0 =A0 =A0S246J90Z321275
> =A0 =A0 =A0 =A0Firmware Revision: =A01AJ10001
> =A0 =A0 =A0 =A0Transport: =A0 =A0 =A0 =A0 =A0Serial, ATA8-AST, SATA 1=
=2E0a, SATA II Extensions,
> SATA Rev 2.5
> Standards:
> =A0 =A0 =A0 =A0Used: unknown (minor revision code 0x0028)
> =A0 =A0 =A0 =A0Supported: 8 7 6 5
> =A0 =A0 =A0 =A0Likely used: 8
> Configuration:
> =A0 =A0 =A0 =A0Logical =A0 =A0 =A0 =A0 max =A0 =A0 current
> =A0 =A0 =A0 =A0cylinders =A0 =A0 =A0 16383 =A0 16383
> =A0 =A0 =A0 =A0heads =A0 =A0 =A0 =A0 =A0 16 =A0 =A0 =A016
> =A0 =A0 =A0 =A0sectors/track =A0 63 =A0 =A0 =A063
> =A0 =A0 =A0 =A0--
> =A0 =A0 =A0 =A0CHS current addressable sectors: =A0 16514064
> =A0 =A0 =A0 =A0LBA =A0 =A0user addressable sectors: =A0268435455
> =A0 =A0 =A0 =A0LBA48 =A0user addressable sectors: 1953525168
> =A0 =A0 =A0 =A0device size with M =3D 1024*1024: =A0 =A0 =A0953869 MB=
ytes
> =A0 =A0 =A0 =A0device size with M =3D 1000*1000: =A0 =A0 1000204 MByt=
es (1000 GB)
> Capabilities:
> =A0 =A0 =A0 =A0LBA, IORDY(can be disabled)
> =A0 =A0 =A0 =A0Queue depth: 32
> =A0 =A0 =A0 =A0Standby timer values: spec'd by Standard, no device sp=
ecific minimum
> =A0 =A0 =A0 =A0R/W multiple sector transfer: Max =3D 16 =A0Current =3D=
 16
> =A0 =A0 =A0 =A0Advanced power management level: disabled
> =A0 =A0 =A0 =A0Recommended acoustic management value: 254, current va=
lue: 254
> =A0 =A0 =A0 =A0DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *=
udma5 udma6
> =A0 =A0 =A0 =A0 =A0 =A0 Cycle time: min=3D120ns recommended=3D120ns
> =A0 =A0 =A0 =A0PIO: pio0 pio1 pio2 pio3 pio4
> =A0 =A0 =A0 =A0 =A0 =A0 Cycle time: no flow control=3D120ns =A0IORDY =
flow control=3D120ns
> Commands/features:
> =A0 =A0 =A0 =A0Enabled Supported:
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SMART feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Security Mode feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Power Management feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Write cache
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Look-ahead
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Host Protected Area feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0WRITE_BUFFER command
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0READ_BUFFER command
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0NOP cmd
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0DOWNLOAD_MICROCODE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Advanced Power Management feature set
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Power-Up In Standby feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SET_FEATURES required to spinup after po=
wer up
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SET_MAX security extension
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Automatic Acoustic Management feature se=
t
> =A0 =A0 =A0 =A0 =A0 * =A0 =A048-bit Address feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Device Configuration Overlay feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Mandatory FLUSH_CACHE
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0FLUSH_CACHE_EXT
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SMART error logging
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SMART self-test
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0General Purpose Logging feature set
> =A0 =A0 =A0 =A0 =A0 * =A0 =A064-bit World wide name
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0WRITE_UNCORRECTABLE_EXT command
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0{READ,WRITE}_DMA_EXT_GPL commands
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Segmented DOWNLOAD_MICROCODE
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SATA-I signaling speed (1.5Gb/s)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SATA-II signaling speed (3.0Gb/s)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Native Command Queueing (NCQ)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Host-initiated interface power managemen=
t
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Phy event counters
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0unknown 76[12]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA Setup Auto-Activate optimization
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Device-initiated interface power manag=
ement
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0Software settings preservation
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SMART Command Transport (SCT) feature se=
t
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SCT Long Sector Access (AC1)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SCT LBA Segment Access (AC2)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SCT Error Recovery Control (AC3)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SCT Features Control (AC4)
> =A0 =A0 =A0 =A0 =A0 * =A0 =A0SCT Data Tables (AC5)
> Security:
> =A0 =A0 =A0 =A0Master password revision code =3D 65534
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0supported
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enabled
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0locked
> =A0 =A0 =A0 =A0not =A0 =A0 frozen
> =A0 =A0 =A0 =A0not =A0 =A0 expired: security count
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0supported: enhanced erase
> =A0 =A0 =A0 =A0Security level high
> =A0 =A0 =A0 =A0150min for SECURITY ERASE UNIT. 150min for ENHANCED SE=
CURITY ERASE
> UNIT.
> Logical Unit WWN Device Identifier: 50024e9221d12b7
> =A0 =A0 =A0 =A0NAA =A0 =A0 =A0 =A0 =A0 =A0 : 5
> =A0 =A0 =A0 =A0IEEE OUI =A0 =A0 =A0 =A0: 24e9
> =A0 =A0 =A0 =A0Unique ID =A0 =A0 =A0 : 221d12b7
> Checksum: correct
>
>> Is it possible there's some security locking enabled on it? If the B=
IOS is
>> doing some kind of security unlock then it probably does it only on =
drives
>> attached to the motherboard controller, not on any add-in cards. It
>> certainly seems like the drive is returning command aborted on all r=
eads
>> when connected to that controller for whatever reason.
>
> No, nothing like that :(

The output above shows that the drive has security enabled and locked,
 so it seems that must be the case, and it won't be accessible unless
it's unlocked. hdparm should be able to disable it, though it seems
you may need a valid password to do it..
