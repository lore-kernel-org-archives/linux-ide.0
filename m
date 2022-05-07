Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E0C433EF
	for <linux-ide@archiver.kernel.org>; Sat,  7 May 2022 07:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358512AbiEGHkr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 7 May 2022 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbiEGHkq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 7 May 2022 03:40:46 -0400
Received: from ZXSHCAS1.zhaoxin.com (zxshcas1.zhaoxin.com [180.169.121.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67351E75
        for <linux-ide@vger.kernel.org>; Sat,  7 May 2022 00:36:58 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Sat, 7 May
 2022 15:36:55 +0800
Received: from [10.29.8.9] (10.29.8.9) by zxbjmbx1.zhaoxin.com (10.29.252.163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Sat, 7 May
 2022 15:36:55 +0800
Subject: Re: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
 capability
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>,
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
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
Message-ID: <4824f9b5-92c1-a53b-2174-1d096e723e13@zhaoxin.com>
Date:   Sat, 7 May 2022 15:36:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0213b8b-daea-7e75-793c-50f39956f932@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/5/2 21:05, Damien Le Moal wrote:
> On 2022/04/27 19:18, Runa Guo-oc wrote:
>> On 2022/4/23 6:37, Damien Le Moal wrote:
>>> On 4/22/22 18:57, RunaGuo-oc wrote:
>>>> On 2022/4/21 18:39, Damien Le Moal wrote:
>>>>> On 4/21/22 18:43, Runa Guo-oc wrote:
>>>>>> On some platform, when OS enables LPM by default (eg, min_power),
>>>>>> then, PhyRdy Change cannot be detected if ahci supports no LPM.
>>>>> Do you mean "...if the ahci adapter does not support LPM." ?
>>>> Yes.
>>>>
>>>>> If that is what you mean, then min_power should not be set.
>>>> Yes, I agree with you. But, as we know, link_power_management
>>>> is a user policy which can be modified, if some users are not
>>>> familiar with ahci spec, then the above case may happen.
>>> Users should *never* need to be aware of the HW specs and what can or
>>> cannot be done with a particular adapter/drive. User actions trying to
>>> enable an unsupported feature should be failed, always.
>>>
>>> In your case though, quickly checking the AHCI specs, the scontrol
>>> register bits you change seem to be for preventing *device* initiated
>>> power mode transitions, not user/host initiated operations. Your commit
>>> message should clearly mention that. But I still need to spend more time
>>> re-reading the specs to confirm. Will do that next week.
>>>
>>> Since you added the CAP flags, these flags should be used to detect low
>>> power policies that can be allowed for user actions.
>>>
>>> Mario,
>>>
>>> Please rebase and repost your patches ! I rebased the for-5.19 branch on
>>> rc3 to have the LPM config name revert. We need to fix this LPM mess :)
>>>
>>>>>     Mario has patches to fix that.
>>>>     
>>>> Hmm. How to patch this case ?
>>> Mario's patches modify the beginning of the sata_link_scr_lpm() function
>>> to prevent setting an LPM policy that the adapter/drive does not support.
>>> This together with the correct bits set/reset in the scr register will
>>> only allow LPM transitions that are supported.
>>>
>>> It may also be good to revisit ata_scsi_lpm_store() to prevent the user
>>> from setting an unsupported policy. Currently, that uselessly triggers an
>>> EH sequence.
>> To avoid some confusion in this patch set, I want to explain it here.
>> The patch set involves two LPM related issues, one for the ahci adapter
>> does not support LPM (no partial & slumber & devslp), the other for
>> ahci adapter supports part of LPM(eg, only partial, no slumber & devslp).
>>
>> The former case is what I metioned in this mail thread. Namely, when LPM is
>> enabled, actions trying to enable this unsupported feature will be failed,
>> but will disable PORT_IRQ_PHYRDY bit at the beginning of the ahci_set_lpm()
>> function, which would make PhyRdy Changed cannot be detected. So I add flags
>> in the ata_eh_set_lpm() function which will not go to the disable operation.
>>
>> The latter case is what I metioned in "PATCH[2/2]". Namely, if the ahci
>> adapter only supports partial (no slumber & devslp), then when LPM is enabled
>> (eg, min_power), *device* initiated power mode transitions will be enabled
>> with the scontrol register bits setting to indicate no restrictions on LPM
>> transitions. After that, if SSD/HDD sends a DIPM slumber request, it cannot
>> be disallowed by ahci adpter for driver not setting scontrol register bits
>> properly. So I add flags to control it.
>>
>> Therefore, Mario's patches in the sata_link_scr_lpm() function may fix the
>> issue in "PATCH[2/2]".
>>
>> Revisit ata_scsi_lpm_store() to prevent the user from setting an unsupported
>> policy may be a way to fix the issue in "PATCH[1/2]", but there may be another
>> case where some operating system manufacturers setting LPM default enable in
>> driver, like the following code in the ahci_init_one() function, also need to
>> control.
>>
>> 	if (ap->flags & ATA_FLAG_EM)
>> 		ap->em_message_type = hpriv->em_msg_type;
>>
>> +        ap->target_lpm_policy = ATA_LPM_MIN_POWER;
> This one looks wrong. This is set inside ahci_update_initial_lpm_policy()
> according to the default kernel config (CONFIG_SATA_MOBILE_LPM_POLICY) and
> module param + what the drive can do according to ACPI. The problem though is
> that the adapter capabilities are not checked in that function, so the initial
> target lpm policy may be wrong.
>
> Since your patch 1/2 adds the hpriv flags indicating the capabilities, you need
> to use these in ahci_update_initial_lpm_policy() to validate whatever initial
> policy is asked for by the user.

Yes, the above code is not rigorous, existing methods provided by kernel as you
said should be used in this case.

In order to use CAP flags to validate user policy, I review the latest kernel
LPM policies, here is my understanding:
ATA_LPM_UNKNOWN: default policy, no LPM
ATA_LPM_MAX_POWER: disable LPM (hipm & dipm)
ATA_LPM_MED_POWER: enable hipm partial
ATA_LPM_MED_POWER_WITH_DIPM: enable hipm partial &dipm partial &slumber
ATA_LPM_MIN_POWER_WITH_PARTIAL: enable hipm partial &dipm partial&slumber&devslp
ATA_LPM_MIN_POWER: enable hipm slumber &dipm partial &slumber &devslp
hipm: adpter initiated power mode transitions;
dipm:*device* initiated power mode transitions;

 From my comprehension, user policy in [ATA_LPM_MED_POWER, ATA_LPM_MIN_POWER]
need to be validated on adapter's capabilities (partial(y/n), slumber(y/n),
devslp(y/n)), so, there exits the following cases:
1, (n, n, n), validate  it to ATA_LPM_UNKNOWN;
2, (n, n, y), validate  it to  ATA_LPM_MIN_POWER_WITH_PARTIAL/ATA_LPM_MIN_POWER?
3, (n, y, n), validate  it to ATA_LPM_MIN_POWER;
4, (n, y, y), validate  it to ATA_LPM_MIN_POWER;
5, (y, n, n), validate  it to ATA_LPM_MED_POWER;
6, (y, n, y), validate  it to ATA_LPM_MIN_POWER_WITH_PARTIAL;
7, (y, y, n), default user policy;
8, (y, y, y), default user policy;
('y' for support, 'n' for not support)

for case 2, I'm not quiet sure, for which may enable hipm partial/slumber.

The way I provided above is quiet complicated and may be incomplete.
It may not be realistic to take all into account, but I think case 1 should
be taken seriously for which may cause the above PORT_IRQ_PHYRDY issue.

Perhaps, I could refer to Mario's patches later (I have not found yet on
kernel/git ^_^).

>> 	 ahci_update_initial_lpm_policy(ap, hpriv);
>>
>> According to my current understanding, the currently submitted patches can
>> solve the above problems, and definitely not the best. I haven't figured out
>> good way to use CAP flags to patch. Hope you can give me some advice, thanks.
>
>
