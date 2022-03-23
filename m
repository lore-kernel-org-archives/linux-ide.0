Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF4C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 09:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiCWJlF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237859AbiCWJlA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 05:41:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10063765A5
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648028371; x=1679564371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FTJYvcEKh88IXVIutP8lw3EEzoaIqJFhqvHZexm7O94=;
  b=PYQlxxwgvASXOW8EtWa3VJ/qRKIVO0bEy7TkIIZvKsJP+RSDUaZR67MP
   qfVsQPhUZBtIWN53lgKg48FBuiRoGnjoDZQuk7hZ/1/dDGaHL2/XyCUPL
   SgbvXwzm8WoT0j9Qq8KXFc6nRWpnoC49Tif4D0P71pI5jMhMc+PVyQQTy
   9xLegt6KZ3Q3Ax/B0a+p/PgtRO0Bgpv29JwOr7YEFJ14btgAkxJlK0VsC
   JLeu1o2kZ4VO1Y9ZDLUOrDmvd4mqA9s0KJ9Br0zGyCHCFyWhssGJeKAeg
   YyR/uOzUb2mpO/ajBpu+ZCesVTDm3Bdrk5O/KnsXDvrbTd/wK48iDnNiH
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="194954108"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 17:39:30 +0800
IronPort-SDR: vGbreChp1veO2Bucc/sK5O1Yp3eo/TwRemIqHTz8nDOJeBa36+KyHag7h71WiwohRFspmPRMUo
 urULZLwepmJAq5lcKz0bIRmrlQgTIRMsstUHchETAxVM6KT/EJD4OkdQtvToxTJuL0pr/xN9iY
 ZilZbOpeqT2qLE9rIMFWoyc6rHb96O2kqrCtN9Z5Y1NT3QTdl8OiQRt3GhdVVj25M2vM0mEFNy
 iIyBgC/9l/fBcAWc4MQqYjVsbYNF2aKaZ1OHr/TZZjbbyXcOnwdnpT6toNAlpV6tIOuNfUippz
 OpWKkF5lrC1Ni2BGSkvIfvrO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:10:28 -0700
IronPort-SDR: sdPyPnQs6PdyNUzabE42B8XJp1CgRslmiBsxiTZIlxPkYmxP+HG3AYE6qRtSc6tkEMlrHBdm8/
 CmVWjD/shVVKosatNQlS9t2/FwWXTtu2ZbF3Lg/ocYVs66lcBe6SRfXNpLiYk9p5B9I28YbQvD
 eXKqLM3QE1cG4qvqBPah7nO7zc72GPxLTr6bYsI5dnlTUb4oTb6BtNdz1v6wnXkma9wi3MmRpE
 8Fs5OWIGM1C6bnegRIAf4fWN5RPAy9iQwvFDT9/y9+4DQoUulgscVJPUE4JApbtRZyleTvIoqL
 i4Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:39:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNjxG0qjBz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 02:39:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648028369; x=1650620370; bh=FTJYvcEKh88IXVIutP8lw3EEzoaIqJFhqvH
        Zexm7O94=; b=eIOrM706nB4Np68fGzt/eGDFFSd3nlUn3umT52J4fcx7jOSbcwk
        +84PDvU0fNYMsQtCdDOz/r5/Wkelcy1jSyLmE1iV3JZRU9YdrJnqPRZ/C+HIEYMs
        bMQQEm3Ibh4PvM/oAHoA28K95wYzDrFOlkri/YnUIo73Ef/hp8Q5ntDkwuuN+seP
        yIJ7FugyzIhkru1RTTFauWuJXx8s1/2ZyIg2lG1zlGGpOnJmFFb1HEUKTLCBMBsQ
        FGsu/e3aizr6x7KkRBl4hwB1Aqvb0b9xI2HpE3GsiHUKBwWyhpeTIRf8B9QdGczn
        GliuseyXe36tKZto8epyFbuIaT8+MHueSdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W0KX5UYYgIfo for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 02:39:29 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNjxF0tHjz1Rvlx;
        Wed, 23 Mar 2022 02:39:28 -0700 (PDT)
Message-ID: <e272c885-58f8-b046-a951-9069601afba8@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 18:39:27 +0900
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

I am working on another series for that. The patches will allow
controlling most horkage and link flags on/off using libata.force kernel
boot parameter. That will allow figuring out problems without patching in
the field, for patches to be later added.

I do not think we need to have the flexibility of changing the debounce
delay. The 200ms delay is already arbitrary. There is no reliable way of
figuring out the ideal short delay. So havin "on" (default patch applied)=
,
and "off" (delay added like before) is enough I think.

>=20
>=20
> Kind regards,
>=20
> Paul


--=20
Damien Le Moal
Western Digital Research
