Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CDFC54EE9
	for <linux-ide@archiver.kernel.org>; Fri,  2 Sep 2022 08:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiIBIlW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Sep 2022 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiIBIlT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Sep 2022 04:41:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951C883E4
        for <linux-ide@vger.kernel.org>; Fri,  2 Sep 2022 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662108070; x=1693644070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hp3AFMYdEWcGxC/ciGkTzLr110ZAfBlvHk/jJMEb5KA=;
  b=GUsYYNAiPtopMRXrEZMe2+UdGN5+K90XulDMt778lWMIUkMaZpik0wfC
   qRQvS0jqbPjVnKpJf/RDbD7yy+SLsjLAq5IiOoF4V+U7dAHTYbjJIGAks
   i809DSSaAbCgUEc8qZs3xFIV1vUjK5brYkHSSmlhdeGDQ/KUOWFv/TS/6
   9HV47yyT5JI+Eevbvl/1M8GFja9XEQDt8Z4dK3gFPoCn1QW8OFuyN6cws
   qUid2kUQD5p/MTHAaDQYr4wBxkfmNRLPyvZyrzq9wkkc36uLihGOUwY5X
   dqji+F48mYQDT+TSUvG1/LF9n5fmHyfe+nGGuit98o5RDEvuwNbWpiYSb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654531200"; 
   d="scan'208";a="208743131"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 16:41:08 +0800
IronPort-SDR: jtyW7qA45IP+EoHjswes8mK7TLM2aAZb1HQQxs3knCN22vSt3AT+VrDBPCOYqS6QycYzPxkTzz
 Ynekx3dGOV3R2Qf1Cm9G1Spo+N/HXQNVej/AleUwbk9OjJJ0pAc76EJWSTBwdiJG2Cb8BmJYFL
 toekK1DEv5gBBS4Yr8dG+G/2g6m5bMyf6t/u9Y03QiPj42SjEgTjwMq4NsQEKpXVrrnamBY8oq
 xt3qrQweHsClPhL4kapIX4iSscTm9s1WDzfN309PRm55wsHMkZh+atB4q5Rv31F5b1u0ske64F
 uIJXk+zmP9uvxwtepA1mZy3d
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2022 01:01:36 -0700
IronPort-SDR: W18lIfS/NFCFTCfCegPXpDqVisx2z6dCxh1EfPHreHyrHV71AHL87BM5DLvqWj8fPyTzZDS2MO
 DT1HguWUVCdzBC3GmNTFXevz/OP295YIXEr5hts4JNgpZBjuscnd5JAtDtG5DYZHx75koLqioZ
 VbqopEC5OHiO4fPntHSgS2AYeYe5v3wRJZiWnQjEhofulo+9om0zByBtuvJ8jdNbxKBa07Y+XA
 zkBfsgGybsesLaW52wrCMNT88VUc7Ei7bnFyGR3owor9bia4d6Cz0jtuAkFqvyb9qoGc9+JM9p
 0l0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2022 01:41:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJrwh51wNz1RwqL
        for <linux-ide@vger.kernel.org>; Fri,  2 Sep 2022 01:41:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662108067; x=1664700068; bh=hp3AFMYdEWcGxC/ciGkTzLr110ZAfBlvHk/
        jJMEb5KA=; b=TcUEaN/undB7xoHhL8dYwV+EiQtjhseDjD8Hn/3OBLM2kmRXnpI
        pBIDCfaSVomOzLIgVLjAE7JygK13Eym7EXFOXmr6s6Lq+Gy/Hzt3gdGUlXwwOFvY
        79Vd2AR/wJd/mcayQpii4mbgfJDCvxIDQT62g7XgN2/KZ3mJK+qFepjcin3mWU3n
        fK50+RlC3t+nUKYk7u0oE0PHQUag3Od47KwwseEA76CSQzUK0e98X2yCVs6CGLdo
        di/WthlK2YTDuYHXvzxirFkGFxTlTGjae2IemcBtTPsStj7jchK/ksD0WemPxUtU
        BmjLUOEzpo2R/hzp71AZZqmafHRdqsicoHQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zUx7xh1LBCbV for <linux-ide@vger.kernel.org>;
        Fri,  2 Sep 2022 01:41:07 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJrwg1b3bz1RvLy;
        Fri,  2 Sep 2022 01:41:06 -0700 (PDT)
Message-ID: <50673ba5-6cca-23df-e09e-d7b3f7113896@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 17:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Content-Language: en-US
To:     =?UTF-8?Q?Peter_Fr=c3=b6hlich?= <peter.hans.froehlich@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
 <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
 <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com>
 <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com>
 <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
 <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
 <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
 <ed854cd3-3456-4dfc-e589-40f4946bb0e7@suse.de>
 <396b2bb5-533f-2a9c-66f2-c92465d54df1@opensource.wdc.com>
 <CAHXXO6ECthyiomdCCR8YaR6O8tq8XhhHn-sX3nRTnjNYkWCVLw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHXXO6ECthyiomdCCR8YaR6O8tq8XhhHn-sX3nRTnjNYkWCVLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/2/22 15:34, Peter Fr=C3=B6hlich wrote:
> On Fri, Sep 2, 2022 at 4:35 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>> Your drive seems to be an exception to my (1) statement and the error =
it
>> returns seems weird enough that the stat_table ends up being used.
>> Could you send a dmesg output of a failed command so that we can see t=
he
>> err_mask etc info for the failed command ? And it would be good to add=
 a
>> print of the drv_stat and drv_err parameters passed to
>> ata_to_sense_error() for the failures you are seeing. That would help
>> trying to figure out what your drive is attempting to signal.
>=20
> I don't think the drive wants to "signal" anything, instead it simply
> "disappears" at some point. The "original" error is "Emask 0x4
> (timeout)". So here's an example from early on when I had not made
> many kernel changes yet:

Sounds like the drive FW is crashing...

> -----CUT-----
> ...
> [  516.296397] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6 frozen
> [  516.296399] ata9.00: failed command: WRITE DMA

Are you running this drive with device/queue_depth set to 1 ? What is
issuing a WRITE DMA instead of the NCQ equivalent ? Is this a passthrough
command ?

> [  516.296402] ata9.00: cmd ca/00:23:51:03:4b/00:00:00:00:00/ed tag 4
> dma 17920 out
>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [  516.296403] ata9.00: status: { DRDY }
> ...
> [  516.761214] ata9: translated ATA stat/err 0x40/00 to SCSI
> SK/ASC/ASCQ 0x5/21/04
> [  516.761215] ata9.00: device reported invalid CHS sector 0

Yeah... An unaligned write error should normally also signal the LBA that
was being accessed when the error occurred. ata_tf_read_block() does not
see the LBA flag set, thinks it is CHS and ends up with garbage
information. We can ignored this one. The problem is the bogus unaligned
write error in the first place.

> [  516.761220] sd 8:0:0:0: [sdk] tag#4 scsi_eh_8: flush finish cmd
> [  516.761224] sd 8:0:0:0: [sdk] tag#4 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_SENSE
> [  516.761226] sd 8:0:0:0: [sdk] tag#4 Sense Key : Illegal Request [cur=
rent]
> [  516.761228] sd 8:0:0:0: [sdk] tag#4 Add. Sense: Unaligned write comm=
and
> [  516.761229] sd 8:0:0:0: [sdk] tag#4 CDB: Write(16) 8a 00 00 00 00
> 00 0d 4b 03 51 00 00 00 23 00 00
> ...
> -----CUT-----
>=20
> That "translated" line is only output because I changed "if (verbose)"
> to "if (1)" in that kernel. Also note the bizarre "CHS" error which
> only happens on some of these, not all; I had mentioned before that I
> am trying to track down how it happens that the LBA bit suddenly
> disappears (it might have to do with the hardreset being in process at
> this point and this message racing against the new IDENTIFY?). Using

See above for the explanation. That message is bogus because the error is
bogus too.

> the trace facility I can *sometimes* see the command being issued and
> then 30 seconds later the timeout happening; sometimes I just get the
> timeout and I *cannot* find when the command was issued in the trace,
> another thing that seems bizarre to me.

That really sound like a device FW crash (the device stops responding), b=
ut...

> Note that I didn't ask for help with that intentionally, I still think
> that I am too far away from a proper diagnosis to have a fruitful
> conversation about where the timeouts originate and why. We've checked
> against power issues and the like, and again, this happens only when
> the drive sits behind a SATA controller, not when it's behind a SAS
> controller.
>=20
>> Also, please send the output of "hdparm -I" for that SSD please, so th=
at
>> we have information about what standard it is (supposedly) following.
>=20
> See below, but I don't think the specific drive is relevant. The same
> "problem" shows up with a different brand/model as well, again only in
> the SATA context, not for SAS.

...since it happens with other drives, it may be something to do with the
host AHCI adapter. What are you using ? Do you get the same behaviour if
you use a different host with a different AHCI adapter ?

>=20
> Cheers,
> Peter
>=20
> -----CUT-----
> /dev/sde:
>=20
> ATA device, with non-removable media
>     Model Number:       WDC  WDS400T2B0A-00SM50

I know this vendor well :)

>     Serial Number:      2113CN420743
>     Firmware Revision:  415020WD
>     Media Serial Num:
>     Media Manufacturer:
>     Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II
> Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
> Standards:
>     Used: unknown (minor revision code 0x005e)
>     Supported: 11 10 9 8 7 6 5
>     Likely used: 11
> Configuration:
>     Logical        max    current
>     cylinders    16383    0
>     heads        16    0
>     sectors/track    63    0
>     --
>     LBA    user addressable sectors:   268435455
>     LBA48  user addressable sectors:  7814037168
>     Logical  Sector size:                   512 bytes
>     Physical Sector size:                   512 bytes
>     Logical Sector-0 offset:                  0 bytes
>     device size with M =3D 1024*1024:     3815447 MBytes
>     device size with M =3D 1000*1000:     4000787 MBytes (4000 GB)
>     cache/buffer size  =3D unknown
>     Form Factor: 2.5 inch
>     Nominal Media Rotation Rate: Solid State Device
> Capabilities:
>     LBA, IORDY(can be disabled)
>     Queue depth: 32
>     Standby timer values: spec'd by Standard, no device specific minimu=
m
>     R/W multiple sector transfer: Max =3D 1    Current =3D 1
>     Advanced power management level: disabled
>     DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>          Cycle time: min=3D120ns recommended=3D120ns
>     PIO: pio0 pio1 pio2 pio3 pio4
>          Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
> Commands/features:
>     Enabled    Supported:
>        *    SMART feature set
>             Security Mode feature set
>        *    Power Management feature set
>        *    Write cache
>        *    Look-ahead
>        *    WRITE_BUFFER command
>        *    READ_BUFFER command
>        *    DOWNLOAD_MICROCODE
>             Advanced Power Management feature set
>        *    48-bit Address feature set
>        *    Mandatory FLUSH_CACHE
>        *    FLUSH_CACHE_EXT
>        *    SMART error logging
>        *    SMART self-test
>        *    General Purpose Logging feature set
>        *    64-bit World wide name
>        *    WRITE_UNCORRECTABLE_EXT command
>        *    {READ,WRITE}_DMA_EXT_GPL commands
>        *    Segmented DOWNLOAD_MICROCODE
>             unknown 119[8]
>        *    Gen1 signaling speed (1.5Gb/s)
>        *    Gen2 signaling speed (3.0Gb/s)
>        *    Gen3 signaling speed (6.0Gb/s)
>        *    Native Command Queueing (NCQ)
>        *    Phy event counters
>        *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
>             DMA Setup Auto-Activate optimization
>             Device-initiated interface power management
>             Asynchronous notification (eg. media change)
>        *    Software settings preservation
>             Device Sleep (DEVSLP)
>        *    SANITIZE feature set
>        *    BLOCK_ERASE_EXT command
>        *    DOWNLOAD MICROCODE DMA command
>        *    WRITE BUFFER DMA command
>        *    READ BUFFER DMA command
>        *    Data Set Management TRIM supported (limit 8 blocks)
>        *    Deterministic read ZEROs after TRIM
> Security:
>     Master password revision code =3D 65534
>         supported
>     not    enabled
>     not    locked
>     not    frozen
>     not    expired: security count
>         supported: enhanced erase
>     2min for SECURITY ERASE UNIT. 2min for ENHANCED SECURITY ERASE UNIT=
.
> Logical Unit WWN Device Identifier: 5001b444a70c2c64
>     NAA        : 5
>     IEEE OUI    : 001b44
>     Unique ID    : 4a70c2c64
> Device Sleep:
>     DEVSLP Exit Timeout (DETO): 30 ms (drive)
>     Minimum DEVSLP Assertion Time (MDAT): 30 ms (drive)
> Checksum: correct
> -----CUT-----

--=20
Damien Le Moal
Western Digital Research

