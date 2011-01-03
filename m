From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Mon, 3 Jan 2011 16:24:54 -0500
Message-ID: <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com> <4D2223BF.8090901@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55650 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab1ACVZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 16:25:15 -0500
Received: by iyi12 with SMTP id 12so12438739iyi.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 13:25:15 -0800 (PST)
In-Reply-To: <4D2223BF.8090901@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Jan 3, 2011 at 2:30 PM, Peter M. Petrakis
<peter.petrakis@canonical.com> wrote:
> Hi,
>
> On 12/30/2010 10:58 AM, Greg Freemyer wrote:
>> All,
>>
>> Per T13/1699-D Revision 4a (from May 2007) word 217 of the identify
>> block should be populated with a "1" to identify non-rotating media.
>>
>> http://www.t13.org/Documents/UploadedDocuments/docs2007/D1699r4a-ATA8-ACS.pdf
>>
>> Does anyone know if that is a reliable field?
>>
>> Specifically there are two separate issues:
>>
>> 1) Are all devices reporting a 1 in field 217 non-rotating?
>> 2) Are all production non-rotating devices populating that field with a 1.
>>
>> Is there some other reliable mechanism for identifying a SSD?
>>
>
> Not really, the manufacturer needs to adhere to the spec they're claiming
> to honor and we should politely notify them when we find that it's inconsistent.
> It's technically a firmware bug if it's ATA-8 and that bit isn't set right.
>
> If you're having trouble identifying SSDs pre ATA-8, you can use this simple
> patch I introduced a while back.
>
> http://www.spinics.net/lists/linux-ide/msg38944.html
>
> and blacklist the offending drive into reporting itself as SSD when interrogated
> via SCSI.
>
> If you search around, you'll find an earlier thread about quirking SSDs by using
> heuristics like search for the word "flash" in the device name and other hints but
> the patch set never went anywhere. It's a ugly problem, there's so many devices
> out there ahead of the spec that are SSD, with no sure fire way to determine that
> they really are. Supporting a full blacklist of them would turn libata-core.c into
> a dumping ground for potentially 100s of pre ATA-8 storage devices. I don't think
> anyone wants to maintain that.
>
> Peter

Peter,

Thanks.  I have a client that needs to recognize SSDs from userspace
and I missed the ABI.

I was looking for the userspace ABI to be in /sys/block like the
topology stuff is, so I missed the userspace ABI and was confused.

Now that I've found in, I'm confused by ata_id_rotation_rate()
trusting the rotation_rate of 1 being valid for all ATA 7 and ATA 8
devices.

=== cut & paste from ata.h
static inline int ata_id_rotation_rate(const u16 *id)
{
        u16 val = id[217];
        if (ata_id_major_version(id) < 7 || val == 0 || val == 0xffff)
                return 0;

        if (val > 1 && val < 0x401)
                return 0;

        return val;
}
===

I thought rotational_rate set to 1 to indicate a SSD was only valid
for ATA8 devices?

I'll have to go back and read the older thread you talked about, but
is there a plan for ATA7 devices?  Is it in general to trust word 217,
or what.

If I find a SSD device that is not setting word 217 correctly, and I
want to get the kernel to address it correctly, should I just add to
your list and cause ATA_HORKAGE_NONROT to be set?

Or is the concern it will get unwieldy too fast if everyone used that list?

Thanks
Greg
