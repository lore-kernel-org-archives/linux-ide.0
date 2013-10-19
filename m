From: Bruce Link <Bruce@1045.ca>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61
 chipset.
Date: Fri, 18 Oct 2013 19:04:37 -0500
Message-ID: <5261CC95.1050903__46683.4255298183$1382141674$gmane$org@1045.ca>
References: <520AB4D8.1000208@1045.ca> <520B210B.5040700@gmail.com> <520C01E8.9040302@1045.ca> <CADLC3L1uR=+mSj5MtgK9hKPjz-wOaVsw3W6woALq6SX4vO6wJQ@mail.gmail.com> <520D92C6.30009@1045.ca> <520FB3BA.7050302@1045.ca> <CADLC3L27QcScLgw4CBGkQ3tG5037CAgQJRdW5384=sL8cM8a3Q@mail.gmail.com> <5217FFB2.4050007@1045.ca> <CADLC3L0wXmVDgHPOFEkeiXD9sDUBg3tZePcJ-gRfoRN5-fXE1w@mail.gmail.com> <52180F76.3070803@1045.ca> <CADLC3L2NfS7N30zqu5zPgxnh-vcEUxyWX3v4W1bUHB=G2J5m9Q@mail.gmail.com> <5238F554.60708@1045.ca> <CADLC3L2unM8ZfuKm3hbfo3-Wp-yTRBK79H=s-K2EaoPNv+rOUQ@mail.gmail.com> <523A28BF.4020700@1045.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-05.shaw.ca ([64.59.134.13]:25313 "EHLO
	smtp-out-05.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab3JSAOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Oct 2013 20:14:24 -0400
In-Reply-To: <523A28BF.4020700@1045.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 1063474@bugs.launchpad.net

On 9/18/2013 5:27 PM, Bruce Link wrote:
> On 9/17/2013 8:40 PM, Robert Hancock wrote:
>> On Tue, Sep 17, 2013 at 6:35 PM, Bruce Link <Bruce@1045.ca> wrote:
>>>> Hello,
>>>>
>>>> On Fri, Sep 06, 2013 at 07:53:49PM -0600, Robert Hancock wrote:
>>>>>> Is there any more information I can supply that would be helpful=
?
>>>>> I'm not quite sure what the next step would be. It's quite possib=
le
>>>>> that the NVIDIA driver in Windows is doing some magic to work aro=
und
>>>>> the problem that we don't know about, but it's hard to say what t=
hat
>>>>> might be. The fact that the default drivers used in the WinPE boo=
t
>>>>> don't seem to work would tend to point toward some kind of hardwa=
re
>>>>> incompatibility issue.
>>>>>
>>>>> Tejun, think you poked with some of this stuff before - any ideas=
?
>>>> It has been years since I looked at MCP quirks, of which there are=
 too
>>>> many.  It's likely another quirk on the controller side that nvidi=
a
>>>> worked around somehow without telling anyone.  Given the history a=
nd
>>>> that nvidia is out of chipset market, I think it's highly unlikely=
 to
>>>> learn what the issue and workaround are without reverse engineerin=
g
>>>> it.  So, um, no idea.
>>>>
>>>> Thanks.
>>>>
>>>> --=20
>>>> tejun
>>>> --=20
>>>
>>> Robert,
>>>
>>> I've inquired about this problem with Allen Martin at Nvidia, he ha=
d=20
>>> the
>>> following reply:
>>>
>>> /--------SNIP---------------/
>>> Hi Bruce, I did work on the Windows SATA driver for those chipsets,=
=20
>>> so I=92m
>>> familiar with it. I=92m not aware of any of any timing workarounds =
for=20
>>> any
>>> devices in the driver, but it=92s certainly true that there are=20
>>> devices that
>>> have timing sensitivity, especially around the IDENTIFY command and=
=20
>>> it may
>>> inadvertently work with one driver and not another.
>>>
>>>  From the bug reports it looks like it=92s always timing out on a
>>> TEST_UNIT_READY command? I assume this is probably the first comman=
d=20
>>> sent
>>> down after IDENTIFY to check for presense of a CD in the drive? If=20
>>> so it=92s
>>> likely the drive is locked up and any command at that point will=20
>>> fail. If
>>> you want to test out the theory about it being a timing issue, I=20
>>> would stick
>>> some udelay()s in the identify code path, both before and after=20
>>> starting the
>>> transfer to see if it makes any difference. Also do you know if the=
=20
>>> driver
>>> does a PHY reset when it resets the link? If not, you can try doing=
=20
>>> that by
>>> writing a 0 to SControl and then restoring it with the original val=
ue.
>>>
>>> Hope this helps,
>>>
>>> -Allen
>>> /--------SNIP---------------/
>>>
>>> Does this provide any actionable information? I've tried searching=20
>>> for the
>>> proper location to impliment these delays in the sata_nv.c and=20
>>> libata-eh.c
>>> files but admittedly, am in over my head.
>> Don't think there's any earth-shaking revelations but it might be a
>> few things to try. First, though, apparently there is a firmware
>> update for this drive of at least one revision up (WL0G) available
>> from Lite-ON that you could try updating to. (You'll likely need to
>> use Windows for that.) Given that it seems broken in at least two
>> different environments on this controller, it's possible they fixed
>> something related in the drive.
> Robert,
>
> I can report that the new firmware for the drive does not solve the=20
> problem.
>
> watchtv@teevee:~$ dmesg |grep ata5
> [    1.090360] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma=20
> 0xc400 irq 20
> [    1.556044] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.564199] ata5.00: ATAPI: ATAPI   iHOS104, WL0G, max UDMA/100
> [    1.580140] ata5.00: configured for UDMA/100
> [    6.580035] ata5.00: qc timeout (cmd 0xa0)
> [    6.580043] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
> [    7.048042] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    7.072124] ata5.00: configured for UDMA/100
> [   12.072029] ata5.00: qc timeout (cmd 0xa0)
> [   12.072037] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
> [   12.072041] ata5: limiting SATA link speed to 1.5 Gbps
> [   12.072043] ata5.00: limiting speed to UDMA/100:PIO3
> [   12.540058] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   12.564141] ata5.00: configured for UDMA/100
> [   17.564038] ata5.00: qc timeout (cmd 0xa0)
> [   17.564045] ata5.00: TEST_UNIT_READY failed (err_mask=3D0x4)
> [   17.564048] ata5.00: disabled
> [   17.564063] ata5: hard resetting link
> [   17.564065] ata5: nv: skipping hardreset on occupied port
> [   18.032068] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   18.032082] ata5: EH complete
> watchtv@teevee:~$
>
> My apologies for not noticing the firmware update earlier. I do recal=
l=20
> checking at one time, though it may have been prior to Sept. 2011.
>
> Bruce
Robert,

Writing to you to bump this thread. Is there anything more I can do to=20
troubleshoot this issue?

Thanks
Bruce
