Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DDFC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 06:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiCXGwy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXGwy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 02:52:54 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1379681F
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648104682; x=1679640682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MU41HtgVOpOBgs058KjZcPa4GN/eOty3Q7nwqVbTHEc=;
  b=oKXQDUG5m846isD/4chE8Fly+az1BJFUVFf+isJ41xtEYpRZd830jR8e
   jv+5CYk0MpTkIN7virTf3bl94iHLm3RmAudbSFEOKa0uVOgJKJCliIYxd
   sIFExOFCRi4V5QA3lIg1NPujL0LVQdKUxjH1sQ2XjgrTVf0JmwrlA+PiV
   WubYRnpYVPB5/kqjdSHRhNKGcDJ6a6rM1Fta4M7klPYVUNlhYC8HmjVQ7
   8MASvtsUmr9Nn8pYW8FlOKRGP2NBNE/Zo8HCmVJZJY5GCL1FAgr36YDks
   PES2iuMiCqR2ak7l7eEesR+p5/B4Sfi0XWWFIthq+oc5pb0ew50JWmTsh
   A==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="308092247"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 14:51:21 +0800
IronPort-SDR: Qi/K8w4xePRZp6B5ixsIHFvM2Fzuvp+idDiJPlz6thxntrXuGFy41FFg/HAgGlBRkHodOCn74G
 KR1sdOtIrxbw7kdwOv74FjZ8aMQ/O2edmyeNnJchWpJUV2i9fOwDFZ/9ZTRj7ok8ZllxxSAbB8
 i8RDk3k290KbcOhl67t/6I+5yFolOHlDvkxUBJchylUDyKzZPF9+2tWKXE7pM8p2CqZuVYJWnY
 jLQwq3FrrCE0q8nfqG3wLXu70hycyN4pwSajZfZVYNq3AWIGg64nTWETa+peQ+hLj0TOWnFGKd
 Ltj6mG86ao0aWa5o9mp5CNWl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:23:14 -0700
IronPort-SDR: ZmMxJurCHkvOd+uLeMw9oIKy1s1GTCnNfvRDvgoOOk9GxhY6wyEk6Z63H9a5dz5es7TdCGCWUT
 UT9W4n1ptRRM5FpqwFrm7iAdiIMCAH5DmiU0nAbiG5HnyjiNRIPHGPb5lYJgTHOfGOrOEY9/cr
 TxE51MoCulYunKQ6+m80uZAhUSnBYitHDSUtjD10pw4XFK3DxV+0Yw/WjPihdq7mgM55pQm+VX
 6n2fpGw7ujrEda0KjhOwY2k14VSMCOkAXdc2PnWebcfRLyKGa8FVrCvF0wtTdW9RhsWi+CRT4i
 /Ss=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:51:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPG8n54yBz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:51:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648104681; x=1650696682; bh=MU41HtgVOpOBgs058KjZcPa4GN/eOty3Q7n
        wqVbTHEc=; b=SVnrrl8CJcezuR6iYdNdJYysvcB7x32uBUOOaK8/hYDAzxMjF++
        18WCs+8ETgJPxx+2uMOOIw7eEotrvisAuVLgv5hABcWjoW9XvUVUZ+n6MmQ1u6Jy
        Ynx0Fmlv51q9tWn3WCT/tssYnrwMHRGF2TFzHCg8RI2h+nkd+r0K+aH6Uqp612eW
        dxtdXVrpb2qAEZQiZRqC/CAU9ezRRJiDPXPzrYzIcVTfEAry4jtdK1azIfNwtYHG
        WoB4Y2wX/glV7IVN38I/js/ObhCMsVJ638P4UX0D7fd9Q7O14CTjdNeUPVUfJGhK
        MOr0MN07Ib4xX0/CtBCU7kFs3G6J1YQscSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YfxBP_U2Xuxk for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 23:51:21 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPG8m3l6Cz1Rvlx;
        Wed, 23 Mar 2022 23:51:20 -0700 (PDT)
Message-ID: <4eb36fc5-fcd7-1661-c8e0-bfa1d4d922ae@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 15:51:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/4] Remove link debounce delays by default
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
 <e272c885-58f8-b046-a951-9069601afba8@opensource.wdc.com>
 <c1aaaaac-aacb-5e71-9dc9-db235e469a3d@molgen.mpg.de>
 <f755d95a-83e5-1d3c-9255-f0111ac4d273@opensource.wdc.com>
 <fb5c4bc7-3ee4-851d-08f5-e8c17ed81e18@molgen.mpg.de>
 <9b59a933-b5fc-732f-c3d5-650fe5125cab@opensource.wdc.com>
 <262f35db-71bb-2e3d-58e6-79b241b34c23@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <262f35db-71bb-2e3d-58e6-79b241b34c23@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 15:35, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Am 24.03.22 um 07:15 schrieb Damien Le Moal:
>> On 3/24/22 14:30, Paul Menzel wrote:
>=20
>>> Am 24.03.22 um 00:58 schrieb Damien Le Moal:
>>>> On 3/23/22 19:59, Paul Menzel wrote:
>>>>>>> It=E2=80=99d be great if you gave an example benchmark.
>>>>>>
>>>>>> No need for a benchmark. This is not hot path stuff. This code run=
s only
>>>>>> during device discovery on boot and on resume after suspend.
>>>>>> So apply the patches and reboot, check dmesg if you see errors or =
not and
>>>>>> if your disks are all there. Same after a suspend+resume.
>>>>>
>>>>> Yes, I know what I need to check. I meant, that you write without t=
his
>>>>> patchset my system with HBA controller X and 32 [vendor/model] disk=
s
>>>>> attached reaches the message Y in Z1 seconds, and with the series Z=
2
>>>>> seconds.
>>>>
>>>> There is going to be too much variation from machine to machine as t=
hat
>>>> depends on the adapter & devices used for testing. The only sensible=
 thing
>>>> to do is to compare timing before patching with timing after patchin=
g and
>>>> see if there are some gains. On my test rig, I have so many drives a=
nd
>>>> various HBAs connected that the boot time gains overall are nil. But=
 I do
>>>> see faster per-ata drive scan times.
>>>
>>> And for one of these it=E2=80=99d be great to have exact numbers. ;-)
>>>
>>>>>>>> Comments and lots of testing are welcome !
>>>>>>>>
>>>>>>>> Damien Le Moal (4):
>>>>>>>>       ata: libata-sata: Simplify sata_link_resume() interface
>>>>>>>>       ata: libata-sata: Introduce struct sata_deb_timing
>>>>>>>>       ata: libata-sata: Remove debounce delay by default
>>>>>>>>       ata: libata-sata: Improve sata_link_debounce()
>>>>>>>
>>>>>>> [=E2=80=A6]
>>>>>>>
>>>>>>> I am wondering how sure we can be, there won=E2=80=99t be any reg=
ressions? Not
>>>>>>> having the boot disk detected is quite a serious issue/regression=
, and
>>>>>>> it should be made easy for users to fix that without having to re=
build
>>>>>>> the Linux kernel. A Linux kernel CLI parameter to enable the dela=
y would
>>>>>>> be helpful for effected users.
>>>>>>
>>>>>> I am working on another series for that. The patches will allow
>>>>>> controlling most horkage and link flags on/off using libata.force =
kernel
>>>>>> boot parameter. That will allow figuring out problems without patc=
hing in
>>>>>> the field, for patches to be later added.
>>>>>
>>>>> Sounds good. But this needs to be available before the changes at h=
and,
>>>>> doesn=E2=80=99t it?
>>>>
>>>> Not really. For now, we need to check if these patches break anythin=
g,
>>>> regardless of the libata.force changes. I consider libata.force for =
field
>>>> debugging. A user should not have to use it to get a system running.=
 The
>>>> kernel should have sensible defaults for that and things should run =
out of
>>>> the box without the need for additional kernel boot parameters.
>>>
>>> Sorry, I have the feeling we misunderstand each other. Just to be cle=
ar,
>>> you are saying before shipping this to users, we can be 100 % certain
>>> that these changes won=E2=80=99t break any systems out there?
>>
>> The patches are only an improvement for what can be controlled using t=
he
>> libata.force boot parameter. No other change. So nothing will break wi=
th
>> these patches.
>=20
> Still we are misunderstanding each other? I am talking about the testin=
g=20
> and possible regressions of the debounce delay patches, and not the=20
> =E2=80=9Clibata.force/horkage patches=E2=80=9D.

Ah. OK. Then the answer is no, there is a possibility that the patches
break the detection of drives with some adapters. Most likely with old
systems. This is not 100% safe.

But the alternative is to keep the delays as is and keep patching as you
did for disabling the delays on systems that are identified as OK. And I
do not like this alternative either since I suspect that the majority of
recent drives+AHCI adapters will be OK.

I keep looking at the code to see how to reduce the risks. However, since
the code being patched runs before we even know what drive is connected,
we cannot for example rely on the drive specs version (old drive =3D=3D o=
ld
specs).

The safe approach will be to mark most adapters with
ATA_LFLAG_DEBOUNCE_DELAY and remove that flag for tested adapters, which
will be easier to do with the libata.force changes, which will allow
specifying "nodebounce_delay".

The problem though is that there are lots of AHCI adapters that do not
have an specific entry in ahci_port_info and use the default entry.
Changing that one is the main risk.

Still looking at the code to see what can be done to minimize that.


--=20
Damien Le Moal
Western Digital Research
