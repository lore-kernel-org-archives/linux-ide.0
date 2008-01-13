From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 15:01:06 +0900
Message-ID: <4789A922.40005@gmail.com>
References: <200801051734.18088.marc@fallon.classyad.com> <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com> <200801121542.34435.bzolnier@gmail.com> <Pine.LNX.4.64.0801130031370.6579@classyad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:7617 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYAMGBM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 01:01:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2836217wah.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 22:01:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801130031370.6579@classyad.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Howard Zuckman <marc@fallon.classyad.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Marc Howard Zuckman wrote:
> On Sat, 12 Jan 2008, Bartlomiej Zolnierkiewicz wrote:
> 
>>
>> In "smart mode" controller takes care of mode programming.
>>
>>> Cc'ing Alan and Bartlomiej.  Guys, is this the smart mode problem?  Do
>>> ide and libata have this fixed in 2.6.24-rc?
>>
>> [ added Alan and myself ;) to cc: ]
>>
>> Marc, please also send output of 'hdparm --Istdout /dev/hde' command.
>>
> This is the output from hdparm with my non-working vanilla 2.6.23.12.
> 
> 
> /dev/hde:
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 2008 1301 0501 ****4721**** 0101 0005
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 496e 7465 6772 6174 6564
> 2054 6563 686e 6f6c 6f67 7920 4578 7072
> 6573 7320 496e 6320 2020 2020 2020 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 ffff 0fff 0000 0007
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 003f 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 9eae 12a1 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0001 0003 3133 2121 9111 0091 3266
> 0021 0021 0001 0505 0005 0500 0000 0005
> 0005 0005 0040 0000 0000 0000 0000 0000
> 0000 0000 0001 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000

Hmm... this is horrifying.

$ hdparm --Istdin < hdparm.out
ATA device, with non-removable media
        Model Number:       Integrated Technology Express Inc
        Serial Number:     G!
Standards:
        Likely used: 1
Configuration:
        Logical         max     current
        cylinders       0       0
        heads           0       0
        sectors/track   0       0
        --
        device size with M = 1024*1024:           0 MBytes
        device size with M = 1000*1000:           0 MBytes
Capabilities:
        IORDY not likely
        Cannot perform double-word IO
        R/W multiple sector transfer: not supported
        DMA: not supported
        PIO: pio0

The only thing which matches the number of sectors is at word 100 which
is in reserved area.  What's going on here?

-- 
tejun
