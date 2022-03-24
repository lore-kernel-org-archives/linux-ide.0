Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7BFC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 06:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiCXGR0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiCXGRZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 02:17:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606A7B132
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648102554; x=1679638554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vtU8/WKrBiDhrZCh8ycWS3I+YCU9wvP3/WdzvJjGlQE=;
  b=ako6R8yFXr7ss7dj+48vf6BQVtD2fNrhEDeR52rwav6fA5k19lGWMipU
   imYIQ1W/Ry6j6ESmvbUpDvW7TPZeLDmRQnVDeYsaf8gdO3UXwWSltBXOz
   +m9tMig8sGfnQzfBpZeZ9wfrVjXapE9nZpRmADPZgWKShVUMKafjqMi5S
   H574GtXuXo5zzcurSNWg/HiDNBQXhscc/iBNh/DuugAjWYQ1cB5b5o2lX
   /McWQlgn12B7HCErt9Es/J6/DZOv5Y4SE/YMEEbcfw/m48ZS6LQ1fFGif
   wpCB/484Vk0unVzpSuBSL3wCx9jRSGoGFfSFIIcQok0J9Ws5U8smnga3N
   w==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="197058462"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 14:15:53 +0800
IronPort-SDR: sdKPWaSKFOgroctLY70vZsieIlcKppuVf+MAR+0ROVmbDFY15NL3ohaiMG1N6kyCvMj8AJ07lw
 /hDuCgywayySafLoGjxgCAE5bVAKuOcWcQhVrVfrTQHCMFbl6ABveGhDyA7yVGpXZgvOhAgT8r
 ZSvFdt7YnWv15xx2UMrJ9IlPu1u75TmGGikdS7q1uRVRHZ0cEdwUaYO8SBucEQZsd9uLMDosrQ
 wojJ44YcMsSSj0HT2UK7Yo7TvcrnjR8GrSFXGncP4XTVJip718saNZOaNjqZH244tVUzO39Ywm
 2KSmVEs6gbrd8JWpF6QICAoz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 22:47:44 -0700
IronPort-SDR: pJV1VbnO1zGvT6dQLWHOT12p2h3XX5hvnJNu9DuoBjX0JrpKSd+clyybIOhEpTNl38HylA7CKX
 2TPWNa+yOeiaSRf7GWi0dRMkWJdeQVm09LT8ORsdXShhxGIbJY+KfZu/VuWqOQfBa9qyCYvQFy
 H1kUgdRpfQZen8kBbz+ypmVfJaW2Cof+4kQgHmkdxH0gDfoNLUXDUeRM7fylau/yp+RzILpl47
 p6nnfzDBRF1R4ibWuhQ/2UqGgCGBs0G2zSn0Jo4Ql/Oiv2VuEcdqwoM98iQ58v7RkBMflnmR1L
 wdM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:15:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPFMr0gVxz1SVp0
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:15:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648102551; x=1650694552; bh=vtU8/WKrBiDhrZCh8ycWS3I+YCU9wvP3/Wd
        zvJjGlQE=; b=YcNNOO0OCJ7mybr8p1hn6CPxhWOZEDvMAUq9hgnqscEOm/BquGs
        fkozke6mm7LQGxk8tG1CApIgqon/zuYF/7KH9yPLF1xnets+ktrP3xfl9umYLSnd
        vCV/OH4Is2mIC9L/KO5HqbicfDrOHbemZLFfUgrTMqiy55XwaTrRWm+OVpwDHsGh
        iNXeARCHSY1ooJVPjxhz4re0jOLB7zJrVEJzXOxknuo/IPDJMbOemwU7MWD7NEu3
        phQU+IGZIQUwSFFDU9OmPWkIRwb7Pao7jJ9fh17YjJntdP8dPaQMrT4efJPKtITL
        m/yWK4fG8moLv4+nu96Pblk8rgSZ3KTDJqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kj6syd-enLlr for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 23:15:51 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPFMp63cBz1Rvlx;
        Wed, 23 Mar 2022 23:15:50 -0700 (PDT)
Message-ID: <9b59a933-b5fc-732f-c3d5-650fe5125cab@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 15:15:49 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fb5c4bc7-3ee4-851d-08f5-e8c17ed81e18@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 14:30, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Am 24.03.22 um 00:58 schrieb Damien Le Moal:
>> On 3/23/22 19:59, Paul Menzel wrote:
>>>>> It=E2=80=99d be great if you gave an example benchmark.
>>>>
>>>> No need for a benchmark. This is not hot path stuff. This code runs =
only
>>>> during device discovery on boot and on resume after suspend.
>>>> So apply the patches and reboot, check dmesg if you see errors or no=
t and
>>>> if your disks are all there. Same after a suspend+resume.
>>>
>>> Yes, I know what I need to check. I meant, that you write without thi=
s
>>> patchset my system with HBA controller X and 32 [vendor/model] disks
>>> attached reaches the message Y in Z1 seconds, and with the series Z2
>>> seconds.
>>
>> There is going to be too much variation from machine to machine as tha=
t
>> depends on the adapter & devices used for testing. The only sensible t=
hing
>> to do is to compare timing before patching with timing after patching =
and
>> see if there are some gains. On my test rig, I have so many drives and
>> various HBAs connected that the boot time gains overall are nil. But I=
 do
>> see faster per-ata drive scan times.
>=20
> And for one of these it=E2=80=99d be great to have exact numbers. ;-)
>=20
>>>>>> Comments and lots of testing are welcome !
>>>>>>
>>>>>> Damien Le Moal (4):
>>>>>>      ata: libata-sata: Simplify sata_link_resume() interface
>>>>>>      ata: libata-sata: Introduce struct sata_deb_timing
>>>>>>      ata: libata-sata: Remove debounce delay by default
>>>>>>      ata: libata-sata: Improve sata_link_debounce()
>>>>>
>>>>> [=E2=80=A6]
>>>>>
>>>>> I am wondering how sure we can be, there won=E2=80=99t be any regre=
ssions? Not
>>>>> having the boot disk detected is quite a serious issue/regression, =
and
>>>>> it should be made easy for users to fix that without having to rebu=
ild
>>>>> the Linux kernel. A Linux kernel CLI parameter to enable the delay =
would
>>>>> be helpful for effected users.
>>>>
>>>> I am working on another series for that. The patches will allow
>>>> controlling most horkage and link flags on/off using libata.force ke=
rnel
>>>> boot parameter. That will allow figuring out problems without patchi=
ng in
>>>> the field, for patches to be later added.
>>>
>>> Sounds good. But this needs to be available before the changes at han=
d,
>>> doesn=E2=80=99t it?
>>
>> Not really. For now, we need to check if these patches break anything,
>> regardless of the libata.force changes. I consider libata.force for fi=
eld
>> debugging. A user should not have to use it to get a system running. T=
he
>> kernel should have sensible defaults for that and things should run ou=
t of
>> the box without the need for additional kernel boot parameters.
>=20
> Sorry, I have the feeling we misunderstand each other. Just to be clear=
,=20
> you are saying before shipping this to users, we can be 100 % certain=20
> that these changes won=E2=80=99t break any systems out there?

The patches are only an improvement for what can be controlled using the
libata.force boot parameter. No other change. So nothing will break with
these patches.

See Documentation/admin-guide/kernel-parameters.txt and compare the list
of possible arguments that libata.force can take to the number of
ATA_HORKAGE and ATA_LFLAGS defined... There are many that cannot be
tweaked using libata.force, which is a pain when debugging a problem in
the field. With more arguments for libata.force, we can test adding by
default horkages/lflags for a device without having to patch and recompil=
e
a kernel, tasks that many end user do not know how to do.

--=20
Damien Le Moal
Western Digital Research
