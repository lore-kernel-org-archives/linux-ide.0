From: Marc Howard Zuckman <marc@fallon.classyad.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 10:18:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801131007070.6552@classyad.com>
References: <200801051734.18088.marc@fallon.classyad.com>
 <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com>
 <200801121542.34435.bzolnier@gmail.com> <Pine.LNX.4.64.0801130031370.6579@classyad.com>
 <4789A922.40005@gmail.com> <20080113131201.7a06d38a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c-71-205-247-245.hsd1.mi.comcast.net ([71.205.247.245]:60030
	"EHLO fallon.classyad.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbYAMPRf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 10:17:35 -0500
In-Reply-To: <20080113131201.7a06d38a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Marc Howard Zuckman <marc@classyad.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Sun, 13 Jan 2008, Alan Cox wrote:

>
>> $ hdparm --Istdin < hdparm.out
>> ATA device, with non-removable media
>>         Model Number:       Integrated Technology Express Inc
>>         Serial Number:     G!
>> Standards:
>>         Likely used: 1
>> Configuration:
>>         Logical         max     current
>>         cylinders       0       0
>>         heads           0       0
>>         sectors/track   0       0
>>         --
>>         device size with M = 1024*1024:           0 MBytes
>>         device size with M = 1000*1000:           0 MBytes
>> Capabilities:
>>         IORDY not likely
>>         Cannot perform double-word IO
>>         R/W multiple sector transfer: not supported
>>         DMA: not supported
>>         PIO: pio0
>>
>> The only thing which matches the number of sectors is at word 100 which
>> is in reserved area.  What's going on here?
>
> Looks totally corrupt. Functioning ITE firmware RAID produces a fairly
> poor response which is why we fix up the DMA flag but does report the
> volume size correctly.
>
> What firmware rev is this mess coming from ?
>
The firmware revision was 1.7.1.93
I have the capacity to boot with firmware version 1.41.  I did this with
the 2.6.20 kernel and hdparm --Istdout /dev/hde produced this:


/dev/hde:
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 2008 1301 1501 1701 0101 0005
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 496e 7465 6772 6174 6564
2054 6563 686e 6f6c 6f67 7920 4578 7072
6573 7320 496e 6320 2020 2020 2020 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 ffff 0fff 0000 0007
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 9eae 12a1 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0001 0003 3133 2121 9111 0091 3266
0021 0021 0001 0505 0005 0500 0000 0005
0005 0005 0040 0000 0000 0000 0000 0000
0000 0000 0001 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

Interpreted by hdparm --Istdin, the meaning is the same.

Marc H. Zuckman
