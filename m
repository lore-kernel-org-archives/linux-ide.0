From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Mon, 03 Jan 2011 17:03:15 -0500
Message-ID: <4D2247A3.2060506@canonical.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com> <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53815 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab1ACWDT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 17:03:19 -0500
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1PZsUo-0001xM-2L
	for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 22:03:18 +0000
Received: from c-75-67-45-93.hsd1.nh.comcast.net ([75.67.45.93] helo=[192.168.15.4])
	by hutte.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <peter.petrakis@canonical.com>)
	id 1PZsUn-00012n-M2
	for linux-ide@vger.kernel.org; Mon, 03 Jan 2011 22:03:18 +0000
In-Reply-To: <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>



On 01/03/2011 04:24 PM, Greg Freemyer wrote:
> On Mon, Jan 3, 2011 at 2:30 PM, Peter M. Petrakis
> <peter.petrakis@canonical.com> wrote:
>> Hi,
>>
>> On 12/30/2010 10:58 AM, Greg Freemyer wrote:
>>> All,
>>>
>>> Per T13/1699-D Revision 4a (from May 2007) word 217 of the identify
>>> block should be populated with a "1" to identify non-rotating media.
>>>
>>> http://www.t13.org/Documents/UploadedDocuments/docs2007/D1699r4a-ATA8-ACS.pdf
>>>
>>> Does anyone know if that is a reliable field?
>>>
>>> Specifically there are two separate issues:
>>>
>>> 1) Are all devices reporting a 1 in field 217 non-rotating?
>>> 2) Are all production non-rotating devices populating that field with a 1.
>>>
>>> Is there some other reliable mechanism for identifying a SSD?
>>>
>>
>> Not really, the manufacturer needs to adhere to the spec they're claiming
>> to honor and we should politely notify them when we find that it's inconsistent.
>> It's technically a firmware bug if it's ATA-8 and that bit isn't set right.
>>
>> If you're having trouble identifying SSDs pre ATA-8, you can use this simple
>> patch I introduced a while back.
>>
>> http://www.spinics.net/lists/linux-ide/msg38944.html
>>
>> and blacklist the offending drive into reporting itself as SSD when interrogated
>> via SCSI.
>>
>> If you search around, you'll find an earlier thread about quirking SSDs by using
>> heuristics like search for the word "flash" in the device name and other hints but
>> the patch set never went anywhere. It's a ugly problem, there's so many devices
>> out there ahead of the spec that are SSD, with no sure fire way to determine that
>> they really are. Supporting a full blacklist of them would turn libata-core.c into
>> a dumping ground for potentially 100s of pre ATA-8 storage devices. I don't think
>> anyone wants to maintain that.
>>
>> Peter
> 
> Peter,
> 
> Thanks.  I have a client that needs to recognize SSDs from userspace
> and I missed the ABI.
> 
> I was looking for the userspace ABI to be in /sys/block like the
> topology stuff is, so I missed the userspace ABI and was confused.

Ah you mean /sys/block/sda/queue/rotational.

> Now that I've found in, I'm confused by ata_id_rotation_rate()
> trusting the rotation_rate of 1 being valid for all ATA 7 and ATA 8
> devices.
> 
> === cut & paste from ata.h
> static inline int ata_id_rotation_rate(const u16 *id)
> {
>         u16 val = id[217];
>         if (ata_id_major_version(id) < 7 || val == 0 || val == 0xffff)
>                 return 0;
> 
>         if (val > 1 && val < 0x401)
>                 return 0;
> 
>         return val;
> }
> ===

Hmm, that may be but that value still needs to be valid, meaning, it's
either 1, or it's an RPM value. What does your raw IDENTIFY DEVICE output
say? This code accomidates ATA-7 vendors who had current draft specs to
"do the right thing" with the reserved block.

> I thought rotational_rate set to 1 to indicate a SSD was only valid
> for ATA8 devices?

Strictly speaking yes.

> I'll have to go back and read the older thread you talked about, but
> is there a plan for ATA7 devices?  Is it in general to trust word 217,
> or what.

Good thing I keep notes:
http://marc.info/?l=linux-ide&m=126677421807814&w=2

As you can see, my trivial patch is loosely based off of it.

> If I find a SSD device that is not setting word 217 correctly, and I
> want to get the kernel to address it correctly, should I just add to
> your list and cause ATA_HORKAGE_NONROT to be set?

Yup, just add the device name as reported by IDENTIFY DEVICE to the list.
Then the rotational bit in sysfs should be set.

> Or is the concern it will get unwieldy too fast if everyone used that list?

If you look at my post, you'll note that no one ever commented on it, and I
got too busy to follow up. So I really don't know where the maintainers stand.
The speculation of unwieldy quirk table management is my own opinion, though
I'm sure it's on everyone's mind. I know I wouldn't want to be in that position.
Just look at the quirk tables the sound codec drivers have to put up with to
get an idea of the volume of devices libata would deal with if it officially
supported this quirk.

> Thanks
> Greg

Peter


> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
