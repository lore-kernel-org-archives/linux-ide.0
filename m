Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8545BC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6773C60E94
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhJLGfm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:35:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42062 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhJLGfm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634020421; x=1665556421;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=H4ONciO5zKYeSi2T2fOsI5PzYnJqn6fmyJu6aa15Mpw=;
  b=nZdP3IvbdCRyMdHbMoctInppY6wY7YfcfXjlqQpaSnN6ju3ecSkLRvBr
   4vG/NmZOh/uJ43ftQL88sy1Rpmq1UqJTImqhRAtBOWSm6DfgJpo4qNM3c
   n0eaRG9ijEc8WfEPHsS9oKPGdhdo0Ztfy9+qT12VfAyKF77UHFLiG3YXB
   XOWw4FovJtZKycxZvMRJ4ZOb3bQlkVKBUWiWSzX9KNFJUUsngj2AGy8jn
   3NhM1cldJe+cCSoXPmfaUjJ7qEn8PrCQ4BEG9/myv4Aon095/iCl/l2rk
   iFjUXOwW0rg3eg2y3nXNu8N9G7bJDV6AiQLmDL6JdpWBQdhfEnHhvMrtR
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="294296661"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 14:33:40 +0800
IronPort-SDR: xCFPWu2hZ2JBgq3fbQr1Wt7UJ42idj3UikYzQH+0FguW7z+VloaXq7dCz/53+owCfd3eUmIyQa
 OdH6S19wuAyJ9M5V43W6STgQMFgt7z9jvhUJESNsedqydOTm90FFc4zWntZAiwfznZtCRILBTg
 Lus4VRTEJ1VTd/GJVJnFCGqTm61rsmthVogTNN5BLngyhAF9ENv3Pu5frjvirnQcMzBKRKTzAv
 IuczaqFwPoCwiLLunMpZ0Bz1nulzIQARKGlZXKUbViASBuK6yEimxYrQXbVnnXyJ00eiElFn3N
 kUxrHkaGmTP/jQJDQ8hqqUXm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 23:07:55 -0700
IronPort-SDR: YwDhJt7oB1taUQJNXBjZ8Kqyr/E+J/dzfeYuZmv1HkJOA9MEQC86DAkkiLWqkiry1UfKCQNAyZ
 F557x8XWO0ZuG6DmJNhfddS0HpiCXsJgCpGqbCN7xeODm28yuwS3lMWEX+BHxYoiICmez30ExT
 n7KEd1dziM33UZAC5avekrgSbgo92BQlPPU1Z5gdTWG/CghclQMHGreWlgzsqal209mil9T8SB
 apjquRjB4+DIPHdyhSSeg3pve5h5jTYhGRtPKSvPvX/PeG+WH3QkiGwtfAvMtJykqLVQquGo/E
 Uww=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 23:33:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HT5Tc2q4pz1Rvll
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 23:33:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634020419; x=1636612420; bh=H4ONciO5zKYeSi2T2fOsI5PzYnJqn6fmyJu
        6aa15Mpw=; b=YkptdX7eFOZGNqH1QEyFETeeqrcCvwdvTSBAV/Dc33JTMpFbuoW
        EL/ThbztoECnp8jIanETK1TSYkUmFlVxidkdPGndkGiK/cX03YOTjOHpzazK7BG+
        GsSd+ISu6rrEJ9DwUL8X6NbEnXhKBkmUpkuBzj870IvorYESgvlVsU177M28yqJn
        PgHc+Sd146MTECX4AUgMWLZbJXzNOK6uqObJFi73QnF/BqbEfZ/+9Z00O8P76OE3
        bxb6eeZakJJTemdWulLQB5mje5JjNHP1lgAMVtivgMYUcvcGRUkhfPGrd7Y0Kgr4
        fVRJQDpY/EJt5DeLkTu3kHKqzWx1Oh/qdvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wGlhPAOfkiZs for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 23:33:39 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HT5Tb0R1tz1RvTg;
        Mon, 11 Oct 2021 23:33:38 -0700 (PDT)
Message-ID: <2c974db4-74de-1749-af49-72871338ade4@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 15:33:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v4] Fixes to DMA state check
Content-Language: en-US
To:     =?UTF-8?Q?Reimar_D=c3=b6ffinger?= <Reimar.Doeffinger@gmx.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
 <c3a7bdf2-caab-99e6-4da6-25638e3b3c24@opensource.wdc.com>
 <605EE991-5DA2-4A8D-9691-967D68D3AB51@gmx.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <605EE991-5DA2-4A8D-9691-967D68D3AB51@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/12 14:57, Reimar D=C3=B6ffinger wrote:
> On 12 October 2021 04:20:47 CEST, Damien Le Moal <damien.lemoal@opensou=
rce.wdc.com> wrote:
>> On 10/3/21 22:28, Reimar D=C3=B6ffinger wrote:
>>> Patch series to add ata_dma_enabled calls instead of incorrectly
>>> checking dev->dma_mode !=3D 0.
>>> Only the first patch is confirmed to have caused real issues
>>> that it indeed fixes, rest based purely on code review.
>>>
>>> Changes v4:
>>> - split per file/driver
>>> - added Signed-off-by and Tested-by lines, improved commit messages
>>> Changes v3:
>>> - found and updated more cases in pata_ali, pata_amd and pata_radisys=
.
>>> Changes v2:
>>> - removed initialization change for SATA. I got confused by the
>>>   ping-pong between libata-eh and libata-core and thought SATA did no=
t
>>>   set up xfermode
>>> - reviewed other cases that used dma_mode in boolean context and thos=
e
>>>   seemed to need changing as well, so added them to patch.
>>>   I did not see any places that would set dma_mode to 0 ever, so I
>>>   do think they were all indeed wrong.
>>
>> This looks all good to me but I do not see any CC Stable tag. Do you
>> want this backported to stable versions ?
>=20
> Sorry, I admit I am quite ignorant of these workflow details.
> Personally I have no need for a backport as it's only about one piece o=
f legacy HW for me.
> I also feel like the untested patches do not belong in a stable backpor=
t.
> However the first, tested patch might be good to have backported if con=
sidering the whole user base and not just my use? Would that be sensible =
to handle that way?=20

Note that I will apply the entire series to for-5.16 so that the patches =
have
time to go through linux-next for more testing. The first patch will be
backported once we start the 5.16 cycle.


>=20
> Best regards,
> Reimar
>=20


--=20
Damien Le Moal
Western Digital Research
