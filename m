Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2C9ECAAA1
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 01:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiHaBkW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 30 Aug 2022 21:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHaBkV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2022 21:40:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F337F84
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2022 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661910020; x=1693446020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RCCpFonGBHgiyV11CibqMdsUdFE5L29XbHPXwKJTJRc=;
  b=QAICq12lOCS3kpkiDvebGEDGox2HU10hC4MWGEBZG6D/a1Ktn1WkvGe6
   FG0u3APeC4ykaRl/HR6NqxT1pB3sIh8Hw8aTtvFJ6Csd0bcVj9MbUvGJQ
   KPWcXDo/Jnbc3J87GCjm4nQWP5I/rShLYijgxEAJLrO6xeaGChOy9POKc
   Z0YHI8+ccorhxlWCKnq9i7s+1hpYjjJuK7Mi52W13JVV+TjOXQla8p6SZ
   /1Hn8f8UhtGQSmUHBXSPgXH7efSJREk9/n3S85wLOvPPrz4lyWiApSZci
   34Z5DykQoWhILBXp6qYzyR78rhjdwGvTtrI26t1ZoYqEDFTWGrXnd2g62
   g==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654531200"; 
   d="scan'208";a="314370923"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 09:40:19 +0800
IronPort-SDR: xDqCNYpE5ML2oYzmjEpUcckyucEgABddMndMZioeKW5DqejFeJF5jRZoJ02GldB2Mo/WA9gAC/
 51cUYj6j3V2sBDorSWFz+EYmUA+Wecy/xCPJLwV6CMUz3U116Zw+zalp1fyoUvLfMrAkRGMCAI
 7WvRPw240Q4FOKfEun7wdsEeVKggwUQu1loxMyoX31O13VMdOlfIpcWnsU7DVyTbg3Q3SUTN7p
 oU2pXxRYb6NYlH85uSN7X3QUstBLIyhk+K0o5D2hEOzRtH7D/mWkI/TuTjXykhKS2wsiRlZdaE
 /1LDJXUwrDr5WaGuqrfsSNhe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2022 18:00:50 -0700
IronPort-SDR: BRk+NB61XVsTYDHmEdFS6F6FAIeBHqesR4EAX/zMcZmMilvGqd6bOoXrjroMTXwgLnfQKP/fVE
 mu5MI3NoOlM6K5kl3b3ho1sTswt4xd3TY+zb9CVlnTYsr6iQsKMLuGqxWlGCFF7uRy3rUCO84O
 vmBjqRTjst58lIIjFcjBTFY/WAYiDGN36ZmChn47/fjll2yX/O3kwn9ly7ZrqeAhgoDSGQ4l7m
 tjjrq8QZahy+Epg//o/ey6moSQtGQAFoAimKON36Gd5n4r/WnPzOWD+PVO3D/2+1Z53vYUCsZC
 Nnc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2022 18:40:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MHRh33BNgz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2022 18:40:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661910018; x=1664502019; bh=RCCpFonGBHgiyV11CibqMdsUdFE5L29XbHP
        XwKJTJRc=; b=XIhg3S8MxnLd7DpztA4KvbmxZ+h6X+2JkBXCZxkhx2ViKVlxD22
        CjPa6coxffLtOa5eqDoN92Fsm4dlgz+QYEJn0nYcQPXgl6U1/xc5YOWFx8NkIcxO
        8fRi7COENcHHn22Jk3c62SvHsxUnaUoxp6k20xUO8PDmZa8pJWh4ShqaskhYc1h1
        7EY8q9q7PwpqYzyJrEZHU9Dq5u73FP5PgvTTBH2pi2pVFjt8Zou7wZdjhG42Mnc2
        JNIJ1LsWGIU3xik3yFwxq4Ay01gx+m/0a6AK8HiZk1dxW6TO6KGm3/GoTBsV+4y0
        Pr8raSXiIR1gsWqQb1j6pW+S4J2Vs0LQf3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZdixrYPlo2Nl for <linux-ide@vger.kernel.org>;
        Tue, 30 Aug 2022 18:40:18 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MHRh22j4lz1RvLy;
        Tue, 30 Aug 2022 18:40:18 -0700 (PDT)
Message-ID: <fb5b1dda-fa31-077c-f075-c0cffdc689f7@opensource.wdc.com>
Date:   Wed, 31 Aug 2022 10:40:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Content-Language: en-US
To:     =?UTF-8?Q?Peter_Fr=c3=b6hlich?= <peter.hans.froehlich@gmail.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
 <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
 <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
 <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
 <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHXXO6Gj1Tn6C=_CZ2eB5+V0-51Lt=g6PMnazwym_nnXsFNMpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/30 16:02, Peter Fr=C3=B6hlich wrote:
> On Tue, Aug 30, 2022 at 1:26 AM Damien Le Moal <Damien.LeMoal@wdc.com> =
wrote:
>> On Mon, 2022-08-29 at 08:04 +0200, Peter Fr=C3=B6hlich wrote:
>>> That's the sense_table, I was referring to the stat_table. That table
>>> is consulted when we fail to convert via the sense_table.
>> ...
>> So looking at the right code again, this is all very strange. E.g. the
>> ACS specs define bit 5 of the status field as the "device fault" bit,
>> but the code looks at 0x08, so bit 3. For write command, the definitio=
n
>> is:
>>
>> STATUS
>> Bit Description
>> 7:6 Transport Dependent =E2=80=93 See 6.2.11
>> 5 DEVICE FAULT bit =E2=80=93 See 6.2.6
>> 4 N/A
>> 3 Transport Dependent =E2=80=93 See 6.2.11
>> 2 N/A
>> 1 SENSE DATA AVAILABLE bit =E2=80=93 See 6.2.9
>> 0 ERROR bit =E2=80=93 See 6.2.8
>>
>> And the code is:
>>
>>         static const unsigned char stat_table[][4] =3D {
>>                 /* Must be first because BUSY means no other bits vali=
d
>> */
>>                 {0x80,          ABORTED_COMMAND, 0x47, 0x00},
>>                 // Busy, fake parity for now
>>                 {0x40,          ILLEGAL_REQUEST, 0x21, 0x04},
>>                 // Device ready, unaligned write command
>>                 {0x20,          HARDWARE_ERROR,  0x44, 0x00},
>>                 // Device fault, internal target failure
>>                 {0x08,          ABORTED_COMMAND, 0x47, 0x00},
>>                 // Timed out in xfer, fake parity for now
>>                 {0x04,          RECOVERED_ERROR, 0x11, 0x00},
>>                 // Recovered ECC error    Medium error, recovered
>>                 {0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>>         };
>>
>> So this does not match at all. Something wrong here, or, the "status"
>> field being observed here is not the one I am thinking of. Checking
>> AHCI & SATA-IO specs, I do not see anything matching there either.
>=20
> Thank you for confirming that this section *is* confusing. I was down
> the same rabbit-hole checking "status" in whatever ATA spec I could
> get my hands on, and it didn't help. Specifically for "WRITE DMA"
> where I usually see the error, it seems that bit 6 has no other
> meaning than "transport dependent" which for SATA means (I believe)
> "drive ready" as it's always been. But that 0x40 is *not* an
> "unaligned write" whatever else it may be. My suspicion is that maybe
> it went in by accident since it's also in a "whitespace" commit. On
> the other hand, it has an explicit comment. I wasn't going to bother
> the original author before, but maybe now I should?

+Hannes

Except for bit 0x20 (device fault), the other bits do not match anything
sensible either. So I wonder what specs this is against. Hannes ? 7-years=
 old
patch... I am sure your memory is very fresh about this one :)

>>> Which is why I am pretty sure that the "unaligned write" message is
>>> spurious since I am writing to a plain old SSD. It's going to be hard
>>> for a userspace program to generate a write that is no properly
>>> aligned for the SSD.
>>
>> Unless your SSD is really buggy and throws strange errors, which is
>> always a possibility. Do you have a good reproducer of the problem ?
>=20
> Not really, sadly. For me it happens with SSDs behind a Marvell SATA
> controller but it doesn't happen when the same SSD goes behind a
> fancier SAS controller. This is what led me into the ATA/SCSI layer as
> the possible culprit because on the SAS boxes that layer is not used.

Yes, with a SAS HBA that has SAT implemented in FW, the HBA FW will do th=
e
conversion to sense data for failed commands. No way of knowing how that =
is done
there.

> BTW there's another "strange" effect that sometimes seems to lose the
> LBA flag on the ATA taskfile struct resulting in an obscure error
> message about failed CHS addressing. In that case I suspect an
> initialization gone wrong or maybe a race condition somewhere, but
> it's been a real pain to track down further. If I ever get a better
> handle on how to repro this stuff, I certainly will share.

Yes, that type of error generally means something goes badly during scann=
ing or
revalidate, e.g. access to a log page failing. That is a fairly common pr=
oblems
on many drives (e.g. drives advertising support for READ LOG DMA EXT but =
that
command in fact not working). Your drive may need some quirks to get a re=
liable
scan.

Have you checked if your drive already has some entry in ata_device_black=
list
(in libata-core.c) ?

>=20
> Cheers,
> Peter

--=20
Damien Le Moal
Western Digital Research

