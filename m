Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A29C54EE9
	for <linux-ide@archiver.kernel.org>; Fri,  2 Sep 2022 06:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiIBGe3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiIBGe1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Sep 2022 02:34:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B58BA9C2
        for <linux-ide@vger.kernel.org>; Thu,  1 Sep 2022 23:34:26 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id y15so781428qvn.2
        for <linux-ide@vger.kernel.org>; Thu, 01 Sep 2022 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=khvwhmOIZrOsrGo/FJiUKapr++R6VC359lslyQ7OVsM=;
        b=oH0nFTkY2vJ0FLMWrMEUNqaJ/J4ESJQRfhmz8UdrENr48s/f9roqVxliVZECUkhogu
         nTBL/OhMUiKiKuh+iPtTVLYCy6WttGJt+cO/UwiPXHHCs0LreGQJbZbxJUHaG90mTrep
         A9vq23BT+lwvKAMe9YV7X8pmI7CJbP/ylEzSkApmTTvcZI7lxoPjMHEuiISqo2vsy+EI
         D/9mCq04n1lqTSiqjTdNHYgjSygq+PomPLnWdSSuQs9J/rHN/8gyOSJZT3HFghB4cUBt
         i7HcOlpT3+YaxYyZMOFCY4wP5hzc1HzbrZFoC2R3SJg6kqKUbXIeicWlt7/WyCho4HfV
         kY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=khvwhmOIZrOsrGo/FJiUKapr++R6VC359lslyQ7OVsM=;
        b=XUGdLwWBlwzBJfJWfp1XN9vmucuRssF7f5rspsddzyJf6pH0FFz9lqc66o3VLWoqEP
         33M0SQuHM/yt0/7pnjl+KCw1rWKgSVGohal0Vicb2yIVNk+PlY/SpNZaT2pBC0jgEOhY
         3VcDBDch4V4rQPq8lJqsCr8himJTC/p24sZkgYFB3bBv34PmIDsLIzU6SzXdqMNvl713
         YqeDvsm3PdN7clXJjR0IpZzKUxk4j5TtO0r8ydkyuXv+9BbiHEeveeXH/CVeh77Kb0V7
         Ldh/SPiq+lfwKqv4t63zxDsKFiScfU8j388LnFhVyF6gePYM1TbCGhipqVLlaEkST74I
         2OoA==
X-Gm-Message-State: ACgBeo3T8nSrusZpja6pHoGZGQV0zFUqIEk68KGURucpa6W2J893RxDw
        fiRSlb0XMnofeioKD/jOeYIDFf+QKQUz236/X1og1m9D4Fk=
X-Google-Smtp-Source: AA6agR7lA0ftRUfA+GaNwo3J/FDZbsA23BCmqayldOx3JJAp+i+IArKjF0cvFgJvBNbXAHKd9nBi30wWfYQ/o9X/PJI=
X-Received: by 2002:a05:6214:1cc5:b0:498:5d76:69f with SMTP id
 g5-20020a0562141cc500b004985d76069fmr27337102qvd.33.1662100465762; Thu, 01
 Sep 2022 23:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com> <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com> <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com> <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com> <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
 <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
 <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com> <ed854cd3-3456-4dfc-e589-40f4946bb0e7@suse.de>
 <396b2bb5-533f-2a9c-66f2-c92465d54df1@opensource.wdc.com>
In-Reply-To: <396b2bb5-533f-2a9c-66f2-c92465d54df1@opensource.wdc.com>
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Fri, 2 Sep 2022 08:34:14 +0200
Message-ID: <CAHXXO6ECthyiomdCCR8YaR6O8tq8XhhHn-sX3nRTnjNYkWCVLw@mail.gmail.com>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Sep 2, 2022 at 4:35 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> Your drive seems to be an exception to my (1) statement and the error it
> returns seems weird enough that the stat_table ends up being used.
> Could you send a dmesg output of a failed command so that we can see the
> err_mask etc info for the failed command ? And it would be good to add a
> print of the drv_stat and drv_err parameters passed to
> ata_to_sense_error() for the failures you are seeing. That would help
> trying to figure out what your drive is attempting to signal.

I don't think the drive wants to "signal" anything, instead it simply
"disappears" at some point. The "original" error is "Emask 0x4
(timeout)". So here's an example from early on when I had not made
many kernel changes yet:

-----CUT-----
...
[  516.296397] ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  516.296399] ata9.00: failed command: WRITE DMA
[  516.296402] ata9.00: cmd ca/00:23:51:03:4b/00:00:00:00:00/ed tag 4
dma 17920 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  516.296403] ata9.00: status: { DRDY }
...
[  516.761214] ata9: translated ATA stat/err 0x40/00 to SCSI
SK/ASC/ASCQ 0x5/21/04
[  516.761215] ata9.00: device reported invalid CHS sector 0
[  516.761220] sd 8:0:0:0: [sdk] tag#4 scsi_eh_8: flush finish cmd
[  516.761224] sd 8:0:0:0: [sdk] tag#4 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[  516.761226] sd 8:0:0:0: [sdk] tag#4 Sense Key : Illegal Request [current]
[  516.761228] sd 8:0:0:0: [sdk] tag#4 Add. Sense: Unaligned write command
[  516.761229] sd 8:0:0:0: [sdk] tag#4 CDB: Write(16) 8a 00 00 00 00
00 0d 4b 03 51 00 00 00 23 00 00
...
-----CUT-----

That "translated" line is only output because I changed "if (verbose)"
to "if (1)" in that kernel. Also note the bizarre "CHS" error which
only happens on some of these, not all; I had mentioned before that I
am trying to track down how it happens that the LBA bit suddenly
disappears (it might have to do with the hardreset being in process at
this point and this message racing against the new IDENTIFY?). Using
the trace facility I can *sometimes* see the command being issued and
then 30 seconds later the timeout happening; sometimes I just get the
timeout and I *cannot* find when the command was issued in the trace,
another thing that seems bizarre to me.

Note that I didn't ask for help with that intentionally, I still think
that I am too far away from a proper diagnosis to have a fruitful
conversation about where the timeouts originate and why. We've checked
against power issues and the like, and again, this happens only when
the drive sits behind a SATA controller, not when it's behind a SAS
controller.

> Also, please send the output of "hdparm -I" for that SSD please, so that
> we have information about what standard it is (supposedly) following.

See below, but I don't think the specific drive is relevant. The same
"problem" shows up with a different brand/model as well, again only in
the SATA context, not for SAS.

Cheers,
Peter

-----CUT-----
/dev/sde:

ATA device, with non-removable media
    Model Number:       WDC  WDS400T2B0A-00SM50
    Serial Number:      2113CN420743
    Firmware Revision:  415020WD
    Media Serial Num:
    Media Manufacturer:
    Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II
Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
    Used: unknown (minor revision code 0x005e)
    Supported: 11 10 9 8 7 6 5
    Likely used: 11
Configuration:
    Logical        max    current
    cylinders    16383    0
    heads        16    0
    sectors/track    63    0
    --
    LBA    user addressable sectors:   268435455
    LBA48  user addressable sectors:  7814037168
    Logical  Sector size:                   512 bytes
    Physical Sector size:                   512 bytes
    Logical Sector-0 offset:                  0 bytes
    device size with M = 1024*1024:     3815447 MBytes
    device size with M = 1000*1000:     4000787 MBytes (4000 GB)
    cache/buffer size  = unknown
    Form Factor: 2.5 inch
    Nominal Media Rotation Rate: Solid State Device
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, no device specific minimum
    R/W multiple sector transfer: Max = 1    Current = 1
    Advanced power management level: disabled
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=120ns recommended=120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    DOWNLOAD_MICROCODE
            Advanced Power Management feature set
       *    48-bit Address feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    SMART self-test
       *    General Purpose Logging feature set
       *    64-bit World wide name
       *    WRITE_UNCORRECTABLE_EXT command
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
            unknown 119[8]
       *    Gen1 signaling speed (1.5Gb/s)
       *    Gen2 signaling speed (3.0Gb/s)
       *    Gen3 signaling speed (6.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Phy event counters
       *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
            DMA Setup Auto-Activate optimization
            Device-initiated interface power management
            Asynchronous notification (eg. media change)
       *    Software settings preservation
            Device Sleep (DEVSLP)
       *    SANITIZE feature set
       *    BLOCK_ERASE_EXT command
       *    DOWNLOAD MICROCODE DMA command
       *    WRITE BUFFER DMA command
       *    READ BUFFER DMA command
       *    Data Set Management TRIM supported (limit 8 blocks)
       *    Deterministic read ZEROs after TRIM
Security:
    Master password revision code = 65534
        supported
    not    enabled
    not    locked
    not    frozen
    not    expired: security count
        supported: enhanced erase
    2min for SECURITY ERASE UNIT. 2min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5001b444a70c2c64
    NAA        : 5
    IEEE OUI    : 001b44
    Unique ID    : 4a70c2c64
Device Sleep:
    DEVSLP Exit Timeout (DETO): 30 ms (drive)
    Minimum DEVSLP Assertion Time (MDAT): 30 ms (drive)
Checksum: correct
-----CUT-----
