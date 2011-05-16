From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: WD20EARS: finally reporting 4KByte sector size!
Date: Mon, 16 May 2011 20:27:52 +0200
Message-ID: <87zkmm7b6f.fsf@nemi.mork.no>
References: <4DD0A00D.3030104@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36139 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab1EPS2J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2011 14:28:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1QM2WS-0007zF-34
	for linux-ide@vger.kernel.org; Mon, 16 May 2011 20:28:04 +0200
Received: from nemi.mork.no ([148.122.252.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2011 20:28:04 +0200
Received: from bjorn by nemi.mork.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2011 20:28:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mark Lord <kernel@teksavvy.com> writes:

> I picked up my third WD 2TB "Green" drive today,
> and lo and behold.. the firmware (51.0AB51) actually
> reports the real physical sector size (finally!).
>
> TA device, with non-removable media
>
>         Model Number:       WDC WD20EARS-60MVWB0
>
>         Serial Number:      WD-WCAZA4297731
>
>         Firmware Revision:  51.0AB51

It's not the firmware revision.  The '6' in the model number seems to
make the difference. =20

I've got two drives with exactly the same firmware revision, but with a
WD20EARS-00MVWB0 model mumber and lower serial number (it's still the 3
platter version), and they both report 512 bytes:


/dev/sdi:

ATA device, with non-removable media
        Model Number:       WDC WD20EARS-00MVWB0                   =20
        Serial Number:      WD-WCAZA3180082
        Firmware Revision:  51.0AB51
        Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA=
 Rev 2.5, SATA Rev 2.6
Standards:
        Supported: 8 7 6 5=20
        Likely used: 8
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors: 3907029168
        Logical/Physical Sector size:           512 bytes
        device size with M =3D 1024*1024:     1907729 MBytes
        device size with M =3D 1000*1000:     2000398 MBytes (2000 GB)
        cache/buffer size  =3D unknown
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific =
minimum
        R/W multiple sector transfer: Max =3D 16  Current =3D 0
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udm=
a6=20
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4=20
             Cycle time: no flow control=3D120ns  IORDY flow control=3D=
120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Power-Up In Standby feature set
           *    SET_FEATURES required to spinup after power up
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    64-bit World wide name
           *    WRITE_UNCORRECTABLE_EXT command
           *    {READ,WRITE}_DMA_EXT_GPL commands
           *    Segmented DOWNLOAD_MICROCODE
           *    Gen1 signaling speed (1.5Gb/s)
           *    Gen2 signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
           *    NCQ priority information
                DMA Setup Auto-Activate optimization
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT LBA Segment Access (AC2)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12] (vendor specific)
                unknown 206[13] (vendor specific)
Security:=20
        Master password revision code =3D 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        392min for SECURITY ERASE UNIT. 392min for ENHANCED SECURITY ER=
ASE UNIT.
Logical Unit WWN Device Identifier: 50014ee2055f5ff4
        NAA             : 5
        IEEE OUI        : 0014ee
        Unique ID       : 2055f5ff4
Checksum: correct


/dev/sdj:

ATA device, with non-removable media
        Model Number:       WDC WD20EARS-00MVWB0                   =20
        Serial Number:      WD-WCAZA3178640
        Firmware Revision:  51.0AB51
        Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA=
 Rev 2.5, SATA Rev 2.6
Standards:
        Supported: 8 7 6 5=20
        Likely used: 8
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors: 3907029168
        Logical/Physical Sector size:           512 bytes
        device size with M =3D 1024*1024:     1907729 MBytes
        device size with M =3D 1000*1000:     2000398 MBytes (2000 GB)
        cache/buffer size  =3D unknown
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific =
minimum
        R/W multiple sector transfer: Max =3D 16  Current =3D 0
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udm=
a6=20
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4=20
             Cycle time: no flow control=3D120ns  IORDY flow control=3D=
120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Power-Up In Standby feature set
           *    SET_FEATURES required to spinup after power up
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    64-bit World wide name
           *    WRITE_UNCORRECTABLE_EXT command
           *    {READ,WRITE}_DMA_EXT_GPL commands
           *    Segmented DOWNLOAD_MICROCODE
           *    Gen1 signaling speed (1.5Gb/s)
           *    Gen2 signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
           *    NCQ priority information
                DMA Setup Auto-Activate optimization
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT LBA Segment Access (AC2)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12] (vendor specific)
                unknown 206[13] (vendor specific)
Security:=20
        Master password revision code =3D 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        402min for SECURITY ERASE UNIT. 402min for ENHANCED SECURITY ER=
ASE UNIT.
Logical Unit WWN Device Identifier: 50014ee2055f7f54
        NAA             : 5
        IEEE OUI        : 0014ee
        Unique ID       : 2055f7f54
Checksum: correct




Bj=C3=B8rn

