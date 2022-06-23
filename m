Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B105C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Jun 2022 10:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiFWKhw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiFWKhv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2022 06:37:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D64B1C7
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655980669; x=1687516669;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VfgPtM/PPdX4UbS9Bl5+NNKpDesfaBVvgbvBXUlzqNs=;
  b=YQ7W6ZsIJsLHi50xNW4+3Qyg+wD+Hg9N/YeDxqoJ7/mKTNTJhGyYRAxq
   P6o9pzvc5G9DjHzCmrduRkZBcuXi7EWDjLlQN2NZLmeG1Gst08zm60Zd/
   7iafSa/x/V8hBOVWeM+jPphkNLHbN4bEMtMCDUIJverFJdVsZ4jHpy6z1
   qhHfbX/P0QckTgWl+WxbajIuFGjfYLbVoUW76+kOIi3HMgGJj31lhX7ec
   Ue5+xUeotNKS5nh9wVzJqboaK2QtZigaHkkiAbDwUgpCAfih23x05zmhn
   brM0iyX2rWMvrLoSyUsJYXlGKPBwtRNo+qgh5DT1HZMq2X+dqSCdjxgvG
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="316017214"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 18:37:48 +0800
IronPort-SDR: ZJl89qLipY7VvFdD8QT9fxREaCn7Mv3ozuXv+t91eKKV4kE4BWVJznM4/31gjr2m86ne0WGJgJ
 IIixjG9obkjY+RAAxsmNMGt/cZ1gRtpkctSTH5BpGu2IUvty7cILPR84zzjqawhaPW1C6ZkvqT
 gsHTKEG+tNhRffmg5yExvBIVRJFuMyCGVNsh6+K6yG5lA7hpR0ISDtMkiCHD6+9TcxCyM/WqAG
 8dkjugOWiQzxOA4ljhFyRGGcdD2nY/3CPoaQ5GaXaFHZOHWdHkepUbqLhsIJUPqVY5lA0XU5em
 tDX9TW9jbwXHSXVGQgsCUalq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 03:00:15 -0700
IronPort-SDR: 1KkKhQ9tvjNX2Hlh/dCnzK0AFz7/B5EZgxK1DQUm5Gy+iFnQWbBWOo5IX0DAEahaCt6qCdvSrF
 3n0OdrcoLEsJ5oXy3Fc1PbkQT9kkrP3BNiClkmFGN8IcdIsw0fL4FhI/3CzKnSYLPmu3mdvePw
 BcLwrTcgOBEvbDIyUD9gHc0/9raLrH35gn869+W12Scvs6GE0z+0BqMbzyvzzlR9+sLUUA9uN/
 zsi0i4raf9PCGKJakbl3fI6D8IIWyh22uSv8S+oJC/jn11oFZg8RPChby+McAbYsYOBx89wX/g
 NtI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 03:37:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTGt34f67z1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 03:37:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655980667; x=1658572668; bh=VfgPtM/PPdX4UbS9Bl5+NNKpDesfaBVvgbv
        BXUlzqNs=; b=CM301ih7nB/nytPGTPn6Pv6faUPSKh2nYT6mD/vnDWuRC5vMp2u
        FHYwBXOocAqD3c/UzAdUeg+TbBqbJJB80FKBe+/ORddeGP3Bd41u1UP9cfYlBrJz
        LM3BzqQCGi78jy5lJimsVJup6EcayNWPMxoGUpLywwV0dQSyZ4iy8pFJwpf1Vp56
        KfbqQcsIwkMuCseLM+4rp4N44Rhx7IoEWnCFfGAflbBRw68jXR1oisWl83enFYuo
        B+DDZnQvOSCOJK0MSqDAR70u1m58HL7ebbjbFIGRXrEu4b8Ho5Z7iR3WhsN/fO7Y
        nhUgp7hQKJH341KmVEe0rVqhCqmQVohuK0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lf0kBec7cVtP for <linux-ide@vger.kernel.org>;
        Thu, 23 Jun 2022 03:37:47 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTGt22yBjz1RtVk;
        Thu, 23 Jun 2022 03:37:46 -0700 (PDT)
Message-ID: <66e7ec7a-03b0-4d71-c9e4-87847cd3410f@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 19:37:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>,
        zboszor@pr.hu, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220204125750.1771303-1-zboszor@pr.hu>
 <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
 <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
 <09091cc4-f652-0978-bb6a-b63f24fdcf49@opensource.wdc.com>
 <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
 <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
 <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
 <43061e32-3a00-d8a1-5946-656d38ff195c@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <43061e32-3a00-d8a1-5946-656d38ff195c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/23/22 19:12, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
> 2022. 06. 23. 11:32 keltez=C3=A9ssel, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=
=A1n =C3=ADrta:
>> 2022. 06. 23. 10:46 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>> On 6/23/22 17:38, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>>> 2022. 06. 23. 10:22 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>>> On 6/23/22 16:47, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>>>>> 2022. 02. 08. 9:07 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>>>>> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>>>>>>>>
>>>>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>>>>> It supports NCQ and high speed DMA.
>>>>>>>>
>>>>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>>>>
>>>>>>>> TRIM must be disabled for this device.
>>>>>>>>
>>>>>>>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@g=
mail.com>
>>>>>>>> ---
>>>>>>>> =C2=A0=C2=A0=C2=A0 drivers/ata/libata-core.c | 1 +
>>>>>>>> =C2=A0=C2=A0=C2=A0 1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core=
.c
>>>>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>>>>> --- a/drivers/ata/libata-core.c
>>>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry at=
a_device_blacklist=20
>>>>>>>> [] =3D {
>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 devices that don't properly handle TRIM commands */
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "SuperSSpeed S238*"=
,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, ATA_HORKAGE_NOTRIM, },
>>>>>>>> +=C2=A0=C2=A0=C2=A0 { "M88V29*",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, ATA_HORKAGE_NOTRIM, },
>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * As defined, t=
he DRAT (Deterministic Read After Trim) and RZAT
>>>>>>> Applied to for-5.17-fixes. Thanks !
>>>>>> Thank you. However, I have second thoughts about this patch.
>>>>>> The device advertises this:
>>>>>>
>>>>>> # hdparm -iI /dev/sda
>>>>>> ...
>>>>>> =C2=A0=C2=A0 =C2=A0Enabled Supported
>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Data Set Manag=
ement TRIM supported (limit 1 block)
>>>>>> ...
>>>>>>
>>>>>> but the I/O failures always reported higher number of blocks,
>>>>>> IIRC the attempted number of block was 8 or so.
>>>>>>
>>>>>> Can the kernel limit or split TRIM commands according to the
>>>>>> advertised limit? If not (or not yet) then the quirk is good for n=
ow.
>>>>> Yes, the kernel does that. See the sysfs queue attributes
>>>>> discard_max_bytes and discard_max_hw_bytes. What are the values for=
 your
>>>>> device ? I think that the "limit 1 block" indicated by hdparm is si=
mply to
>>>>> say that the DSM command (to trim the device) accept only at most a=
 1
>>>>> block (512 B) list of sectors to trim. That is not the actual trim =
limit
>>>>> for each sector range in that list.
>>>> With the quirk in effect (TRIM disabled) I have these:
>>>>
>>>> [root@chef queue]# pwd
>>>> /sys/block/sda/queue
>>>> [root@chef queue]# cat discard_granularity
>>>> 0
>>>> [root@chef queue]# cat discard_max_bytes
>>>> 0
>>>> [root@chef queue]# cat discard_max_hw_bytes
>>>> 0
>>> Yes, expected. What are the values without the quirk applied ?
>>
>> I built 5.18.6 with removing the quirk.
>>
>> [root@chef queue]# pwd
>> /sys/block/sda/queue/
>> [root@chef queue]# cat discard_granularity
>> 512
>> [root@chef queue]# cat discard_max_bytes
>> 2147450880
>> [root@chef queue]# cat discard_max_hw_bytes
>> 2147450880
>> [root@chef queue]# cat max_discard_segments
>> 1
>=20
> "echo 512 >discard_max_hw_bytes" says permission denied.

That is normal. This is a hardware characteristic so this is read only.

> "echo 512 >discard_max_bytes" can be set

Yes, this is the soft limit that can be used to limit trim command size.

> But with or without libata.force=3Dnoncqtrim, running
> "fstrim /boot" (which is ext4) goes into an infinite loop
> dumping a lot of I/O errors into dmesg.
>=20
> Interestingly, after setting discard_max_bytes=3D512,
> in both cases (with or without libata.force=3Dnoncqrtim)
> running "fstrim /" (which is f2fs) there is no error in
> dmesg and fstrim returns after a small delay.

Which would tend to indicate that the drive only likes single sector trim=
s...

>=20
> So I guess TRIM does work but ext4 seems to be misbehaving.

I do not think so. The ext4 is going to issue whatever trim request for
free blocks it has and the block layer will split these request into at
most discard_max_bytes trim commands. You can check this behavior using
blktrace.

> FWIW "mount" shows "discard" for the big f2fs partition but
> it doesn't for ext4 but it's in the default mount option AFAIK.
> "mount /boot -o remount.discard" doesn't make a difference.
> the machine dumps a lot of errors into dmesg with "fstrim /boot".

If you have an empty partition, you could experiment using blkdiscard
command to remove the fs.

--=20
Damien Le Moal
Western Digital Research
