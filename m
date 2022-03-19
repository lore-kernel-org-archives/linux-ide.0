Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52DC433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 21:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiCSVt6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Mar 2022 17:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSVt5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Mar 2022 17:49:57 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Mar 2022 14:48:32 PDT
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [IPv6:2001:7c0:2041:24::a:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B819A54B
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 14:48:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 87677605E5;
        Sat, 19 Mar 2022 22:38:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
         h=content-transfer-encoding:content-type:content-type
        :in-reply-to:organization:from:from:references:content-language
        :subject:subject:user-agent:mime-version:date:date:message-id
        :received:received; s=dkim; i=@isd.uni-stuttgart.de; t=
        1647725904; x=1649464705; bh=jKyxKruslN7X+4W4eL1im9Bl9K7vW7C8zbL
        PzHyzRCo=; b=nQl91/DFSHPqZY61SOhsSh5Bqn5H4AojXu7ZtxsbOsTTAfl4Kjb
        Fvi4a4mR+e+bPPHBg1Mhm+iPl7JP7KCncA9knqa1860U9K614lC+VUaqEhi24cyS
        6woJXeiSKxBVS15bgjtA3R7NdyxNkpCn8fXHCGdm7lSgEvIiMizdtx86rTq2Y0cn
        l82AsbgIajZhfWrhnI7G4FKkBkm4ZQJ/slYCwzPNMdLYh3fQApS31loSPLfyLT0o
        NedS9qp7YdrpjLTqCzRl1swRYqZj9GvE+2uuCnk6xkBphQBocT7pPCqVMxPk+HFo
        qymI8akuVFeLADM8WC4SpSG2hfc/1XYA8JQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
        by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10031)
        with ESMTP id FbbGBCcOFUdn; Sat, 19 Mar 2022 22:38:24 +0100 (CET)
Received: from [192.168.8.7] (p4fd09f18.dip0.t-ipconnect.de [79.208.159.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA;
        Sat, 19 Mar 2022 22:38:24 +0100 (CET)
Message-ID: <6d614dac-ba46-655b-1ed6-35b075327d91@isd.uni-stuttgart.de>
Date:   Sat, 19 Mar 2022 22:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
Content-Language: de-DE
To:     =?UTF-8?Q?Reimar_D=c3=b6ffinger?= <Reimar.Doeffinger@gmx.de>,
        linux-ide@vger.kernel.org
References: <3D5F418D-D612-49A9-80DF-E61313FE006B () gmx ! de>
From:   Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>
Organization: Universitaet Stuttgart - ISD
In-Reply-To: <3D5F418D-D612-49A9-80DF-E61313FE006B () gmx ! de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

(I likely butchered that import into thunderbird).

On 19/03/2022 21:42, Reimar Döffinger wrote:
>> On 19 Mar 2022, at 21:31, Reimar Döffinger <Reimar.Doeffinger@gmx.de> wrote:
>>
>>
>> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
>> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.
>> I don't see any info on which kernel this happened with anywhere.
>> Because there was a bug that tried to use READ LOG DMA EXT even though
> DMA was not enabled.
>> That was fixed by a patch from me for 5.16 (and backports).
>> The behaviour you describe matches the possible symptoms of that bug.
>> So it would be good to know we're not blaming the drive for an already =
> fixed bug in the kernel...
>
> Ok, seems not the case, fix is in 5.4.160 and the first report was from
> 5.4.179 it seems.

I can provide more information. While I don't have the TiceRex's
Samsung 840 EVO 250GB SSD. I have my own Samsung EVO 120GB.
I flashed it long ago with the same new/latest firmware.

---
# hdparm -i /dev/sdb
/dev/sdb:

ATA device, with non-removable media
        Model Number:       Samsung SSD 840 EVO 120GB
        Serial Number:      XXXXXXXXXXXXXXXX
        Firmware Revision:  EXT0DB6Q
        Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
        Used: unknown (minor revision code 0x0039)
        Supported: 9 8 7 6 5
        Likely used: 9
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    16514064
        LBA    user addressable sectors:   234441648
        LBA48  user addressable sectors:   234441648
        Logical  Sector size:                   512 bytes
        Physical Sector size:                   512 bytes
        Logical Sector-0 offset:                  0 bytes
        device size with M = 1024*1024:      114473 MBytes
        device size with M = 1000*1000:      120034 MBytes (120 GB)
        cache/buffer size  = unknown
        Nominal Media Rotation Rate: Solid State Device
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 1   Current = 1
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    64-bit World wide name
                Write-Read-Verify feature set
           *    WRITE_UNCORRECTABLE_EXT command
           *    {READ,WRITE}_DMA_EXT_GPL commands
           *    Segmented DOWNLOAD_MICROCODE
           *    Gen1 signaling speed (1.5Gb/s)
           *    Gen2 signaling speed (3.0Gb/s)
           *    Gen3 signaling speed (6.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
           *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT  <=== !!!
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Asynchronous notification (eg. media change)
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Write Same (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
           *    Device encrypts all user data
           *    DOWNLOAD MICROCODE DMA command
           *    SET MAX SETPASSWORD/UNLOCK DMA commands
           *    WRITE BUFFER DMA command
           *    READ BUFFER DMA command
           *    Data Set Management TRIM supported (limit 8 blocks)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        2min for SECURITY ERASE UNIT. 8min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: XXXXXXXXXX
        NAA             : X
        IEEE OUI        : X
        Unique ID       : X
Checksum: correct
---

Mine also claims to have "READ_LOG_DMA_EXT equivalent to READ_LOG_EXT" enabled.
But yee, it's not working. This is with "Linux OpenWrt 5.10.104". Which is
5.10.104 and a lot of OpenWrt patches (but nothing related to
READ_LOG_(DMA_)EXT).

Cheers,
Christian
