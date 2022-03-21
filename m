Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CFCC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 12:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbiCUM4f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiCUM4f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 08:56:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4795E4E3AE
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647867308; x=1679403308;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+QhIqko+Ggi1m+u3jstbhipqFe0zCsnmJvw/iBxjR6E=;
  b=W5JW4vSD+6bzi6ZwmlP6L1dBViq4IPn4YcFPXK0T0z+JdaoX+FU4v+07
   xuYuf+3BskLLS+EgXQW1t+w3MGHXz+8Kra8jyDpVO6703ThEMyBvxBfWk
   KF1pIN6oniwf8xkrhPsXGTjnU+2LJ6gzGaFeyZX/th60RCZPm0zWx1D/P
   t25K1qVN+MwmK/Bxf4hh5+g1DkDlemxL6FV9cJRPwxu1yQc/VKMmg+rac
   9FZsM9I5UpzBulmIXggtpbV4i8eCmG5ZmEdRzoAO4jEKen5bBp0P8iWCi
   wWuiVTLeAJ9TKpJsMbsLbm9riGqGcpSWUSRfKxiRmtb5BdE7B1CVytoqd
   w==;
X-IronPort-AV: E=Sophos;i="5.90,198,1643644800"; 
   d="scan'208";a="307823404"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2022 20:55:08 +0800
IronPort-SDR: bs/b4iVIWFI3BYoNn1FGYqXao3lCIKOJ6WPl8z8HFGqbYLqjYFiJ5/FpYKwXyaRGJYvK0wHfRX
 mBiU0d9EYc29ozyy6Zzb0C4GeuATAYIxp7FUm+VrvC5Z/kfbepmY5bEV1Jt0qIOxbjK5PeEu7X
 xcqMSgYX4eJJL34uqh87+53IoyYs235gwO/NZgMmcsDfArEv0V55ke6MLQDsmp1aEGFsWat8vB
 E4BqCSrl1saLa/ZlYYTVDHFY4SbrhMNSTKo+iKmB0MEfIESEZG89wuODja6dwdWS6gPsKxD1zz
 PjPRl1rh1KSPYH3XSeNiNaxb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:27:05 -0700
IronPort-SDR: oz4Y4BLDDyaTSAAxId8e/waNRr6lZPLoUlcIucgskggNI/CrPGSKbmbs4xb0cO+URgk+6rSq4j
 S4PzuSDQAhacMzo3L0r82141DN2W2D3gbNsGnTcFuqQPjt33g+rYnjCJcfTYb2BYmN0FIq47i+
 yRASswaKAgykavQ8RUCnNrnVrDCI4LdkjcSzDEW9MkSn7Mwe2qE6JGyWwNbProNNwPKt202vjH
 a9aTxTKXnLCDo9qFwVhFrBgAMcH/JWEVluO7qd9X11/hwm2xuJ8WJpw9e65DDyXrSX1+2pPrw6
 79Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:55:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KMZMw32Cjz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 05:55:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647867308; x=1650459309; bh=+QhIqko+Ggi1m+u3jstbhipqFe0zCsnmJvw
        /iBxjR6E=; b=AfEMdySFEPIEtqbMdSGjJLMmTfu/9Jo2qAxhC5HM+sOxSxJB5YY
        txyJSeHIFEdis23F+Vp8WxXN+RF8YedLvxH2zOMVN0o2ekxJjEs9Oyez9IDm3m8W
        6831BlbzIaR4kPZo0ncHmb8MQF/ksmmcEaF5gznItpXfyzxeO27EEK5jnx30LSje
        Mtvzak5PRac11uQIHDCRpwYEUO93W8zQitwVZOQ3HzdO9NH1Usp84w9Dfkd+7742
        7IMgyilpeXmtdr5X6rqj6tzQcfTVMXqIbFjypzm8cV6EC+G9DizAwcU74pxHFDAV
        0+3v2/gXjVdPJLQqR8KAsJHtCDPl4SASLtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jEHoYh9CHLcv for <linux-ide@vger.kernel.org>;
        Mon, 21 Mar 2022 05:55:08 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KMZMv3nbpz1Rvlx;
        Mon, 21 Mar 2022 05:55:07 -0700 (PDT)
Message-ID: <f18eafd6-29a0-f555-752a-ff265df58cb0@opensource.wdc.com>
Date:   Mon, 21 Mar 2022 21:55:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: How to match disk to controller in Linux log?
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>, linux-ide@vger.kernel.org
References: <36288054-bc9d-c80c-502e-79bddcacd5f6@molgen.mpg.de>
 <1343b9a0-c857-f800-58ca-141bc5d3dd93@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1343b9a0-c857-f800-58ca-141bc5d3dd93@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/21 18:52, Hannes Reinecke wrote:
> On 3/21/22 09:44, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> AMD Ryzen devices come with two SATA controllers:
>>
>>  =C2=A0=C2=A0=C2=A0 $ lspci -nn | grep SATA
>>  =C2=A0=C2=A0=C2=A0 01:00.1 SATA controller [0106]: Advanced Micro Dev=
ices, Inc. [AMD]=20
>> 300 Series Chipset SATA Controller [1022:43b7] (rev 02)
>>  =C2=A0=C2=A0=C2=A0 07:00.2 SATA controller [0106]: Advanced Micro Dev=
ices, Inc. [AMD]=20
>> FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
>>
>> lsscsi [1] in verbose mode shows the controller a disk is actually=20
>> attached to.
>>
>>  =C2=A0=C2=A0=C2=A0 $ lsscsi -v
>>  =C2=A0=C2=A0=C2=A0 [0:0:0:0]=C2=A0=C2=A0=C2=A0 disk=C2=A0=C2=A0=C2=A0=
 ATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ST500LM021-1KJ15 SDM1=C2=A0 /dev/sda
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dir: /sys/bus/scsi/devices/0:0:0:0=20
>> [/sys/devices/pci0000:00/0000:00:01.3/0000:01:00.1/ata1/host0/target0:=
0:0/0:0:0:0]=20
>>
>>
>> For analysis and bug reports, it=E2=80=99d be great if the Linux kerne=
l log=20
>> would contain that information too. But I am unable to find it. Is it=20
>> present?
>>
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.426850] calling=C2=A0 ahci_p=
ci_driver_init+0x0/0x1a @ 1
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.426869] ahci 0000:01:00.1: v=
ersion 3.0
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.426970] ahci 0000:01:00.1: S=
SS flag set, parallel bus scan=20
>> disabled
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427004] ahci 0000:01:00.1: A=
HCI 0001.0301 32 slots 8 ports 6=20
>> Gbps 0x33 impl SATA mode
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427008] ahci 0000:01:00.1: f=
lags: 64bit ncq sntf stag pm led=20
>> clo only pmp pio slum part sxs deso sadm sds apst
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427412] scsi host0: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427493] scsi host1: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427569] scsi host2: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427653] scsi host3: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427728] scsi host4: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427801] scsi host5: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427876] scsi host6: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427950] scsi host7: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427978] ata1: SATA max UDMA/=
133 abar m131072@0xf0600000 port=20
>> 0xf0600100 irq 36
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427982] ata2: SATA max UDMA/=
133 abar m131072@0xf0600000 port=20
>> 0xf0600180 irq 36
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427985] ata3: DUMMY
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427986] ata4: DUMMY
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427988] ata5: SATA max UDMA/=
133 abar m131072@0xf0600000 port=20
>> 0xf0600300 irq 36
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427991] ata6: SATA max UDMA/=
133 abar m131072@0xf0600000 port=20
>> 0xf0600380 irq 36
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427994] ata7: DUMMY
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.427995] ata8: DUMMY
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428015] ata1: hard resetting=
 link
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428116] ahci 0000:07:00.2: A=
HCI 0001.0301 32 slots 1 ports 6=20
>> Gbps 0x1 impl SATA mode
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428124] ahci 0000:07:00.2: f=
lags: 64bit ncq sntf ilck pm led=20
>> clo only pmp fbs pio slum part
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428250] scsi host8: ahci
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428278] ata9: SATA max UDMA/=
133 abar m4096@0xf0108000 port=20
>> 0xf0108100 irq 38
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428295] initcall ahci_pci_dr=
iver_init+0x0/0x1a returned 0=20
>> after 1409 usecs
>>  =C2=A0=C2=A0=C2=A0 [=E2=80=A6]
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.428316] ata9: hard resetting=
 link
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.532308] ata9: SATA link down=
 (SStatus 0 SControl 300)
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.696316] ata1: SATA link up 6=
.0 Gbps (SStatus 133 SControl 300)
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.725963] ata1.00: ATA-8: ST50=
0LM021-1KJ152, 0005SDM1, max=20
>> UDMA/133
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.725982] ata1.00: 976773168 s=
ectors, multi 16: LBA48 NCQ=20
>> (depth 32)
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.764845] ata1.00: configured =
for UDMA/133
>>
>> Can you think of a way and log format, what controller the disk is=20
>> actually attached to?
>>
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.765133] ata2: hard resetting=
 link
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.868330] ata2: SATA link down=
 (SStatus 0 SControl 300)
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.868965] ata5: hard resetting=
 link
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.973337] ata5: SATA link down=
 (SStatus 0 SControl 300)
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 0.973910] ata6: hard resetting=
 link
>>  =C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 1.077832] ata6: SATA link down=
 (SStatus 0 SControl 300)
>>
>=20
> It's 'magic' ... (/me waves magic wand)
> One does know where the ports are ... no?
>=20
> I did do a patch once (grep for 'libata: sysfs naming option'), but tha=
t=20
> got shelved as I didn't had a good idea how to handle PMP devices.
>=20
> Seems that I have to look at it again ...

Yes, that would be great. I have a PMP box hooked up to my test rig now, =
and for
good measure, it is filled with the oldest drives I could find (10+ years=
 old
drives that still work fine).
I am waiting to test your patch :)

>=20
> Cheers,
>=20
> Hannes


--=20
Damien Le Moal
Western Digital Research
