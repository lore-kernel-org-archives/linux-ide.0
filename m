Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B54ECAAD1
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiHaWzD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiHaWzC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 18:55:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDFB3121F
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661986500; x=1693522500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ta7NQ6De3ZrERrBIjw4mnHUS52CH/UPGJISZhiCco+k=;
  b=BPlieqZyrn8pOoMhL+3FLpKs6ILdBoTfdEwTNxFCOIied5uezOWerNJ3
   5hsDOLSn62SelDm6bSiy9ZFJTNXr0aFwmTXqzXa+oowUijH1gcYaYRsib
   t14/r2ART8AhG+ZWaxUC8i8A1sMdRbsLcoK5wioRuGZj0TGfXF1yo9kvT
   RL5LggymAEcR9DN/M8f9iqY0TOF+Be17XNYP4JW4lqxNSd/0PNK0ac95R
   E0cH86RBBXhIsgUsH5iSRvGcPym4I437HSkFx03D161p02TdbAM37/VVO
   xMhqaKjDym/nSdzVAt4LWiNIGJQijvB7CaTba4Wp+JGvOg2L7ccX4ukJq
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,279,1654531200"; 
   d="scan'208";a="215330630"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 06:54:59 +0800
IronPort-SDR: auvHt49GfgdWlv5gMa7jHh0VLpFVd6VjtmKLvWAtNXPSXI/Dco2LtCBxQNq9l4UH8OhEjvxz9g
 Wn5rd/R+1tT92ShqscU+fH7Aiykyqy0TcnjfSGiLfSbdr5/LuLLT8w9FArVxgcxQm71o70cD+l
 ctN2YL5hd1BwVk5lU6o/ulnq5mSldjomPz31SFYfGGgvjzVjHU7YUj5FCbU+jGfmbWwE3685Mq
 4Nzsc43391/6uMatqWoev+Z92cE18qYrU/MP/DSKryRGj6Ps317bFu91pXrjRuOuH//ikEJU8F
 OogFIIR/Du48HGYeTHgEymG6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 15:15:29 -0700
IronPort-SDR: zwTTEGNA9rHnlDy8nQXWH3DRO68AJOdtpOtVssY++4OhP3ztCFPhdd3S7/io3UEO1o0Gt1bLqG
 u4aK3Q6ugiiHfbNL8HJax0my+qM9UpZoypaIJ+GjwmGc2u8C/rBGJUWl+6IjT29y4L/IaagYYE
 a76gdsFIT4biO6SAexTQzj5WEXC2vTZ+xshDf1brPZIM5TBx7awmQFhi0zLU88YOEaWQc2AjJT
 kjXhl5Twt+Z0h+mNJD+IiOF56AbKvKMDpjoqn8sZdHTInq/oVYNFNOge2j4AdAJusdowYh7Xok
 Up4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 15:55:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MHzyq3dVvz1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 15:54:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661986498; x=1664578499; bh=ta7NQ6De3ZrERrBIjw4mnHUS52CH/UPGJIS
        ZhiCco+k=; b=XUVtQYf95o51uBU6P6vHX5B8BMNVoHrDhqKRRFDqMxKD/hnPVVZ
        89jZq3tkikHpMbRsH1c+kMyKq+WO/xJVAq+Jkq1fgHCsJldq5WbNo4OXIueeBpcN
        BbqPMujsBuyKhJb6OT2sdtgltoulWIZJwl+CFVmqaYR6au5u8nw/JGJKC4teFQnl
        HKpu6ToPVfa0lfRGoLQUpj8D3mC2WpZOe0/UgMF+MltV/qyp1KiHw53l5GyFalCD
        poZBR5478F/eqrRV6O4m4Jv8YxJ8P5FwAAz0eVSbESBSVRtWJTZofSxEcyVB2HHa
        U1mbnKNWWOOTVyoCCc0fIN+1pPmECfcvM6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IrXqUfc9lY26 for <linux-ide@vger.kernel.org>;
        Wed, 31 Aug 2022 15:54:58 -0700 (PDT)
Received: from [10.225.163.52] (unknown [10.225.163.52])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MHzyp1MWBz1RvLy;
        Wed, 31 Aug 2022 15:54:57 -0700 (PDT)
Message-ID: <68bba1fd-1105-791b-433d-4917e74a0c14@opensource.wdc.com>
Date:   Thu, 1 Sep 2022 07:54:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Content-Language: en-US
To:     =?UTF-8?Q?Peter_Fr=c3=b6hlich?= <peter.hans.froehlich@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHXXO6HZDNdsUC69COBU9MpEgkCCKJNw3OceBgW23WSAG+_wBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/31/22 22:30, Peter Fr=C3=B6hlich wrote:
> Sorry for spamming replies and quoting myself.
>=20
> On Wed, Aug 31, 2022 at 12:21 PM Peter Fr=C3=B6hlich
> <peter.hans.froehlich@gmail.com> wrote:
>> On Wed, Aug 31, 2022 at 9:48 AM Damien Le Moal
>> <damien.lemoal@opensource.wdc.com> wrote:
>>> On 8/31/22 16:15, Hannes Reinecke wrote:
>>>> Oh, of course :-)
>>>> That was when doing SMR support for libata.
>>>> I dimly remember that some pre-spec drives had been using the DRDY b=
it
>>>> to signal an unaligned write. Which never made it into the spec, but=
 the
>>>> decoding stayed.
>>>
>>> Any idea where the other bits come from ? Except for bit 5 (device fa=
ult),
>>> I do not see anything else in the specs that mandate these definition=
s...
>>
>> I have since discovered the "SCSI to ATA" specification which has two
>> tables about mapping ATA errors to SCSI errors. Among those I was able
>> to find an "unaligned write" case as well, but I cannot properly parse
>> the rest of the two tables yet. They are in sections 11.6 and 11.7 of
>> that document.
>=20
> So I've re-read everything I can get my hands on and from what I can
> tell the overall "flow" of ata_to_sense_error() is not what the
> specifications would imply. For example we look at BSY on entry and
> then say "ah, it's set, then let's ignore the error field" when the
> specification (the way I read it) instead says "BSY is transport
> dependent, so we say nothing about it here; but check the error bit in
> status, if it is set, interpret the error field, otherwise there's
> nothing for you in the error field". Of course I am a complete noob
> when it comes to this ATA/SATA/SCSI/AHCI stuff, so please divide by at
> least two. Sorry if this adds more confusion on top.

I had a quick look at the specs again. I already spotted an error: when
the status device fault bit is set, the sense should be HARDWARE ERROR /
INTERNAL TARGET FAILURE and not ABORTED COMMAND / 0x47 like now. That is
according to SAT-5. But looking at ACS-5, sections 6 and 7.1.6, there are
*a lot* of cases that need to be taken care of. It looks like the
sense_table does that, but need to cross check.

As for the stat_table, except for the first buggy entry as mentioned
above, I have no clue where these come from. SAT only defines the HARDWAR=
E
ERROR / INTERNAL TARGET FAILURE for when the status field device fault bi=
t
is set. Need to dig further, but I am afraid this code may be due to year=
s
of supporting drives returning weird errors that got mapped to sensible
sense codes instead of a pure implementation of the specs...

I need to spend some quality time with ACS and SAT documents to sort out
this one... And lots of coffee too probably :)

>=20
> Cheers,
> Peter


--=20
Damien Le Moal
Western Digital Research
