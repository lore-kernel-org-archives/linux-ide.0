Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28416C43334
	for <linux-ide@archiver.kernel.org>; Thu, 23 Jun 2022 09:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiFWJzu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Jun 2022 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiFWJzt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2022 05:55:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01922CE3E
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655978146; x=1687514146;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XXpmfGITyPHZs6FZ5fvy9HEUGUmVlfFW8Va4Xmp7y8k=;
  b=BtBsZHX2HSxn980QD/ehUKUUqO5wrhn0c2utFErwGs93zsZn3Hl2SaBD
   G2yQvcOn0EWRTcASgkOx8QP8lAK0eB8HNCmN/7PzdzsHvAYVYAOsYH3U7
   uJLh3vkJzXWcrEWHzdquObNyn1Q54ATX3xEgLvttXNY4fXcxSN+XSq5UJ
   A1v7R92SfhLZcZURbEER95UhH+It49WvhlXcqC/KMo1ENBbwRZfjRZFmp
   +myPjK4Ie/WJBAErKH8bDvSrrj7iBAsOVi0Ji2dpagsOR+vNTPEfwAUBq
   sKXKNgXnEkFju6jDux04mIXbz44T07yAKWlICOn3iFpeCU0pGcoFc38Lp
   A==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="308235322"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 17:55:45 +0800
IronPort-SDR: Wpd3Oq2wzLd2x5Wh981TftlssGwVo4URmajjZ4cWIJVvMZnQv5qQAVin342nKea8r1M0rY12Xk
 rzbohAnMnwO3pD1Wv9ectnLhQp7K0pw7CmSvItPmZx3cpHJnlqvwu4u6SkbObyDSWpit1RGhqi
 QiXTuBegkSakHMYskiEClyGRaY2yUVnqPJx/zpF2u0N/ROtkWx7iVO5tGr5kZmS2XhUpW4dKhs
 SKxocowIrM3F+KtV9xR0QxphoH/QVpEwCPRVvjiUcno7Ry5x5CI3KHBw/Umuu7N7W9FJ6ehEkW
 JZGWcuEt1ucT1IN1jMJJPmix
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 02:13:31 -0700
IronPort-SDR: rsd3eYtKPPY85sTeV2esIscJ7Q6tbhFngtfKTAJDPRmi+H3P1aoJLrB/BcQAuH67EWdfhgDRRT
 GdqYw5rqAMIVWq8wgKbBd3FWb7Z3CDc4CUvLMAwtv3sSGKkxVLBHzwYmdKU2ra64Rt5VLtIZ2U
 o2oAS97gtAMI6HHKkE1xZDo2ia+PHy0l5JqMEs2pG/3yglxNXP7zJRrOdZ96yTHQviLHSIAywd
 iQiPv0TtbeoMfpeyfAFJE1wI5OjW2+4EBAKnHGb6tAYCviip3jLm3+niAru4pHh4Oy754fCGEX
 CPw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 02:55:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTFxY497Zz1Rwnx
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2022 02:55:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655978144; x=1658570145; bh=XXpmfGITyPHZs6FZ5fvy9HEUGUmVlfFW8Va
        4Xmp7y8k=; b=e+LTVpJ8vC7V7YcBAQSmvUX383ihhrA0xxjfohzckdc8UIozi8m
        EJ6U4DKqhPIFJyLFnDnhQNNmjW3fGoO7vW4NXnVKsg4wE6xn9Egof1eqXSv/DASU
        J4HcCBI6ESujHK7pRwosb/MiK58Y2Ol4RLvGVNNBjcxm/IuMkhgkVNpPJlenoiB1
        f9qd59xDISIYuZjq1MVmah+3EL6yV+9DwZty+5uBxVxt5+4dXY8BAV0R1lWNkiJO
        T+1xHSnSogbZbHB7NkUNRUEdPAC29dpx5noKZB++fdeOqOR8DwyT5J2+LEk7Kjsu
        kK/8v2XN6oGAqhTHqSg6VkhkbNcbb8Xzkfg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MgtdbClGGUhz for <linux-ide@vger.kernel.org>;
        Thu, 23 Jun 2022 02:55:44 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTFxW6vFvz1RtVk;
        Thu, 23 Jun 2022 02:55:43 -0700 (PDT)
Message-ID: <5dad0eb6-10e3-8319-ca86-f5059a7bd185@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 18:55:42 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/23/22 18:32, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
> 2022. 06. 23. 10:46 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>> On 6/23/22 17:38, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>> 2022. 06. 23. 10:22 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>> On 6/23/22 16:47, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n wrote:
>>>>> 2022. 02. 08. 9:07 keltez=C3=A9ssel, Damien Le Moal =C3=ADrta:
>>>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>>>> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>>>>>>>
>>>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>>>> It supports NCQ and high speed DMA.
>>>>>>>
>>>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>>>
>>>>>>> TRIM must be disabled for this device.
>>>>>>>
>>>>>>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gm=
ail.com>
>>>>>>> ---
>>>>>>>     drivers/ata/libata-core.c | 1 +
>>>>>>>     1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.=
c
>>>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>>>> --- a/drivers/ata/libata-core.c
>>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata=
_device_blacklist [] =3D {
>>>>>>>    =20
>>>>>>>     	/* devices that don't properly handle TRIM commands */
>>>>>>>     	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>>>    =20
>>>>>>>     	/*
>>>>>>>     	 * As defined, the DRAT (Deterministic Read After Trim) and =
RZAT
>>>>>> Applied to for-5.17-fixes. Thanks !
>>>>> Thank you. However, I have second thoughts about this patch.
>>>>> The device advertises this:
>>>>>
>>>>> # hdparm -iI /dev/sda
>>>>> ...
>>>>>    =C2=A0Enabled Supported
>>>>>    =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Data Set Management TRIM =
supported (limit 1 block)
>>>>> ...
>>>>>
>>>>> but the I/O failures always reported higher number of blocks,
>>>>> IIRC the attempted number of block was 8 or so.
>>>>>
>>>>> Can the kernel limit or split TRIM commands according to the
>>>>> advertised limit? If not (or not yet) then the quirk is good for no=
w.
>>>> Yes, the kernel does that. See the sysfs queue attributes
>>>> discard_max_bytes and discard_max_hw_bytes. What are the values for =
your
>>>> device ? I think that the "limit 1 block" indicated by hdparm is sim=
ply to
>>>> say that the DSM command (to trim the device) accept only at most a =
1
>>>> block (512 B) list of sectors to trim. That is not the actual trim l=
imit
>>>> for each sector range in that list.
>>> With the quirk in effect (TRIM disabled) I have these:
>>>
>>> [root@chef queue]# pwd
>>> /sys/block/sda/queue
>>> [root@chef queue]# cat discard_granularity
>>> 0
>>> [root@chef queue]# cat discard_max_bytes
>>> 0
>>> [root@chef queue]# cat discard_max_hw_bytes
>>> 0
>> Yes, expected. What are the values without the quirk applied ?
>=20
> I built 5.18.6 with removing the quirk.
>=20
> [root@chef queue]# pwd
> /sys/block/sda/queue/
> [root@chef queue]# cat discard_granularity
> 512
> [root@chef queue]# cat discard_max_bytes
> 2147450880
> [root@chef queue]# cat discard_max_hw_bytes
> 2147450880
> [root@chef queue]# cat max_discard_segments
> 1

All normal. This is 65535 sectors at most per trim range times 64 ranges
at most (64 range in at most 1 512B range list).
65535*512*64=3D2147450880

So if that is not working, then it means that DSM TRIM are not working
correctly on that device. Have you tried disabling NCQ trim ?
Use libata.force noncqtrim option.

>=20
>> With 5.19, you can use libata.force to disable/enable it. See
>> Documentation/admin-guide/kernel-parameters.txt for details.
>> You could try disabling DSM TRIM (queued trim) and see if the non-ncq =
trim
>> work.
>>
>=20


--=20
Damien Le Moal
Western Digital Research
