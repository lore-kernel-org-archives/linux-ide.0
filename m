Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB4CC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Jun 2022 08:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiFWIqL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFWIqK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2022 04:46:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC849249
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655973969; x=1687509969;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nG7IwkCM3bMibkNL8def0G67D3SVszHUKz2jxa1Ctbc=;
  b=cf641p3p0bUibYAXmAB90I2RTnnPL2T2j1rpyoTE4FK7Qom0KmepDxzK
   j2UpUGEzgKpeJ9zJMX6TG6YmVj/2sA+B4iVkYeiZ1n7v9Nuu/G9KZ+1Gc
   vn7u7JFqej3/4hKV52lqejYMHbT2U093aml+WoTqlYGw7BgOtp3iPRcYC
   8O+CTs07+DkrI+f8NY0rim5miSK2zlFBwkgFJ4XPFMdAuHQYnPlqe+Hlv
   S93pf1TJOTjLjPssgFNVg9Bbmkaq56bG8bo4AfO1RAqGs5oYBW2x4tZZ5
   M5WKZBhUAfltTNvmfcXO3qXHZB95rSBMZDZnXnoYukbCQQOG8ymYiWf9A
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="316010279"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 16:46:08 +0800
IronPort-SDR: r2K7BWMjs8mP39OHQ7mAICiI61NvU2p99bmsMP4RS0FB0VReGjC/JjwjkG8kPconMVLe/MzuO2
 S5cI4W18eh8NGpX4HB9HhNoFc2ZtwzQeWbU+6Rwwxz0G2B6ES0uofC9HwOlwkRlvvxXK3vzYnJ
 +JdHwhWaeDSsUHF188/9CITszaN6znlfrhWuWjUoaLG6g9nBmQ2pICYrxdZ5jrBLmJ3HsN9/OH
 U/hGjH6lmu1PHP8vYgDkmSrOJJueXlQJute/G/uo6B2S2klNrW2E4xd7w78u3grX7t8jHrgUXf
 M72bYKPkkH4Nu3L5tgjJqRJw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 01:03:54 -0700
IronPort-SDR: ICP/JfJR3jENwpGwBgRTR0acJZ4IpGiK9rx+O0dqXEFXf3/mN+KtskT+MIHzARmEm5dY+0dTrV
 83Vsrrb0VpW9hb+3piq+OAFojYlcdlFPMXRTvjbEw99BtT5it/NsjesGdLI8MYtv598K87pOld
 GG1yWSJJdkGuSvctN38rY3Q8f1rH1EyAtBFBs07sw2FHGe8NFGqRjPgqSnNIxx2jSnKz6xKtH0
 YyCt0CCtBIXWdkKYYCxfHecU/jPqM5Zs3jSP871m+9xs+mrbOGLwQ+UIg5XuLg5UdfIDErTO4J
 UWg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 01:46:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTDPC3bVYz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 01:46:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655973967; x=1658565968; bh=nG7IwkCM3bMibkNL8def0G67D3SVszHUKz2
        jxa1Ctbc=; b=OqbjMGQ3bfKTsVbWIYH2EWFgHOCfN+rw83LWdm8tkfMrgGmP6Zl
        zsQdAy+v2TmfYSYVkhd6sHK3Fc2+Cuc1oumeAhdo8PuUUmVg1kpRBTq3hN/AxUtm
        WfbS5uy+aTXrEda0HbVXplUSRtypIGHL/36plWaTVVnZSQd5TmM5ZQlv5i2NbN0j
        7bRO2BqZ4/8R9hZnq2Re9fqvLzcaC8EniX760++TZ0l8HYD50JVQMJ+yDk5avU4s
        J09BtcGd7wg7gpHAVzYoaoYnQu6fSWEd0vdbftndCoiZQe/9r58roTqpNstzbsQu
        Jr8lpoxQkuUOzawT7fQdxpdZeQs5h+WEeIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K_XkRQnwZLKZ for <linux-ide@vger.kernel.org>;
        Thu, 23 Jun 2022 01:46:07 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTDPB2s85z1RtVk;
        Thu, 23 Jun 2022 01:46:06 -0700 (PDT)
Message-ID: <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 17:46:05 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/23/22 17:38, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
> 2022. 06. 23. 10:22 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>> On 6/23/22 16:47, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>> 2022. 02. 08. 9:07 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>>>>>
>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>> It supports NCQ and high speed DMA.
>>>>>
>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>
>>>>> TRIM must be disabled for this device.
>>>>>
>>>>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmai=
l.com>
>>>>> ---
>>>>>    drivers/ata/libata-core.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>> --- a/drivers/ata/libata-core.c
>>>>> +++ b/drivers/ata/libata-core.c
>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_d=
evice_blacklist [] =3D {
>>>>>   =20
>>>>>    	/* devices that don't properly handle TRIM commands */
>>>>>    	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>   =20
>>>>>    	/*
>>>>>    	 * As defined, the DRAT (Deterministic Read After Trim) and RZA=
T
>>>> Applied to for-5.17-fixes. Thanks !
>>> Thank you. However, I have second thoughts about this patch.
>>> The device advertises this:
>>>
>>> # hdparm -iI /dev/sda
>>> ...
>>>   =C2=A0Enabled Supported
>>>   =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Data Set Management TRIM sup=
ported (limit 1 block)
>>> ...
>>>
>>> but the I/O failures always reported higher number of blocks,
>>> IIRC the attempted number of block was 8 or so.
>>>
>>> Can the kernel limit or split TRIM commands according to the
>>> advertised limit? If not (or not yet) then the quirk is good for now.
>> Yes, the kernel does that. See the sysfs queue attributes
>> discard_max_bytes and discard_max_hw_bytes. What are the values for yo=
ur
>> device ? I think that the "limit 1 block" indicated by hdparm is simpl=
y to
>> say that the DSM command (to trim the device) accept only at most a 1
>> block (512 B) list of sectors to trim. That is not the actual trim lim=
it
>> for each sector range in that list.
>=20
> With the quirk in effect (TRIM disabled) I have these:
>=20
> [root@chef queue]# pwd
> /sys/block/sda/queue
> [root@chef queue]# cat discard_granularity
> 0
> [root@chef queue]# cat discard_max_bytes
> 0
> [root@chef queue]# cat discard_max_hw_bytes
> 0

Yes, expected. What are the values without the quirk applied ?
With 5.19, you can use libata.force to disable/enable it. See
Documentation/admin-guide/kernel-parameters.txt for details.
You could try disabling DSM TRIM (queued trim) and see if the non-ncq tri=
m
work.

--=20
Damien Le Moal
Western Digital Research
