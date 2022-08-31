Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D707C0502C
	for <linux-ide@archiver.kernel.org>; Wed, 31 Aug 2022 07:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiHaHtz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 Aug 2022 03:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiHaHtF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2022 03:49:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFFAA354
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661932137; x=1693468137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gosABvYtW2DaWCzPPRMyHqL7697IheR91Fw9Iq8bGLc=;
  b=gQZIcN2Pam7wtSSiiYQ39FVeOdAHbLAHpcobRv2D0VRIWe9s4vxDye1Q
   GW+YN53hKqvBJ4oTE2uqSeKoNla6MDVhm6P2+Ko5TrKWy1crhpK2tfNn0
   yG2dmK3Pc23n7V+PSJZSQ5fG6hyr/Vxgr99Z7RRaRiftAY5C9G47yObS7
   nsd01BVEryxMTGs1Y8zVyg1pueefkOeq435dGK6evKEvNkCAzlYGrghst
   19TDG9r5o6y73N6cVXYpaYMDrSD53tMxg4ddPZWTCt/oKKmWrAaBQalMu
   DmxZwVZo5ifM7oWjdYhBKN6+H1g3Js4sav77tvgNcbV/dj+ac5+ejj5tQ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654531200"; 
   d="scan'208";a="210104163"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 15:48:54 +0800
IronPort-SDR: h24yPhG13ymLa235uHc1pQrC/r1ZV+aukeil/pV+r+Eo0BUrG0C3XYMGy/jw9EnCBPOAS2yLLr
 X9k7BSgbNHJnTQqxL4HzghQ9Bg9H7X2cTKB1Z3tYsX+u0NNdti0aj6O8Dm8AimrtH5UpDzK25H
 CaIKoLQkYBbpTsk8fEkW+uPovU6iM2YvzsIbLQFoCGA0JtHdHrstwtipyTyuc4gm5f2HgTL8VD
 WtHkse6GcRaYJej/Kh/Twrtta6Pry408qcOk6v+R7npvwlsTtfo+tHLASeBOwWqMm/yXBBArUJ
 Qx7kEHsfty9W7KvMNKbWUA+e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 00:09:24 -0700
IronPort-SDR: ahaSs5Fi1kiG/59DZkBqH4Sga1kkk1xDZfehhAtvEwt1j5dqxJ10dC7El5OEBfLhu0cH/Z2nyz
 EtTt5tTm+t/EUpIniVWP18rKFC+4zpnJIl+M0l0JvHDwc927d4YNXjax1ZB9gGHkeOvYezMfLi
 PgXaEsfzfGC47fTw8nxFW8dTAvjvObbkzAxTtmToN5B0YABkdqf69LfFWSQX61KlHolyG6xumE
 pWHStUYvzW5vbASGSBMT/uB3apgO9+5pPKcjgaZ+rRfCc6ParGD7LEuvP6q6xA6t1Rr1nYcHyq
 yhE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 00:48:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MHbsL0YgMz1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2022 00:48:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661932133; x=1664524134; bh=gosABvYtW2DaWCzPPRMyHqL7697IheR91Fw
        9Iq8bGLc=; b=J9FhTuS3iVSOotU9PH6O76T21RHTq3cE8jLMxF9pv7mdBAoOQeM
        hXcqmhPDMouMAkE3yhy3r2qycPhDrio6FIIlHvcy3/4FT2BLbSWrYSz9zjjrnRVf
        lOTeHZdKvNbQjP1vCGle5+Zi4w7xjyfSwySjbdghNLFrxWR+ogrQVTiQWQ7PgiZy
        2Scy/Dz0maoaiLsq/2mVcaCsxdl//m0UckzIbEHRMLG+kPz5LumJwDKvGGhUXZlV
        Fx+exgjiAbvCWm/UKOscXrd6DY++bUKwaz6Ji9gjb4n6cRpfsNWzmBvGsddxTolX
        Zwg7fLetO0fbfpWPy/XNSKFJdV/vUYX6nnA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HXljdTC-D9yz for <linux-ide@vger.kernel.org>;
        Wed, 31 Aug 2022 00:48:53 -0700 (PDT)
Received: from [10.225.163.52] (unknown [10.225.163.52])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MHbsJ75QLz1RvLy;
        Wed, 31 Aug 2022 00:48:52 -0700 (PDT)
Message-ID: <ab34bac2-a48e-a247-b79c-c1e55bbad98c@opensource.wdc.com>
Date:   Wed, 31 Aug 2022 16:48:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <13bae786-c912-500a-ab60-af88f63ca576@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/31/22 16:15, Hannes Reinecke wrote:
> On 8/31/22 03:40, Damien Le Moal wrote:
>> On 2022/08/30 16:02, Peter Fr=C3=B6hlich wrote:
>>> On Tue, Aug 30, 2022 at 1:26 AM Damien Le Moal <Damien.LeMoal@wdc.com=
> wrote:
>>>> On Mon, 2022-08-29 at 08:04 +0200, Peter Fr=C3=B6hlich wrote:
>>>>> That's the sense_table, I was referring to the stat_table. That tab=
le
>>>>> is consulted when we fail to convert via the sense_table.
>>>> ...
>>>> So looking at the right code again, this is all very strange. E.g. t=
he
>>>> ACS specs define bit 5 of the status field as the "device fault" bit=
,
>>>> but the code looks at 0x08, so bit 3. For write command, the definit=
ion
>>>> is:
>>>>
>>>> STATUS
>>>> Bit Description
>>>> 7:6 Transport Dependent =E2=80=93 See 6.2.11
>>>> 5 DEVICE FAULT bit =E2=80=93 See 6.2.6
>>>> 4 N/A
>>>> 3 Transport Dependent =E2=80=93 See 6.2.11
>>>> 2 N/A
>>>> 1 SENSE DATA AVAILABLE bit =E2=80=93 See 6.2.9
>>>> 0 ERROR bit =E2=80=93 See 6.2.8
>>>>
>>>> And the code is:
>>>>
>>>>          static const unsigned char stat_table[][4] =3D {
>>>>                  /* Must be first because BUSY means no other bits v=
alid
>>>> */
>>>>                  {0x80,          ABORTED_COMMAND, 0x47, 0x00},
>>>>                  // Busy, fake parity for now
>>>>                  {0x40,          ILLEGAL_REQUEST, 0x21, 0x04},
>>>>                  // Device ready, unaligned write command
>>>>                  {0x20,          HARDWARE_ERROR,  0x44, 0x00},
>>>>                  // Device fault, internal target failure
>>>>                  {0x08,          ABORTED_COMMAND, 0x47, 0x00},
>>>>                  // Timed out in xfer, fake parity for now
>>>>                  {0x04,          RECOVERED_ERROR, 0x11, 0x00},
>>>>                  // Recovered ECC error    Medium error, recovered
>>>>                  {0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>>>>          };
>>>>
>>>> So this does not match at all. Something wrong here, or, the "status=
"
>>>> field being observed here is not the one I am thinking of. Checking
>>>> AHCI & SATA-IO specs, I do not see anything matching there either.
>>>
>>> Thank you for confirming that this section *is* confusing. I was down
>>> the same rabbit-hole checking "status" in whatever ATA spec I could
>>> get my hands on, and it didn't help. Specifically for "WRITE DMA"
>>> where I usually see the error, it seems that bit 6 has no other
>>> meaning than "transport dependent" which for SATA means (I believe)
>>> "drive ready" as it's always been. But that 0x40 is *not* an
>>> "unaligned write" whatever else it may be. My suspicion is that maybe
>>> it went in by accident since it's also in a "whitespace" commit. On
>>> the other hand, it has an explicit comment. I wasn't going to bother
>>> the original author before, but maybe now I should?
>>
>> +Hannes
>>
>> Except for bit 0x20 (device fault), the other bits do not match anythi=
ng
>> sensible either. So I wonder what specs this is against. Hannes ? 7-ye=
ars old
>> patch... I am sure your memory is very fresh about this one :)
>>
> Oh, of course :-)
> That was when doing SMR support for libata.
> I dimly remember that some pre-spec drives had been using the DRDY bit=20
> to signal an unaligned write. Which never made it into the spec, but th=
e=20
> decoding stayed.

Any idea where the other bits come from ? Except for bit 5 (device fault)=
,
I do not see anything else in the specs that mandate these definitions...

> Will be sending a patch.

Thanks !

>=20
> Cheers,
>=20
> Hannes


--=20
Damien Le Moal
Western Digital Research
