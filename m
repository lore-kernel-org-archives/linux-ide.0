Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAE0C433EF
	for <linux-ide@archiver.kernel.org>; Mon,  2 May 2022 13:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiEBNJi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 May 2022 09:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385179AbiEBNIo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2022 09:08:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5161525C
        for <linux-ide@vger.kernel.org>; Mon,  2 May 2022 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651496714; x=1683032714;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gUVcDOtw+nlQMg2VBwPUo6UvRu/LOTc24AZm4gp4+tQ=;
  b=BP6ylgzxvytyrxt/cJVuFL/LIO5rISe5Zw8mW6o9/BK1LifewCwUtybw
   V2hx7/heszTAf/AyUA3fXAD5jug/C7ZfoI8L2vSeexwCzYfAbPo4QPGc6
   JopM58wPHH1so/QpU6fauBTeJ0XE+QvipcbPSxx4gjvLo3z/+6R9/dzCO
   I9G/svlTx1b7XcPyE2FjJtL6Cy9YrbwnGuNXNjAnWm3IRXyN3kOxMBGvH
   /uw4HmjUNRFi0lUIPjXBwdzLDfsbN2rTnVvMjMN4G2uX7pMwLyqvUaBTX
   4ca5kv+JmTPzzMDVAIynGLuTN2h4MSTwDAkMPYqV58tDWSq4qRhLJS/PB
   g==;
X-IronPort-AV: E=Sophos;i="5.91,192,1647273600"; 
   d="scan'208";a="311308131"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 21:05:13 +0800
IronPort-SDR: +lAortT7zmMbdgK6JCbDsL2B+znozvbrFDQ8iaLyEExcA4eQrSdEWPvEzol+qzH/qmSVrO+OBe
 H3o8kP6VkFMyey4MdwQ8O9HW8SNEAYtul+jAW5b8JFzOUOkuuQ/Etp+R6RTccO3qVLqvTVjIw/
 ly7YBJR3cl2nPxU4p2ZCAvMNYTQQ3lnWrLehpA5TG1d1jgrRONezvdKbajl6MgFt1F7WxOSLem
 F7qwlk2x7qimkd5yz3SzA/XyYse5jUyGle8eJXvQwJW0sRYHHTC8Jc7BBWfkrdi6T4wmHUEkR/
 UglE3AAMpkphkUEpqeiElp8C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 05:35:58 -0700
IronPort-SDR: +GlX53NyFTF6YQSmsUfNQ42wh9BuQh7wzJzlx17UygPf9/Mie2Aa5zWg1TgEJ+oPMkV4fpwcuK
 9Nn2yKnvLzfwNczN4GwlqDOG9ouzxDuzpw/umYF2dWXhHbyHi1wbXxcrwdCqVLTPjs8+YR6UI8
 7Bh1543D2DdhPyZBO+kQJ19lbPJckodfmf7GIwe9jYiyUBf/BSO1oBAUoZH9+WNn58zF9QdLs/
 XssIcYU3Am1z0qbiRkj4193Ie1+phm8FzVxQWCit4lriduvX6UNHi+4dOrd/zLc5pcrgC7zu9n
 M3Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 06:05:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsNc91Qrcz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon,  2 May 2022 06:05:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651496712; x=1654088713; bh=gUVcDOtw+nlQMg2VBwPUo6UvRu/LOTc24AZ
        m4gp4+tQ=; b=feFeQ7VNFSqDST1VrPz+X7+b+gRsloLr3bN32xDRUmI6mOH3FPj
        WcU2s85aFU1Avc4wygIe/qUBQ5AuD3tGksU3c0n/ucVeKZSPP/nM9n0kd9dKI69m
        IgbJZyJ4ydSyRnNAJRYIt2MgKAtooH2PZacf2EuTONeEgTKm3+Cdd68Z3uUeK7au
        QX4RpgCgCLY0DORMQxhXBCKyRPMPAB912a7ShB7k39egO9Ko2h9vFwkIJxUOSiBl
        mYUqTHImF9Qo9jBaS4R2fb8P5dcdUS6+XRJN0KDoO9buNr0o0mxY4/wI+a9OV+yR
        +1+WJ5i78rUkplX2HEynUAIrBWZawZWJRYg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Noj5GQ_oJbR9 for <linux-ide@vger.kernel.org>;
        Mon,  2 May 2022 06:05:12 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsNc7703xz1Rvlc;
        Mon,  2 May 2022 06:05:11 -0700 (PDT)
Message-ID: <e0213b8b-daea-7e75-793c-50f39956f932@opensource.wdc.com>
Date:   Mon, 2 May 2022 22:05:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <349b0922-7efd-99e9-7bc8-b18ed98d94f8@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/04/27 19:18, Runa Guo-oc wrote:
>=20
> On 2022/4/23 6:37, Damien Le Moal wrote:
>> On 4/22/22 18:57, RunaGuo-oc wrote:
>>> On 2022/4/21 18:39, Damien Le Moal wrote:
>>>> On 4/21/22 18:43, Runa Guo-oc wrote:
>>>>> On some platform, when OS enables LPM by default (eg, min_power),
>>>>> then, PhyRdy Change cannot be detected if ahci supports no LPM.
>>>> Do you mean "...if the ahci adapter does not support LPM." ?
>>> Yes.
>>>
>>>> If that is what you mean, then min_power should not be set.
>>> Yes, I agree with you. But, as we know, link_power_management
>>> is a user policy which can be modified, if some users are not
>>> familiar with ahci spec, then the above case may happen.
>> Users should *never* need to be aware of the HW specs and what can or
>> cannot be done with a particular adapter/drive. User actions trying to
>> enable an unsupported feature should be failed, always.
>>
>> In your case though, quickly checking the AHCI specs, the scontrol
>> register bits you change seem to be for preventing *device* initiated
>> power mode transitions, not user/host initiated operations. Your commi=
t
>> message should clearly mention that. But I still need to spend more ti=
me
>> re-reading the specs to confirm. Will do that next week.
>>
>> Since you added the CAP flags, these flags should be used to detect lo=
w
>> power policies that can be allowed for user actions.
>>
>> Mario,
>>
>> Please rebase and repost your patches ! I rebased the for-5.19 branch =
on
>> rc3 to have the LPM config name revert. We need to fix this LPM mess :=
)
>>
>>>>    Mario has patches to fix that.
>>>   =20
>>> Hmm. How to patch this case ?
>> Mario's patches modify the beginning of the sata_link_scr_lpm() functi=
on
>> to prevent setting an LPM policy that the adapter/drive does not suppo=
rt.
>> This together with the correct bits set/reset in the scr register will
>> only allow LPM transitions that are supported.
>>
>> It may also be good to revisit ata_scsi_lpm_store() to prevent the use=
r
>> from setting an unsupported policy. Currently, that uselessly triggers=
 an
>> EH sequence.
>=20
> To avoid some confusion in this patch set, I want to explain it here.
> The patch set involves two LPM related issues, one for the ahci adapter
> does not support LPM (no partial & slumber & devslp), the other for
> ahci adapter supports part of LPM(eg, only partial, no slumber & devslp=
).
>=20
> The former case is what I metioned in this mail thread. Namely, when LP=
M is
> enabled, actions trying to enable this unsupported feature will be fail=
ed,
> but will disable PORT_IRQ_PHYRDY bit at the beginning of the ahci_set_l=
pm()
> function, which would make PhyRdy Changed cannot be detected. So I add =
flags
> in the ata_eh_set_lpm() function which will not go to the disable opera=
tion.
>=20
> The latter case is what I metioned in "PATCH[2/2]". Namely, if the ahci
> adapter only supports partial (no slumber & devslp), then when LPM is e=
nabled
> (eg, min_power), *device* initiated power mode transitions will be enab=
led
> with the scontrol register bits setting to indicate no restrictions on =
LPM
> transitions. After that, if SSD/HDD sends a DIPM slumber request, it ca=
nnot
> be disallowed by ahci adpter for driver not setting scontrol register b=
its
> properly. So I add flags to control it.
>=20
> Therefore, Mario's patches in the sata_link_scr_lpm() function may fix =
the
> issue in "PATCH[2/2]".
>=20
> Revisit ata_scsi_lpm_store() to prevent the user from setting an unsupp=
orted
> policy may be a way to fix the issue in "PATCH[1/2]", but there may be =
another
> case where some operating system manufacturers setting LPM default enab=
le in
> driver, like the following code in the ahci_init_one() function, also n=
eed to
> control.
>=20
> 	if (ap->flags & ATA_FLAG_EM)
> 		ap->em_message_type =3D hpriv->em_msg_type;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ap->target_lpm_policy =3D A=
TA_LPM_MIN_POWER;

This one looks wrong. This is set inside ahci_update_initial_lpm_policy()
according to the default kernel config (CONFIG_SATA_MOBILE_LPM_POLICY) an=
d
module param + what the drive can do according to ACPI. The problem thoug=
h is
that the adapter capabilities are not checked in that function, so the in=
itial
target lpm policy may be wrong.

Since your patch 1/2 adds the hpriv flags indicating the capabilities, yo=
u need
to use these in ahci_update_initial_lpm_policy() to validate whatever ini=
tial
policy is asked for by the user.

> 	=C2=A0ahci_update_initial_lpm_policy(ap, hpriv);
>=20
> According to my current understanding, the currently submitted patches =
can
> solve the above problems, and definitely not the best. I haven't figure=
d out
> good way to use CAP flags to patch. Hope you can give me some advice, t=
hanks.



--=20
Damien Le Moal
Western Digital Research
