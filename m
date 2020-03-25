Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B1FC54FD0
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC99820722
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HioPWdnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCYOAb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:00:31 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12804 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgCYOAb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 10:00:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7b63a30002>; Wed, 25 Mar 2020 06:58:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 25 Mar 2020 07:00:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 25 Mar 2020 07:00:30 -0700
Received: from [10.26.72.231] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar
 2020 14:00:27 +0000
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
To:     LABBE Corentin <clabbe@baylibre.com>,
        Nicolas Chauvet <kwizart@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        <pdeschrijver@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <axboe@kernel.dk>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-ide@vger.kernel.org>
References: <20200319074401.GA4116@Red>
 <CABr+WTnBmJsDZPjUxYkG98dTneDD1p8G=uRftVduTGYbY0ruqQ@mail.gmail.com>
 <20200325134003.GA27961@Red>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cf63d40c-7b84-60f6-76be-a13255e69c99@nvidia.com>
Date:   Wed, 25 Mar 2020 14:00:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325134003.GA27961@Red>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585144739; bh=EerULfemy2W+M7YTPQPDKXIDApM3m/+qcklquHsA850=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HioPWdnnu+6z3HdUYuZP9Yfg2iW3zipkeqVa89l7LiyD75kY2jRtJacOcbAaIHYKR
         AroeGPVnf8Yna6wGjB+4ebS/TJpjIM3xShlEuPOmOhUYrgUeV68iBY+0sAOj0Lglx4
         GwaOKLz9vZn4bDycD+Q70k2QgQFOq7WmOUVwhT1Wj6WoGAYCeQmwFXdmmZM4k3ldmS
         mJg9pbpDkGoULAOKsIfLvoib9EqOV7t5grzo0JL+TS1XU9Zq/ExADDCLlSeMYLKOV4
         mf69jlC87HOjwG77NFw403cMGNzEwA7YbqMr/E6lkwEMdO6wiD++b2t0rofUtLk8Xi
         YPVdmODECP57g==
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 25/03/2020 13:40, LABBE Corentin wrote:
> On Thu, Mar 19, 2020 at 08:55:38AM +0100, Nicolas Chauvet wrote:
>> Le jeu. 19 mars 2020 =C3=A0 08:44, LABBE Corentin <clabbe@baylibre.com> =
a =C3=A9crit :
>>>
>>> Hello
>>>
>>> sata doesnt work on tegra124-jetson-tk1 on next and master and at least=
 since 5.2 (but 5.1 works).
>>> [    0.492810] +5V_SATA: supplied by +5V_SYS
>>> [    0.493230] +12V_SATA: supplied by +VDD_MUX
>>> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci not =
found, using dummy regulator
>>> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy not f=
ound, using dummy regulator
>>> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci not =
found, using dummy regulator
>>> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy not f=
ound, using dummy regulator
>>> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci not =
found, using dummy regulator
>>> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy not f=
ound, using dummy regulator
>>> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target no=
t found, using dummy regulator
>>> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
>>> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI contro=
ller: -110
>>> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error -11=
0
>>> [   35.694269] +5V_SATA: disabling
>>> [   35.697438] +12V_SATA: disabling
>>
>> It looks strange, because (on same device) , I have sata working as
>> appropriate, but ethernet fails with me.
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D206217
>>
>> It might worth to have another report.
>>
>=20
> Hello
>=20
> Mine has ethernet works well. But I hit many problem with it and older ke=
rnel.
> Perhaps the 5.1.21, were I am stuck, does not have it.
>=20
> Anyway, the tegra of kerneci has the same SATA problem.
> https://storage.kernelci.org/next/master/next-20200325/arm/multi_v7_defco=
nfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/boot-tegra124-jetson-tk1.txt
>=20
> Maintainers, any idea on this sata issue ?

I have checked our bootlogs for v5.6-rc7 and don't see the issue with
either the tegra_defconfig or the multi_v7_defconfig. I am wondering if
this could be due a difference in the bootloader version. Currently we
are testing with a v2019.07 u-boot bootloader. Looks like the kernelci
board is using an older u-boot. Obviously it should still work, but
would be good to know if the reason why were are not seeing this is
because of the bootloader.

Another thing to check would be the pll_e clock frequency on a working
build and non-working build to see if there is a difference in the pll
frequency that is causing this.

Cheers
Jon

--=20
nvpublic
