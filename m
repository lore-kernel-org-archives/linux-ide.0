Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C909C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0243F601FF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhJLGeG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:34:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhJLGeF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634020323; x=1665556323;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+kUGpjGyoyfKGJLc0NJSoxIKn85/fjVPkTcoNAU2OcE=;
  b=KManhbX3QOnuBw9uvZc2oU9/bapjRRVGkbxUgzqv2I/nL21QVLJ5N0K6
   n6EgTQw8z+38lqv5/1OPHAGBGjXM5Or3rIVed/lt7FR0wg/cYyQeOuIkN
   QiRTLiMlyFyV9Lube86GFaljClF7YK+6IF33jUg4y5oAdrKj/mcud11ta
   XcggERWLm9GRR5ZZD5TJ3sNHyLHh7P37Wjmfs8lDcQi4wKQka7/kzSWpb
   B44KE1Kvl2dK8qqI8XQV6gqSq9I6Stqwwvk92S+/7GrdrqjXR5K5H7HTJ
   rZSHoPSJsVAQVYMNbrz23fU2r76KL5H6ciIsLZEzODnWV0LHklmFjTuUr
   w==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="187344717"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 14:32:02 +0800
IronPort-SDR: NdpubEg3fvGhxTzW3Gb00BSpGSA8naV5GacQGSktVCw5ujGffVTlQbEzLqNvP9/uggZHcWPMXS
 C5BePRZRH4BbGRCHk1Duv051o4Tkaqc3hMV/v+gjh1ifnlRl/RTx/0QDQKtL2TgtNZB3oKKh2m
 hX9KmkEDuSn9ekSxvkBgEeScP6MVKWu8zWe2KceDB6U4Y/pogPkQxjkuNnvZbSsvtYo7Fvne8D
 LClVVzTRWYkL/NOujTF1LdutfIAe+N9phiZUcuWLjF+wA0xHcaQvNc80cXFHnEf2cYKsp1YUkb
 dDdc3W8sHQAKX89kQhFfIK76
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 23:06:19 -0700
IronPort-SDR: xu62lKkRSHw1pVgkKUqw/u2UnhqJU3kdBQJusnbmXse5V3RS64+JFmVv1B+Lpa9mU6fH88qLEi
 0ZvdRMEumTLhVwRgiFlN4PDBvcU7PNR2a4H+n0CEcQWlm89BYNm1eelKAASMhYgZKkEPOC1msQ
 Eg3CinzuX91zQ2dgURj5L5nRwVj1j9C9+QAQdRce7dyans74btf/SrAfuctBx4HImXcMSwbVU8
 GXCH/SpzRQyGY06aq9UVOpvLcoW/qZDcv0q0XHxKADt/ybFMbeKpYkT5aMMvRLgMfkeJxf5/d5
 myM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 23:32:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HT5Rm0TZ9z1RvlM
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 23:32:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634020323; x=1636612324; bh=+kUGpjGyoyfKGJLc0NJSoxIKn85/fjVPkTc
        oNAU2OcE=; b=gnebySUi4Qk+Hyp3aRDr/F+q4y1SmgLR+nCCkUjQMg1LOOApGuS
        Qhd7ASNSiccf6RPIVKtvlAHXnL8+WlY+6e5Tx8Gg+lc7T3XXCugjTTXCxppu+rsF
        QGhif3gapIzO3IVY7P9bHyBd+94q4e1YCKNAS9uwU0cgMbd7qRWyKr3K8vN0nYdW
        dDA8OFarReoomF7dPUAZe28k2j7OxkqxoZRKHnqspl5i6fKi1f4q9ab0yMetv8Rt
        quMe00IvGPYk9gavnTVLU0XKLCX0r1Uz3pjQNb7TBAU2egk+ZHOe7oMb+z7MJFyN
        Lb+RW4+sAXG8qReRzmUqiIzYBqJFteXoMiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FPyBfBzE4s41 for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 23:32:03 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HT5Rk4wqbz1RvTg;
        Mon, 11 Oct 2021 23:32:02 -0700 (PDT)
Message-ID: <c34d1073-391e-1b9d-3378-f916f6ed1e30@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 15:32:01 +0900
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

That works !

>=20
> Best regards,
> Reimar
>=20


--=20
Damien Le Moal
Western Digital Research
