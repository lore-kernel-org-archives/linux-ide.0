Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C20C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 11 May 2022 08:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiEKIOp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 May 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiEKIOp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2022 04:14:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD070E5294
        for <linux-ide@vger.kernel.org>; Wed, 11 May 2022 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652256883; x=1683792883;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PFU8IMQsEiWRX1qpZSXmlY0U9P/YafiWv6/VwgFbRRA=;
  b=rKNeUkAuYNJGCzh1VB6sSE6XOE+wmzgPFAdQ4uhUu+oUNruJ9A5AY4P7
   3guwfyap08YPdfxum0YqZyezcftGPhGwRuqfoPPv+uCFMPXblMy/hN+5A
   4oYi4yXBZAiNf8UeXc0yoPONtkiteO7z2Zo5APAvnRXP2TRo7JIP/rizQ
   VvLf7RueEJRK83iCuEqg3nD5rfY8VqdABjbbJkPFh10qGpXmSJm0Qy2l8
   DQGkV9NOCJwQMDL0tndCh32FnUgnYpic8lhMCVUCn+e7jeqLwxo2ims3F
   +a7kgBnT0+GXiyiPlJZZHtahC9cHbIjgapMcOZTKYjaa6kHw+abrwuQSd
   g==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647273600"; 
   d="scan'208";a="312026688"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2022 16:14:42 +0800
IronPort-SDR: 13g7k/to/7r1wXY8bDhrJXwg11pMzYGhvYnNgAJ9sxlGBLF4Ssod/oFvBRM7ANqxB4jRadgdaQ
 12kQILZF2Zg8OlsPvgobUF13bNMGD4PGjunj3aIqUVA/XGSEGH0OG7XcrLjqFnhl/uwUB4gDFa
 JEEQ9tEKvdVyvHDn/JEDno8jKffZsej0nmteyu/cuEb1dWyzV6hXrsbe3HgAa+H3SQvDKbCfR6
 3swheniBCaRFXtdbJLzEC5bI3RR4Dq9Tww6qyZqHtwi0Jv8BjZBD6OeHmbDH7XktNruiICT/3O
 y6SDV9qwm9wsWwjB9AwI/hLh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2022 00:43:26 -0700
IronPort-SDR: lxhzUxJpmUibrEKkid69BhTWYi3ReBU8/LAUsyOnmvADKQAhz+4x0iwb5OGvLjrTcNBjC5irnZ
 eBDN6OwkVMFJrT17qtb0jNSpuyZbdLznNaDRVtiZeruNmzKMfuaZjX+/s4J7nblVlMR0XNY2+g
 pqQjTEfXMUmzOarF/XESp5QyAqMp9wkhUwZyqBzqIXiM/x5HwpO30iJwpU9jxjkBRTVsOEHtVe
 yKf543fujNBH/3MMqPgNKtcsSt/8tYU83drZfSgM8RWhWVDuic+fwyn+dfUhz6nP8pQ8vp3tfN
 egI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2022 01:14:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kynkp1gVmz1SVnx
        for <linux-ide@vger.kernel.org>; Wed, 11 May 2022 01:14:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652256881; x=1654848882; bh=PFU8IMQsEiWRX1qpZSXmlY0U9P/YafiWv6/
        VwgFbRRA=; b=sp5UzvpniyNEwdISDdHcMK8lZfmVaBeWSCiJtO/NREd2C3SGOmh
        sGtCMydW1zyRE0stg9/pokGplmQhFZu+vzspAWjaDkwzMBdNLW44y944x7ct7M+p
        HFuhywA5K5Q7al7ObsXDoP4v8oICJo7qUMLV7aUgpbCmYUxj2LyIXZ8dpvOaydS2
        l376dZ5m+2kYla0P70BzhDKif/jS+GleM/Xicd1n9vKnWqTwR3QdrizxvKvhavPj
        CvxTZS+jhH5159RsmBbBA//P6LjQz/0yBOOLGqz7BUv4/HnhHpxNrn3M+HZciDr2
        mb8fW8JeQNHUbluRXErHcx8+VKTeipYNVJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iFZVAJRh9Jkb for <linux-ide@vger.kernel.org>;
        Wed, 11 May 2022 01:14:41 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kynkl4QL5z1Rvlc;
        Wed, 11 May 2022 01:14:39 -0700 (PDT)
Message-ID: <c5462af9-eddc-5b39-253f-680f57aacc09@opensource.wdc.com>
Date:   Wed, 11 May 2022 10:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
 capability
Content-Language: en-US
To:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>, linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Cobe Chen <CobeChen@zhaoxin.com>, Tim Guo <TimGuo@zhaoxin.com>,
        TonyW Wang <TonyWWang@zhaoxin.com>,
        Leo Liu <LeoLiu@zhaoxin.com>
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com>
 <244f0c98-13f4-1ac4-9ebe-facdad4ae8b6@opensource.wdc.com>
 <af0571fe-a8f4-cb0a-323f-4dc0c4e7517d@zhaoxin.com>
 <ffc33fd4-a676-167d-ec2c-18e8211f2858@opensource.wdc.com>
 <349b0922-7efd-99e9-7bc8-b18ed98d94f8@zhaoxin.com>
 <e0213b8b-daea-7e75-793c-50f39956f932@opensource.wdc.com>
 <4824f9b5-92c1-a53b-2174-1d096e723e13@zhaoxin.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4824f9b5-92c1-a53b-2174-1d096e723e13@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/07 9:36, Runa Guo-oc wrote:
> On 2022/5/2 21:05, Damien Le Moal wrote:
>> On 2022/04/27 19:18, Runa Guo-oc wrote:
>>> On 2022/4/23 6:37, Damien Le Moal wrote:
>>>> On 4/22/22 18:57, RunaGuo-oc wrote:
>>>>> On 2022/4/21 18:39, Damien Le Moal wrote:
>>>>>> On 4/21/22 18:43, Runa Guo-oc wrote:
>>>>>>> On some platform, when OS enables LPM by default (eg, min_power),
>>>>>>> then, PhyRdy Change cannot be detected if ahci supports no LPM.
>>>>>> Do you mean "...if the ahci adapter does not support LPM." ?
>>>>> Yes.
>>>>>
>>>>>> If that is what you mean, then min_power should not be set.
>>>>> Yes, I agree with you. But, as we know, link_power_management
>>>>> is a user policy which can be modified, if some users are not
>>>>> familiar with ahci spec, then the above case may happen.
>>>> Users should *never* need to be aware of the HW specs and what can o=
r
>>>> cannot be done with a particular adapter/drive. User actions trying =
to
>>>> enable an unsupported feature should be failed, always.
>>>>
>>>> In your case though, quickly checking the AHCI specs, the scontrol
>>>> register bits you change seem to be for preventing *device* initiate=
d
>>>> power mode transitions, not user/host initiated operations. Your com=
mit
>>>> message should clearly mention that. But I still need to spend more =
time
>>>> re-reading the specs to confirm. Will do that next week.
>>>>
>>>> Since you added the CAP flags, these flags should be used to detect =
low
>>>> power policies that can be allowed for user actions.
>>>>
>>>> Mario,
>>>>
>>>> Please rebase and repost your patches ! I rebased the for-5.19 branc=
h on
>>>> rc3 to have the LPM config name revert. We need to fix this LPM mess=
 :)
>>>>
>>>>>>     Mario has patches to fix that.
>>>>>    =20
>>>>> Hmm. How to patch this case ?
>>>> Mario's patches modify the beginning of the sata_link_scr_lpm() func=
tion
>>>> to prevent setting an LPM policy that the adapter/drive does not sup=
port.
>>>> This together with the correct bits set/reset in the scr register wi=
ll
>>>> only allow LPM transitions that are supported.
>>>>
>>>> It may also be good to revisit ata_scsi_lpm_store() to prevent the u=
ser
>>>> from setting an unsupported policy. Currently, that uselessly trigge=
rs an
>>>> EH sequence.
>>> To avoid some confusion in this patch set, I want to explain it here.
>>> The patch set involves two LPM related issues, one for the ahci adapt=
er
>>> does not support LPM (no partial & slumber & devslp), the other for
>>> ahci adapter supports part of LPM(eg, only partial, no slumber & devs=
lp).
>>>
>>> The former case is what I metioned in this mail thread. Namely, when =
LPM is
>>> enabled, actions trying to enable this unsupported feature will be fa=
iled,
>>> but will disable PORT_IRQ_PHYRDY bit at the beginning of the ahci_set=
_lpm()
>>> function, which would make PhyRdy Changed cannot be detected. So I ad=
d flags
>>> in the ata_eh_set_lpm() function which will not go to the disable ope=
ration.
>>>
>>> The latter case is what I metioned in "PATCH[2/2]". Namely, if the ah=
ci
>>> adapter only supports partial (no slumber & devslp), then when LPM is=
 enabled
>>> (eg, min_power), *device* initiated power mode transitions will be en=
abled
>>> with the scontrol register bits setting to indicate no restrictions o=
n LPM
>>> transitions. After that, if SSD/HDD sends a DIPM slumber request, it =
cannot
>>> be disallowed by ahci adpter for driver not setting scontrol register=
 bits
>>> properly. So I add flags to control it.
>>>
>>> Therefore, Mario's patches in the sata_link_scr_lpm() function may fi=
x the
>>> issue in "PATCH[2/2]".
>>>
>>> Revisit ata_scsi_lpm_store() to prevent the user from setting an unsu=
pported
>>> policy may be a way to fix the issue in "PATCH[1/2]", but there may b=
e another
>>> case where some operating system manufacturers setting LPM default en=
able in
>>> driver, like the following code in the ahci_init_one() function, also=
 need to
>>> control.
>>>
>>> 	if (ap->flags & ATA_FLAG_EM)
>>> 		ap->em_message_type =3D hpriv->em_msg_type;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ap->target_lpm_policy =3D=
 ATA_LPM_MIN_POWER;
>> This one looks wrong. This is set inside ahci_update_initial_lpm_polic=
y()
>> according to the default kernel config (CONFIG_SATA_MOBILE_LPM_POLICY)=
 and
>> module param + what the drive can do according to ACPI. The problem th=
ough is
>> that the adapter capabilities are not checked in that function, so the=
 initial
>> target lpm policy may be wrong.
>>
>> Since your patch 1/2 adds the hpriv flags indicating the capabilities,=
 you need
>> to use these in ahci_update_initial_lpm_policy() to validate whatever =
initial
>> policy is asked for by the user.
>=20
> Yes, the above code is not rigorous, existing methods provided by kerne=
l as you
> said should be used in this case.
>=20
> In order to use CAP flags to validate user policy, I review the latest =
kernel
> LPM policies, here is my understanding:
> ATA_LPM_UNKNOWN: default policy, no LPM
> ATA_LPM_MAX_POWER: disable LPM (hipm & dipm)
> ATA_LPM_MED_POWER: enable hipm partial
> ATA_LPM_MED_POWER_WITH_DIPM: enable hipm partial &dipm partial &slumber
> ATA_LPM_MIN_POWER_WITH_PARTIAL: enable hipm partial &dipm partial&slumb=
er&devslp
> ATA_LPM_MIN_POWER: enable hipm slumber &dipm partial &slumber &devslp
> hipm: adpter initiated power mode transitions;
> dipm:*device* initiated power mode transitions;
>=20
>  From my comprehension, user policy in [ATA_LPM_MED_POWER, ATA_LPM_MIN_=
POWER]
> need to be validated on adapter's capabilities (partial(y/n), slumber(y=
/n),
> devslp(y/n)), so, there exits the following cases:

Note that devslp is a device side feature too. See ata_dev_config_devslp(=
) in
libata-core.c. So even if the adapter supports devslp, if the drive does =
not,
devslp should not be enabled on the port.

> 1, (n, n, n), validate=C2=A0 it to ATA_LPM_UNKNOWN;
> 2, (n, n, y), validate=C2=A0 it to=C2=A0 ATA_LPM_MIN_POWER_WITH_PARTIAL=
/ATA_LPM_MIN_POWER?
> 3, (n, y, n), validate=C2=A0 it to ATA_LPM_MIN_POWER;
> 4, (n, y, y), validate=C2=A0 it to ATA_LPM_MIN_POWER;
> 5, (y, n, n), validate=C2=A0 it to ATA_LPM_MED_POWER;
> 6, (y, n, y), validate=C2=A0 it to ATA_LPM_MIN_POWER_WITH_PARTIAL;
> 7, (y, y, n), default user policy;
> 8, (y, y, y), default user policy;
> ('y' for support, 'n' for not support)
>=20
> for case 2, I'm not quiet sure, for which may enable hipm partial/slumb=
er.

For all above cases, the default should be to use the default configured =
policy
defined by SATA_MOBILE_LPM_POLICY or the ahci module parameter but correc=
ted to
match what the adapter & device support, including the eventual NO LPM ho=
rkage
flag. Mario's patch started addressing that, but that patch can be improv=
ed
using yours.

> The way I provided above is quiet complicated and may be incomplete.
> It may not be realistic to take all into account, but I think case 1 sh=
ould
> be taken seriously for which may cause the above PORT_IRQ_PHYRDY issue.

yes.

> Perhaps, I could refer to Mario's patches later (I have not found yet o=
n
> kernel/git ^_^).

Mario's patch is here:

https://lore.kernel.org/all/20220404194510.9206-2-mario.limonciello@amd.c=
om/

Can you add that patch into your series with eventual modifications to be=
tter
check the adapter's CAP bits ?

Mario ? Are you OK with that ?


--=20
Damien Le Moal
Western Digital Research
