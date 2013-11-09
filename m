From: Bruce Link <Bruce@1045.ca>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61
 chipset.
Date: Sat, 09 Nov 2013 15:02:48 -0600
Message-ID: <527EA2F8.50209@1045.ca>
References: <520AB4D8.1000208@1045.ca> <520B210B.5040700@gmail.com> <520C01E8.9040302@1045.ca> <CADLC3L1uR=+mSj5MtgK9hKPjz-wOaVsw3W6woALq6SX4vO6wJQ@mail.gmail.com> <520D92C6.30009@1045.ca> <520FB3BA.7050302@1045.ca> <CADLC3L27QcScLgw4CBGkQ3tG5037CAgQJRdW5384=sL8cM8a3Q@mail.gmail.com> <5217FFB2.4050007@1045.ca> <CADLC3L0wXmVDgHPOFEkeiXD9sDUBg3tZePcJ-gRfoRN5-fXE1w@mail.gmail.com> <52180F76.3070803@1045.ca> <CADLC3L2NfS7N30zqu5zPgxnh-vcEUxyWX3v4W1bUHB=G2J5m9Q@mail.gmail.com> <5238F554.60708@1045.ca> <CADLC3L2unM8ZfuKm3hbfo3-Wp-yTRBK79H=s-K2EaoPNv+rOUQ@mail.gmail.com> <523A28BF.4020700@1045.ca> <5261CC95.1050903@1045.ca> <CADLC3L3Que7Ur1r6A6QHm2Fq-_k-M7uauunDQPiXTF9wXQjD1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-04.shaw.ca ([64.59.134.12]:58176 "EHLO
	smtp-out-04.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756751Ab3KIVDK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Nov 2013 16:03:10 -0500
In-Reply-To: <CADLC3L3Que7Ur1r6A6QHm2Fq-_k-M7uauunDQPiXTF9wXQjD1A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 1063474@bugs.launchpad.net

On 10/21/2013 8:17 PM, Robert Hancock wrote:
> On Fri, Oct 18, 2013 at 6:04 PM, Bruce Link <Bruce@1045.ca> wrote:
>> On 9/18/2013 5:27 PM, Bruce Link wrote:
>>> On 9/17/2013 8:40 PM, Robert Hancock wrote:
>>>> On Tue, Sep 17, 2013 at 6:35 PM, Bruce Link <Bruce@1045.ca> wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Fri, Sep 06, 2013 at 07:53:49PM -0600, Robert Hancock wrote:
>>>>>>>> Is there any more information I can supply that would be helpf=
ul?
>>>>>>> I'm not quite sure what the next step would be. It's quite poss=
ible
>>>>>>> that the NVIDIA driver in Windows is doing some magic to work a=
round
>>>>>>> the problem that we don't know about, but it's hard to say what=
 that
>>>>>>> might be. The fact that the default drivers used in the WinPE b=
oot
>>>>>>> don't seem to work would tend to point toward some kind of hard=
ware
>>>>>>> incompatibility issue.
>>>>>>>
>>>>>>> Tejun, think you poked with some of this stuff before - any ide=
as?
>>>>>> It has been years since I looked at MCP quirks, of which there a=
re too
>>>>>> many.  It's likely another quirk on the controller side that nvi=
dia
>>>>>> worked around somehow without telling anyone.  Given the history=
 and
>>>>>> that nvidia is out of chipset market, I think it's highly unlike=
ly to
>>>>>> learn what the issue and workaround are without reverse engineer=
ing
>>>>>> it.  So, um, no idea.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> --
>>>>>> tejun
>>>>>> --
>>>>>
>>>>> Robert,
>>>>>
>>>>> I've inquired about this problem with Allen Martin at Nvidia, he =
had the
>>>>> following reply:
>>>>>
>>>>> /--------SNIP---------------/
>>>>> Hi Bruce, I did work on the Windows SATA driver for those chipset=
s, so
>>>>> I=92m
>>>>> familiar with it. I=92m not aware of any of any timing workaround=
s for any
>>>>> devices in the driver, but it=92s certainly true that there are d=
evices
>>>>> that
>>>>> have timing sensitivity, especially around the IDENTIFY command a=
nd it
>>>>> may
>>>>> inadvertently work with one driver and not another.
>>>>>
>>>>>   From the bug reports it looks like it=92s always timing out on =
a
>>>>> TEST_UNIT_READY command? I assume this is probably the first comm=
and
>>>>> sent
>>>>> down after IDENTIFY to check for presense of a CD in the drive? I=
f so
>>>>> it=92s
>>>>> likely the drive is locked up and any command at that point will =
fail.
>>>>> If
>>>>> you want to test out the theory about it being a timing issue, I =
would
>>>>> stick
>>>>> some udelay()s in the identify code path, both before and after s=
tarting
>>>>> the
>>>>> transfer to see if it makes any difference. Also do you know if t=
he
>>>>> driver
>>>>> does a PHY reset when it resets the link? If not, you can try doi=
ng that
>>>>> by
>>>>> writing a 0 to SControl and then restoring it with the original v=
alue.
>>>>>
>>>>> Hope this helps,
>>>>>
>>>>> -Allen
>>>>> /--------SNIP---------------/
>>>>>
>>>>> Does this provide any actionable information? I've tried searchin=
g for
>>>>> the
>>>>> proper location to impliment these delays in the sata_nv.c and
>>>>> libata-eh.c
>>>>> files but admittedly, am in over my head.
>>>> Don't think there's any earth-shaking revelations but it might be =
a
>>>> few things to try. First, though, apparently there is a firmware
>>>> update for this drive of at least one revision up (WL0G) available
>>>> from Lite-ON that you could try updating to. (You'll likely need t=
o
>>>> use Windows for that.) Given that it seems broken in at least two
>>>> different environments on this controller, it's possible they fixe=
d
>>>> something related in the drive.
>>> Robert,
>>>
>>> I can report that the new firmware for the drive does not solve the
>>> problem.
>>>
>>> watchtv@teevee:~$ dmesg |grep ata5
>>> [    1.090360] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0x=
c400
>>> irq 20
>>> [    1.556044] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 30=
0)
>>> [    1.564199] ata5.00: ATAPI: ATAPI   iHOS104, WL0G, max UDMA/100
>>> [    1.580140] ata5.00: configured for UDMA/100
>>> [    6.580035] ata5.00: qc timeout (cmd 0xa0)
>>> [    6.580043] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
>>> [    7.048042] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 30=
0)
>>> [    7.072124] ata5.00: configured for UDMA/100
>>> [   12.072029] ata5.00: qc timeout (cmd 0xa0)
>>> [   12.072037] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
>>> [   12.072041] ata5: limiting SATA link speed to 1.5 Gbps
>>> [   12.072043] ata5.00: limiting speed to UDMA/100:PIO3
>>> [   12.540058] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 30=
0)
>>> [   12.564141] ata5.00: configured for UDMA/100
>>> [   17.564038] ata5.00: qc timeout (cmd 0xa0)
>>> [   17.564045] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
>>> [   17.564048] ata5.00: disabled
>>> [   17.564063] ata5: hard resetting link
>>> [   17.564065] ata5: nv: skipping hardreset on occupied port
>>> [   18.032068] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 30=
0)
>>> [   18.032082] ata5: EH complete
>>> watchtv@teevee:~$
>>>
>>> My apologies for not noticing the firmware update earlier. I do rec=
all
>>> checking at one time, though it may have been prior to Sept. 2011.
>>>
>>> Bruce
>> Robert,
>>
>> Writing to you to bump this thread. Is there anything more I can do =
to
>> troubleshoot this issue?
> A couple of things you could try:
>
> -Does the behavior change if you boot with vs. without a disc in the =
drive?
>
> -You could try building a kernel with something like adding
> mdelay(1000) at the start of the atapi_eh_clear_ua function in
> drivers/ata/libata-eh.c.You should see an extra 1 second delay (so at
> the very least it should take 6 seconds to timeout rather than 5).  I=
f
> that changes anything then perhaps some kind of timing quirk would
> help the problem.
Robert,

I've recompiled the kernel with the mdelay you suggested. Using that=20
kernel, I booted the machine both with and without a BD disk in the=20
drive. It didn't work in either case, but the errors were slightly=20
different. My results are below.

Is there anything else that could be tried?


With a BD disc in the drive:
watchtv@teevee:~$ dmesg | grep ata5
[    1.068078] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400=
=20
irq 23
[    1.536031] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.544131] ata5.00: ATAPI: ATAPI   iHOS104, WL0G, max UDMA/100
[    1.560112] ata5.00: configured for UDMA/100
[    7.552029] ata5.00: qc timeout (cmd 0xa0)
[    7.552036] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
[    8.020051] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.044122] ata5.00: configured for UDMA/100
[   32.816043] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6=20
frozen
[   32.816063] ata5.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0=20
dma 96 in
[   32.816066] ata5.00: status: { DRDY }
[   32.816072] ata5: hard resetting link
[   32.816074] ata5: nv: skipping hardreset on occupied port
[   33.284042] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.308141] ata5.00: configured for UDMA/100
[   39.296025] ata5.00: qc timeout (cmd 0xa0)
[   39.296032] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
[   39.296038] ata5: hard resetting link
[   39.296040] ata5: nv: skipping hardreset on occupied port
[   39.764040] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   39.788137] ata5.00: configured for UDMA/100
[   45.776035] ata5.00: qc timeout (cmd 0xa0)
[   45.776042] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
[   45.776047] ata5: limiting SATA link speed to 1.5 Gbps
[   45.776050] ata5.00: limiting speed to UDMA/100:PIO3
[   45.776058] ata5: hard resetting link
[   45.776060] ata5: nv: skipping hardreset on occupied port
[   46.244050] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   46.268138] ata5.00: configured for UDMA/100

Without a BD disc in the drive:
watchtv@teevee:~$ dmesg | grep ata5
[    1.070412] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400=
=20
irq 20
[    1.536043] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.544204] ata5.00: ATAPI: ATAPI   iHOS104, WL0G, max UDMA/100
[    1.560149] ata5.00: configured for UDMA/100
[    7.552027] ata5.00: qc timeout (cmd 0xa0)
[    7.552033] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x5)
[    8.020034] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.044127] ata5.00: configured for UDMA/100
[   14.037175] ata5.00: qc timeout (cmd 0xa0)
[   14.037183] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x5)
[   14.037187] ata5: limiting SATA link speed to 1.5 Gbps
[   14.037190] ata5.00: limiting speed to UDMA/100:PIO3
[   14.504069] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   14.528288] ata5.00: configured for UDMA/100
[   20.528052] ata5.00: qc timeout (cmd 0xa0)
[   20.528060] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x5)
[   20.528062] ata5.00: disabled
[   20.528077] ata5: hard resetting link
[   20.528079] ata5: nv: skipping hardreset on occupied port
[   20.996047] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   20.996062] ata5: EH complete


Thanks
Bruce
