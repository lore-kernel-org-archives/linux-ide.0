Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC910C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D292560D07
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 07:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhJKHjx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 03:39:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5189 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhJKHjq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 03:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633937867; x=1665473867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P7aYqfLsunoz5xRdkhlhCgw65M/Gt92t09ekTgvoplc=;
  b=Jhg44zjyKE1K3nMgmIs8TWslhayj2yvqHi/H4QOkPuk2NmhYmqiCkgWU
   HIgVm6A0JrASAGmx8dGBexKdrPhxzCSJ+M2XGK5/YfIlxwsw1s+9gMZjf
   n+Ugkf+6DTshaQhTZ9ZIj8y6uUdZoty0fZYzo80UE0W9izUHWwGgol6cd
   k6SA9Gg5np5RZ6q2E/bsqyAZnZJwkR2/0frJrSBw17IBkYi5MTSIUSMHU
   pPvgA7aVvV1if5TMnGxsgYMBFH/8NybYKdgCwZaqZ3QEohcdN46BEMROY
   MctULL8aeKjLsGGcdLDBvxqwb2ifxcArV7amDjLQH7A50MUWgyc6H01pC
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286310333"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 15:37:45 +0800
IronPort-SDR: TcVfJTok2aiMxoAITB8tQtII/qmoC+sca7mRxmB/5ZWcj9PFqMGHCmbSTFR77sdSz/ETg7TIBI
 XC4y7wd1VKH1Rm6/vcYvy8V3W8RMUBbE5wgSxR9S8YVBbp+/6swUloRD7tr1SMlIM9ZWkgNNkf
 4lSjnnydCRaImYn00joeufqrDvywZLAjvdLhHKAj+itiu76HDZRpYN49W9kSv+p2Ns8Q8DMHs7
 L/9psze+sRnyjnpe0K6zHozLypcGoueoO+GtPKnCvNp615FCEn5xUds7eiE6L/nv3OrJIZQ1GS
 GjM9UJw43MIDDq66wCcquPJM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 00:12:02 -0700
IronPort-SDR: sFH4A9PTgzgpveNX3b6q3VjOMBG9oJqnv08ea3hE2AFM+OwNoo9EqyCb1H3LduIy9xlocvCbHN
 Uj9ox6wK/sySCFtwnXopKX9m9wAW1qzNCQwzQ8vfruafPla/kBlQJSgAb5N0Ivi/il5jzpwGC8
 EKnmMeeSRcoc9wIJa5TtLsb148kE9fsi3jbvCLGbTHdF4z8CzUBUVJqFzBXLsV+6h/ZJP4aFc2
 GkkxKt/dUAqpAvZokbvl4ajWICaYv1FX0ixt3WYSONF5skbiUWRrWl6bBDzmjTbjDfTwCfHBHg
 2HI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 00:37:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSVy12nBmz1RvTm
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 00:37:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1633937864; x=1636529865; bh=P7aYqfLsunoz5xRdkhlhCgw65M/Gt92t09e
        kTgvoplc=; b=cmFEH3Z2HM3R/1gVp3+UlEBV+paFxzMGc6jsz+VKgSbQ/fBI+tL
        RDr6hj7787zffhgo2/KA/+CX1mIhBLgCUYBKjgmf1zCSSUGXNISYMLwGxLaN3u4O
        AI1L46uRtlf6yFwu7P3TT+rjP1eMuj8PKt9087ZA3SZoDJ5dLw7M4aJ2Ow4CGz7t
        hoxKjwChXoyTMYHX9eP4aryJIurICC/mA9PaaG78IWb56lQdtLgrg6EmCG/oNSGL
        lrN8wd+au06ZYM1jGPEB43yx7tboR19pq7mjsPQMILTdiYx4ytIrWqK8NDbbToAN
        oAZ0tIOhQyRech0B+yIpyv8KYqyAKxzga4w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U-YoD3S9r2Qk for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 00:37:44 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSVy02ZvSz1RvTg;
        Mon, 11 Oct 2021 00:37:44 -0700 (PDT)
Message-ID: <42b5a0ad-3adf-83d1-1973-c50d8843e2dc@opensource.wdc.com>
Date:   Mon, 11 Oct 2021 16:37:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: Asmedia 0x0624 support in linux kernel - news, test results
Content-Language: en-US
To:     =?UTF-8?B?UG9uZ3LDoWN6IElzdHbDoW4=?= <pongracz.istvan@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org
References: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
 <ab2fde897de1bbbafcec8cf81e05346430c782a4.camel@gmail.com>
 <YVx5aRInLEvV3eaQ@slm.duckdns.org>
 <23d115f656a3834c24180621667ba87da4d6620f.camel@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <23d115f656a3834c24180621667ba87da4d6620f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/07 21:05, Pongr=C3=A1cz Istv=C3=A1n wrote:
> 2021. 10.  5, kedd keltez=C3=A9ssel 06.12-kor Tejun Heo ezt =C3=ADrta:
>> On Tue, Oct 05, 2021 at 02:58:31PM +0200, Pongr=C3=A1cz Istv=C3=A1n wr=
ote:
>>> Dear Tejun/All,
>>>
>>> I just downloaded the ubuntu kernel source version 5.4.140 and I
>>> modified the ahci.c file:
>>>
>>> I simply added the extra line with the pci id of the card as shown
>>> below:
>>> =20
>>> 	/* Asmedia */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>>>  	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
>>> + 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },=20

Similarly to the other entries above your addition, please add a comment =
at the
end of the line mentioning the adapter model.

>>>
>>>
>>>
>>> I built the kernel and rebooted the machine.
>>> Now the kernel can see disks attached to the card.
>>> As I just drop some hdds I had around, it seems I got some non-workin=
g
>>> hdds, so, I will have to get some proven working hdds to populate all
>>> the 10 sata channels and test them.
>>>
>>> Summary: at this point it seems with the modification above this card
>>> could work.
>>>
>>> If you need something I should do (test), please let me know, I would
>>> be happy to participate in this test.
>>
>> Looks like you're on the right path. Once you're happy with the result=
, can
>> you please submit the above as a signed-off patch?
>>
>> Thank you.
>=20
> Hi,
>=20
> An update about my test, short version:
> - I had to change my power supply to be able to feed all hdds
> - I have 2 pieces of 10 sata ports cards + motherboard 2
> - I installed win10 + asmedia driver provided with the card on a mini
> CD -> working.
> - I installed linuxmint 20.2 Mate and kernel source 5.4.140
> - I added the extra line to the ahci.c as shown above and compiled the
> kernel, installed etc.
> - with the new kernel, the system started and recognised all the hdds
> attached to the cards (2x7 HDDs)
>=20
> My result after about 24 hours of running, these cards are working
> well.
>=20
> Only one small thing I found, besides of ahci, pata_acpi still visible
>  as used kernel modules under the card.
> I have no idea, is it ok or not or how to remove pata_acpi if
> necessary.
>=20
> 02:00.0 IDE interface: ASMedia Technology Inc. Device 0624 (rev 01)
> (prog-if 85 [PCI native mode-only controller, supports bus mastering])
> 	Subsystem: ASMedia Technology Inc. Device 1060
> 	Flags: bus master, fast devsel, latency 0, IRQ 126
> 	I/O ports at d040 [size=3D8]
> 	I/O ports at d030 [size=3D4]
> 	I/O ports at d020 [size=3D8]
> 	I/O ports at d010 [size=3D4]
> 	I/O ports at d000 [size=3D16]
> 	Memory at 91280000 (32-bit, non-prefetchable) [size=3D8K]
> 	Expansion ROM at 91200000 [disabled] [size=3D512K]
> 	Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 	Capabilities: [78] Power Management version 3
> 	Capabilities: [80] Express Legacy Endpoint, MSI 00
> 	Capabilities: [100] Virtual Channel
> 	Capabilities: [800] Advanced Error Reporting
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci, pata_acpi
>=20
> 04:00.0 IDE interface: ASMedia Technology Inc. Device 0624 (rev 01)
> (prog-if 85 [PCI native mode-only controller, supports bus mastering])
> 	Subsystem: ASMedia Technology Inc. Device 1060
> 	Flags: bus master, fast devsel, latency 0, IRQ 127
> 	I/O ports at c040 [size=3D8]
> 	I/O ports at c030 [size=3D4]
> 	I/O ports at c020 [size=3D8]
> 	I/O ports at c010 [size=3D4]
> 	I/O ports at c000 [size=3D16]
> 	Memory at 91180000 (32-bit, non-prefetchable) [size=3D8K]
> 	Expansion ROM at 91100000 [disabled] [size=3D512K]
> 	Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 	Capabilities: [78] Power Management version 3
> 	Capabilities: [80] Express Legacy Endpoint, MSI 00
> 	Capabilities: [100] Virtual Channel
> 	Capabilities: [800] Advanced Error Reporting
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci, pata_acpi
>=20
>=20
> Anyway, I did not find any side effects up to now.=20
> s.m.a.r.t. is working, ssd/hdd recognised, I already use it with about
> 13TByte live data (so, software uses these data files on disks without
> problem etc.).
>=20
> So far so good.
>=20
> @Tejun, I am not a kernel developer, so, not really clear where to send
> the "patch" and for which kernel version :)

write your patch against the latest libata tree available at:

git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git

or

https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git

And use "git send-email" to send the patch to me and to linux-ide@vger.ke=
rnel.org.

Feel free to let me know if you have any problem.

Thanks.

--=20
Damien Le Moal
Western Digital Research
