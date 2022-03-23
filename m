Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58355C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 09:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbiCWJg0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiCWJgX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 05:36:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E6B6E7B4
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648028093; x=1679564093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pA+aL4V/+sEySZweyCuvrVJiDZG715C4DkiJs1aN594=;
  b=X75MueOh9N6AWLfh3cQqhGlG8IhmwKUgoMYqz4HBOgf+BYYHSl3TIWon
   I4mQodalzpLKCGpWPDN3Aa6DxTP1c4OPN2dqtnQiyJA+2h+r8MZZ4Kz1G
   k6z4fdE1YM5HAgQxWVngP/AZvkCeQIbq9W6qghatWMn3i//F4IosDotev
   x/jFBInoRVJBmU8tEqxQ5AUJnZ/BNl5+nBa0C2K+HcZZH/QiVyMckLYws
   l5ILJIS9jsaZCAjcw3MfBpn6hK3Gk9fGX1DgboSr7guFI3p09nZspluqx
   c8UNXbA3po5sh1pueUuNT3uLO2uJevLdBJeY/mefAaN9zOBqMqJ/imDgF
   A==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="200897121"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 17:34:52 +0800
IronPort-SDR: e9Amvtt1vhUSTxlmZGu6gD8nGnMvf353CQWHQDGdMd2xdCoPL15Fm0zu+/MtibQqbwwLSyVOgp
 9hQrd4nNuBC3m69nLf2Ga2JtAITGwvlUQrt7yi3m3Yq1FDlINeaysr22tWsgBe5UfIHIReNatc
 7W5Zi+hMABcGoQSlZlS4dUzNeOKuqbHoHxLCSxIVmHMBhIUMO+1od4FpJa5BK7h8YQMrO1ivUK
 gJUhQYZx75CgLVaEN28a86e/HWsunf8BW4OR/4ig/0LFoXpaZu5I0sWcWE0wFvlh954cmW1Sel
 5KCUxApghtw3eVH+hOjljjko
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:06:47 -0700
IronPort-SDR: qZojjopXdfxNfuvtvDR22ZVxfp+XIjgxe9Fc/N4NbDt7h7wDWlfhTSE+FIptfNvDys6AYmou7C
 aTFz3hyD9euOeRyrO8qf2EcWBRkOYsuSYdkT7vRZ6Os2pT4Aw4jy/+gqpglKKnAu/Uew5M6JN4
 Xbff5qEP6qrDmd49KH50oGVXz/opMMP7IkowSfcBNFN9Wnxw6X7Z9+ph8M27rpukyjmmiHJWCS
 Vye/ilYN0XJgzb0Te54BhbDoelOcJOw+pTfNAyEsXva7ixmijUr4snxP4VRktGTedKGAdRdZb+
 Izs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:34:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNjqw52YLz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 02:34:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648028092; x=1650620093; bh=pA+aL4V/+sEySZweyCuvrVJiDZG715C4Dki
        Js1aN594=; b=bjvcc5kpbRHlJTCtvZxniDek5AF1uraNLwKsG4EGL0A14GN8g+N
        XAwy7St9jUmC5YdT/oBDhltjEW/4IY7u9QRP5S3rDKsfeyezA19I7+BBL6C4glYd
        fse3pEUBgpuF5LMhtJTPrb2sYFBSdRRDFMrj23iK7QNgYDvpQsI39Wmm2jr47Qzp
        En6AbqnQIbHvRtLbCP2Dn2uP7v+JI0B4bdvJlpB+Mopkj9SGqlFUQR8c2qJEhgzy
        YCmauGxyMkyPZErPdNtGh3td9DBRRexEDP2AVsbxyP+z0n6M0XOV7gdncgNNLCR3
        WQBX7YJbZoFCP7jZJF421Fd2KkIsnCw2VSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2DBEIPi3Nznc for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 02:34:52 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNjqv31p0z1Rvlx;
        Wed, 23 Mar 2022 02:34:51 -0700 (PDT)
Message-ID: <ab9d54e8-0337-bc6c-c7b2-83d9e1df9ed7@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 18:34:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/4] Remove link debounce delays by default
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/23/22 17:43, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Thank you for sending these patches.
>=20
> Am 23.03.22 um 09:17 schrieb Damien Le Moal:
>> This series removes the long link debounce delays by default for all
>> adapters, except for those known to require these delays
>> (e.g. ata_piix).
>=20
> Is it know, or just a theory?
>=20
>> The first 2 patches are code cleanup improving the interface of severa=
l
>> functions handling delays.
>>
>> Patch 3 removes the long delay in sata_link_resume() and reverses the
>> link flag ATA_LFLAG_NO_DEBOUNCE_DELAY to ATA_LFLAG_DEBOUNCE_DELAY for
>> adapters to request the delay if needed.
>>
>> Patch 4 improves sata_link_debounce() by shortening the link stability
>> test, unless the link has the ATA_LFLAG_DEBOUNCE_DELAY flag set.
>>
>> This series was tested on a machine with 2 AHCI adapters (Intel and
>> Marvell) with a port-multiplier box attached to cover that case too.
>=20
> It=E2=80=99d be great if you gave an example benchmark.

No need for a benchmark. This is not hot path stuff. This code runs only
during device discovery on boot and on resume after suspend.
So apply the patches and reboot, check dmesg if you see errors or not and
if your disks are all there. Same after a suspend+resume.

>=20
>> Comments and lots of testing are welcome !
>>
>> Damien Le Moal (4):
>>    ata: libata-sata: Simplify sata_link_resume() interface
>>    ata: libata-sata: Introduce struct sata_deb_timing
>>    ata: libata-sata: Remove debounce delay by default
>>    ata: libata-sata: Improve sata_link_debounce()
>=20
> [=E2=80=A6]
>=20
> I am wondering how sure we can be, there won=E2=80=99t be any regressio=
ns? Not=20
> having the boot disk detected is quite a serious issue/regression, and=20
> it should be made easy for users to fix that without having to rebuild=20
> the Linux kernel. A Linux kernel CLI parameter to enable the delay woul=
d=20
> be helpful for effected users.
>=20
>=20
> Kind regards,
>=20
> Paul


--=20
Damien Le Moal
Western Digital Research
