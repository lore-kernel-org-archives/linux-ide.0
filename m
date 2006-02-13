From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Date: Mon, 13 Feb 2006 16:13:18 -0600
Message-ID: <4EAA9C9B-947B-493D-B3D9-CFA1EC0A71CA@kernel.crashing.org>
References: <58cb370e0602130235h3ab521cep47584ee634e8fc7f@mail.gmail.com> <Pine.LNX.4.44.0602131020370.30316-100000@gate.crashing.org> <58cb370e0602130853s4ce767c6j57337a9587cc2963@mail.gmail.com> <9E02DAB4-8DCE-42AA-8F47-080636F78E4C@kernel.crashing.org> <58cb370e0602131221k60e23cffo480fbec812b6560e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:1100 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030207AbWBMWND (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Feb 2006 17:13:03 -0500
In-Reply-To: <58cb370e0602131221k60e23cffo480fbec812b6560e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Feb 13, 2006, at 2:21 PM, Bartlomiej Zolnierkiewicz wrote:

> On 2/13/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Feb 13, 2006, at 10:53 AM, Bartlomiej Zolnierkiewicz wrote:
>>
>>> On 2/13/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>>>
>>>>>> +static void cfide_outsl(unsigned long port, void *addr, u32  
>>>>>> count)
>>>>>> +{
>>>>>> +       panic("outsl unsupported");
>>>>>> +}
>>>>>
>>>>> This will panic as soon as somebody tries to enable 32-bit I/O
>>>>> using hdparm.  Please add ide_hwif_t.no_io_32bit flag and teach
>>>>> ide-disk.c:ide_disk_setup() about it (separate patch).
>>>>
>>>> I'm not sure I follow this, can you expand.
>>>
>>> Do "hdparm -c 2 /dev/hdx" first and then read/write to the device
>>> and you should see it. :)
>>>
>>> We need to make "hdparm -c 2" (and "hdparm -c 3") unsupported
>>> (see how "io_32bit" setting is handled in ide_add_generic_settings()
>>> and how it can be read-only or read-write setting depending on the
>>> value of drive->no_io_32bit).
>>>
>>> To do this we need to set drive->no_io_32bit to 1 (see how
>>> ide_disk_setup() handles it).  Unfortunately 32-bit I/O capability
>>> is based on capabilities of both host and device so we have to
>>> add new flag hwif->no_io_32bit to indicate that host doesn't
>>> support 32-bit I/O.
>>
>> This all make sense, should I check for hwif->no_io_32bit in
>> idedisk_setup() and set drive->no_io_32bit to 1 if hwif->no_io_32bit
>> is 1 or do this the test in ide_add_generic_settings()?
>
> Good question.  idedisk_setup() seems more logical but in the current
> model "io_32bit" setting is still accessible without ide-disk  
> driver through
> /proc/ide/ interface so...
>
> Moreover the current drive->no_io_32bit code in ide-disk is wrong:
> * it shouldn't be overriding drive->no_io_32bit flag if it is 1
> * doing this in ide-disk may be too late w.r.t.  
> ide_add_generic_settings()
>
> Therefore your previous suggestion is the right one - the best place
> to deal with ->no_io_32bit is ide-probe.c - doing this for all  
> drives at
> the end of probe_hwif() should fix all above issues.

Now I'm confused.  If I understand the code, what I want is for the  
"io_32bit" setting to have its RW field set to SETTING_READ, such  
that drive->no_io_32bit can NOT be changed.  Additionally, I want it  
set to 1 if hwif->no_io_32bit is 1.

Are you saying that at the end of probe_hwif() I should iterate over  
the drives for that hwif and set drive->no_io_32bit to 1 if hwif- 
 >no_io_32bit is 1?  If so, can I do this in the last loop that  
already exists that iterates over the drives?

Will I not also want to test hwif->no_io_32bit in idedisk_setup() to  
ensure that it can only set driver->no_io_32bit to 0 if hwif- 
 >no_io32bit is 0?

- kumar

