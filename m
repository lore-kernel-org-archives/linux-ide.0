Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488A5ECAAD2
	for <linux-ide@archiver.kernel.org>; Fri,  2 Sep 2022 02:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiIBCfV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Sep 2022 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBCfU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Sep 2022 22:35:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47D1903D
        for <linux-ide@vger.kernel.org>; Thu,  1 Sep 2022 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662086118; x=1693622118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1PvL3aHTYalyzb7D7oDmbHe6DO3R/l7ZYDMzEbQA8ik=;
  b=bGv6PdY7B+EUu4hLltKlVAH2EE9BektANFFm39Ue7xDQF21AAxnfQhNx
   H6Dbb4n+jzBSNtidePZCRKQwaaA+mHmV9q/nrcrzIjAwcwj4hwdmnJAbp
   ER9764FiCX2swyVDIfAFZYhC1lUP/xjq2thjuJQAuJs1VWVYhH8OdGGH8
   2YClfz6R4kFls4srbyY9B2XdQ8vREmGcvkRcUc0a6efCqgeEDgCZSuAYE
   bu1ye4rmkAlC/VUwOi4csqm10iO9YhdtHtjPJoYTT21GxF6jp+VynhgyF
   3AoPtT4LYHFKAqPGgbx4y2vgTC6aZXuc/NWF3XJio8gZigwmnULV+aXFz
   w==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="215453656"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 10:35:18 +0800
IronPort-SDR: cEMBxlEpBjSWdjDXWctv3smg0kwsHc/LkbkPe1REC4iWbiJMS6qD76hBdxLZD2JNEgm3z619qP
 /fX8ilvbHvsJUNKCxbwKHieuhWO0QFuzOiZjIBU+knKOiHc64BtPn4IZRre6FPel6dkSWZ4Tqo
 oVMSAQXbRi8IUnRcHfWlGRExAbaWyspJ8O9GEle3bTZYWuOvZtHX60QDxtqLKGrDIuk2LSnh6s
 gAuW898Xu4McdzSPOblgpLPDSXj8x+aV/yEnZKervRWeV87WyBiSaMcGqCsu0valL6KuMW2Tee
 8mbFjyVPA5bX7V9gQ2XYZP3C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:50:24 -0700
IronPort-SDR: w6WI3ovrF59cW+gOUfYIF1JgOMWwShEYsTPYgFj4MAzcTzx9Br61IG2FWdCb3yyPsOW5UQGEwn
 SvGvFa6dcDrZMvJUvNI8gM97Fp/OuqJ1EiPN3WaX+8q7wUOjdg5eotu6AWVtO3YW5W8GD6hx9Q
 2AXONUSUan+QE+QtzFpCzsVrUNGjku+dOT5hWJnZ3NYjST3lJ9oVmJMD3LGKw5b/dlE3Gy4bpk
 r14zpvITNfG9pmP22ineVFPm0YjKKsIL1gknX/0yjJLs9r/+TJAbDpWTnWL9RHc8l2Owx3ATPd
 n9M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 19:35:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJhpZ5WDPz1RwqL
        for <linux-ide@vger.kernel.org>; Thu,  1 Sep 2022 19:35:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662086118; x=1664678119; bh=1PvL3aHTYalyzb7D7oDmbHe6DO3R/l7ZYDM
        zEbQA8ik=; b=ggw8wV3sn4dcdro+GK7cM5L+L0ndh6Y2QjUduBK31SuyCDgF4dX
        /8yYuYqC7E5kL0XqUZFYRXcRjTl4MqyYdRhvS+Sxy8dTrT2WAVlr/c7QM7FnB1Fr
        eDzCqCc53XRNWxMf4IX9YPgSh8SJiEmMEeDfCK5XBrGKvOtpLZ5kf+U6F771gd+4
        deGQ9aw7KFa0LlgZLc49Qp51hNL4ZhPDe3aZoSq9o++A9+fZhRCcWOBJlwBGbpsB
        djo2JdJkIqBOXYj/PPjsGsZUkiSd5oU5SCXHDp4RNI2nyDkLeVroSsPgaSmrXQna
        U5LB1bay8xxhJI0ZcfZUUNd0WwpviUz7v/Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ex5HJJM-AxH for <linux-ide@vger.kernel.org>;
        Thu,  1 Sep 2022 19:35:18 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJhpY5DT3z1RvLy;
        Thu,  1 Sep 2022 19:35:17 -0700 (PDT)
Message-ID: <396b2bb5-533f-2a9c-66f2-c92465d54df1@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 11:35:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        =?UTF-8?Q?Peter_Fr=c3=b6hlich?= <peter.hans.froehlich@gmail.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
 <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
 <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
 <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com>
 <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
 <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com>
 <CAHXXO6HDRmcvhYRYZq66ZHWqc82x6a4Q8NstAvZdxY8yVrA_zQ@mail.gmail.com>
 <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
 <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
 <ed854cd3-3456-4dfc-e589-40f4946bb0e7@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ed854cd3-3456-4dfc-e589-40f4946bb0e7@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/1/22 15:13, Hannes Reinecke wrote:
> On 9/1/22 00:54, Damien Le Moal wrote:
>> On 8/31/22 22:30, Peter Fr=C3=B6hlich wrote:
>>> Sorry for spamming replies and quoting myself.
>>>
>>> On Wed, Aug 31, 2022 at 12:21 PM Peter Fr=C3=B6hlich
>>> <peter.hans.froehlich@gmail.com> wrote:
>>>> On Wed, Aug 31, 2022 at 9:48 AM Damien Le Moal
>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>> On 8/31/22 16:15, Hannes Reinecke wrote:
>>>>>> Oh, of course :-)
>>>>>> That was when doing SMR support for libata.
>>>>>> I dimly remember that some pre-spec drives had been using the DRDY=
 bit
>>>>>> to signal an unaligned write. Which never made it into the spec, b=
ut the
>>>>>> decoding stayed.
>>>>>
>>>>> Any idea where the other bits come from ? Except for bit 5 (device =
fault),
>>>>> I do not see anything else in the specs that mandate these definiti=
ons...
>>>>
>>>> I have since discovered the "SCSI to ATA" specification which has tw=
o
>>>> tables about mapping ATA errors to SCSI errors. Among those I was ab=
le
>>>> to find an "unaligned write" case as well, but I cannot properly par=
se
>>>> the rest of the two tables yet. They are in sections 11.6 and 11.7 o=
f
>>>> that document.
>>>
>>> So I've re-read everything I can get my hands on and from what I can
>>> tell the overall "flow" of ata_to_sense_error() is not what the
>>> specifications would imply. For example we look at BSY on entry and
>>> then say "ah, it's set, then let's ignore the error field" when the
>>> specification (the way I read it) instead says "BSY is transport
>>> dependent, so we say nothing about it here; but check the error bit i=
n
>>> status, if it is set, interpret the error field, otherwise there's
>>> nothing for you in the error field". Of course I am a complete noob
>>> when it comes to this ATA/SATA/SCSI/AHCI stuff, so please divide by a=
t
>>> least two. Sorry if this adds more confusion on top.
>>
>> I had a quick look at the specs again. I already spotted an error: whe=
n
>> the status device fault bit is set, the sense should be HARDWARE ERROR=
 /
>> INTERNAL TARGET FAILURE and not ABORTED COMMAND / 0x47 like now. That =
is
>> according to SAT-5. But looking at ACS-5, sections 6 and 7.1.6, there =
are
>> *a lot* of cases that need to be taken care of. It looks like the
>> sense_table does that, but need to cross check.
>>
>> As for the stat_table, except for the first buggy entry as mentioned
>> above, I have no clue where these come from. SAT only defines the HARD=
WARE
>> ERROR / INTERNAL TARGET FAILURE for when the status field device fault=
 bit
>> is set. Need to dig further, but I am afraid this code may be due to y=
ears
>> of supporting drives returning weird errors that got mapped to sensibl=
e
>> sense codes instead of a pure implementation of the specs...
>>
>> I need to spend some quality time with ACS and SAT documents to sort o=
ut
>> this one... And lots of coffee too probably :)
>>
> And, to make matters ever more complicated, the error and status bits=20
> changed over time. And even the SAT translation changed between version=
s.

I checked all SAT docs from v1 up to v5 and all of them define the same
for the device fault status bit.

1) If status device fault bit is set, ignore error and translate to
HARDWARE ERROR / INTERNAL TARGET FAILURE. So this is wrong in the current
code which returns ABORTED COMMAND / SCSI PARITY ERROR, which is a little
silly. We could fix this, but urgency for the fix seems to be non-existen=
t
since no-one complained about that one. I suspect this is because this
stuff only matters for IDE drives since most NCQ drives will get sense
data from the read log 10h anyway. So that weird stat_table is likely
never used, even for IDE drives as the sense_table gets a hit all the tim=
e
first.

3) When the status device fault bit is not set and the error bit is set,
then the error bits are defined differently across SAT revision, but they
all look backward compatible though.

3) None of the SAT specs have anything about "unaligned" error defined. I
think it is safe to remove that one as a fix. Will you send a patch ?

Peter,

Your drive seems to be an exception to my (1) statement and the error it
returns seems weird enough that the stat_table ends up being used.
Could you send a dmesg output of a failed command so that we can see the
err_mask etc info for the failed command ? And it would be good to add a
print of the drv_stat and drv_err parameters passed to
ata_to_sense_error() for the failures you are seeing. That would help
trying to figure out what your drive is attempting to signal.

Also, please send the output of "hdparm -I" for that SSD please, so that
we have information about what standard it is (supposedly) following.

> So there really is no clear "that's the way to go" style of thing; if w=
e=20
> want to be correct we would need to evaluate the ATA version for that=20
> device, and have different translation tables depending on the version.
>=20
> Not sure if it's worth it, though; in the end it's just an error=20
> description which will get changed. Commands will be aborted in either=20
> case, so the net result is close to zero :-)
>=20
> Cheers,
>=20
> Hannes

--=20
Damien Le Moal
Western Digital Research

