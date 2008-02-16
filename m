From: Mark Lord <liml@rtr.ca>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Sat, 16 Feb 2008 10:46:57 -0500
Message-ID: <47B70571.4060303@rtr.ca>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com> <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com> <47B499F2.1010306@rtr.ca> <47B5CC39.7020302@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3547 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbYBPPq7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Feb 2008 10:46:59 -0500
In-Reply-To: <47B5CC39.7020302@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Liu <richliu.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Richard Liu wrote:
>> Dear Mark:
>>
>> 2008/2/15, Mark Lord <liml@rtr.ca>:
>>> Richard Liu wrote:
>>>  > Hello all:
>>>  >
>>>  >      I bought a Seagate ES.2 ST31000340NS (1000GB) and run at Gentoo
>>>  > Linux kernel 2.6.24.
>>>  > But Linux kernel report the disk size only 33MB.
>>>  > I tried Intel ICH5 and Sil3112, but get the same result.
>>>  >
>>>  > I don't know this issue was caused by libsata or scsi layer .
>>>
>>> ..
>>>
>>>> hdparm
>>>  >  ==
>>>  > hdparm -i /dev/sdc
>>>  >
>>>  > /dev/sdc:
>>>  >
>>>  >  Model=ST31000340NS                            , FwRev=SN04    ,
>>>  > SerialNo=            9QJ09BJ4
>>>  >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>>>  >   RawCHS=64/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>>>  >  BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
>>>  >  CurCHS=64/16/63, CurSects=64512, LBA=yes, LBAsects=65134
>>>  >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>>>  >   PIO modes:  pio0 pio1 pio2 pio3 pio4
>>>  >  DMA modes:  mdma0 mdma1 mdma2
>>>  >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>>>  >  AdvancedPM=no WriteCache=enabled
>>>  >  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  
>>> ATA/ATAPI-4,5,6
>>>  >
>>>  >  * signifies the current active mode
>>>
>>> ..
>>>
>>>  Nothing wrong there, but I would really like/prefer to see the 
>>> output from:
>>>
>>>     hdparm --Istdout /dev/sdc
>>>
>>>
>>>  thanks.
>>>
>>
>>  # hdparm --Istdout /dev/sdc
>>
>> /dev/sdc:
>> 0c5a 0040 c837 0010 0000 0000 003f 0000
>> 0000 0000 2020 2020 2020 2020 2020 2020
>> 3951 4a30 3942 4a34 0000 0000 0004 534e
>> 3034 2020 2020 5354 3331 3030 3033 3430
>> 4e53 2020 2020 2020 2020 2020 2020 2020
>> 2020 2020 2020 2020 2020 2020 2020 8010
>> 0000 2f00 4000 0200 0200 0007 0040 0010
>> 003f fc00 0000 0110 fe6e 0000 0000 0007
>> 0003 0078 0078 0078 0078 0000 0000 0000
>> 0000 0000 0000 001f 0502 0000 0040 0040
>> 0070 001b 346b 7d01 4123 3468 bc01 4103
>> 207f 0000 0000 fefe fffe 0000 fe00 0000
>> 0000 0000 0000 0000 fe6e 0000 0000 0000
>> 0000 0000 0000 0000 5000 c500 09b9 0136
>> 0000 0000 0000 0000 0000 0000 0000 4006
>> 4006 0000 0000 0000 0000 0000 0000 0000
>> 0021 6db0 7470 6db0 7470 0000 0002 0140
>> 0100 5000 3c06 3c0a 0000 003c 0000 0008
>> 0000 0000 000f 0280 0000 0000 000a 0000
>> 0000 0000 0000 0000 0000 0000 2700 8000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 003d 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 1c20 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 0000
>> 0000 0000 0000 0000 0000 0000 0000 e9a5
> ..
> 
> Thanks.  By running the above data through hdparm --Istdin,
> I see that the drive is indeed identifying itself as a 33MB drive.
> 
> Probably because it has been told to do so by either the factory defaults,
> or the BIOS, having enabled these features (which can cause it to report
> fake values for various things):
> 
>           *    Host Protected Area feature set
>           *    Device Configuration Overlay feature set
> 
> So that's why the 1TB drive appears as a 33MB drive.
> 
> In the near future, I will be enhancing hdparm to query more
> detailed data from underneath those artificial features.
> 
> But you'll have to enable the entire 1TB capacity if you want Linux to 
> use it.
> It is currently disabled in the drive, and Linux respects that.
..

Okay, hdparm-8.1 is now available from sourceforge.net.
Download it, build it ("make"), and see what you get from "hdparm -N /dev/sdc"

Thanks
