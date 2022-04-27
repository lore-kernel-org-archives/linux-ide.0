Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D1C433FE
	for <linux-ide@archiver.kernel.org>; Wed, 27 Apr 2022 10:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiD0K7b (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 27 Apr 2022 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiD0K7D (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 27 Apr 2022 06:59:03 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 03:36:13 PDT
Received: from ZXSHCAS2.zhaoxin.com (zxshcas2.zhaoxin.com [180.169.121.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD64ABC57
        for <linux-ide@vger.kernel.org>; Wed, 27 Apr 2022 03:36:12 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 27 Apr
 2022 18:18:54 +0800
Received: from [10.29.8.9] (10.29.8.9) by zxbjmbx1.zhaoxin.com (10.29.252.163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 27 Apr
 2022 18:18:53 +0800
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
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
Message-ID: <349b0922-7efd-99e9-7bc8-b18ed98d94f8@zhaoxin.com>
Date:   Wed, 27 Apr 2022 18:18:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ffc33fd4-a676-167d-ec2c-18e8211f2858@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2022/4/23 6:37, Damien Le Moal wrote:
> On 4/22/22 18:57, RunaGuo-oc wrote:
>> On 2022/4/21 18:39, Damien Le Moal wrote:
>>> On 4/21/22 18:43, Runa Guo-oc wrote:
>>>> On some platform, when OS enables LPM by default (eg, min_power),
>>>> then, PhyRdy Change cannot be detected if ahci supports no LPM.
>>> Do you mean "...if the ahci adapter does not support LPM." ?
>> Yes.
>>
>>> If that is what you mean, then min_power should not be set.
>> Yes, I agree with you. But, as we know, link_power_management
>> is a user policy which can be modified, if some users are not
>> familiar with ahci spec, then the above case may happen.
> Users should *never* need to be aware of the HW specs and what can or
> cannot be done with a particular adapter/drive. User actions trying to
> enable an unsupported feature should be failed, always.
>
> In your case though, quickly checking the AHCI specs, the scontrol
> register bits you change seem to be for preventing *device* initiated
> power mode transitions, not user/host initiated operations. Your commit
> message should clearly mention that. But I still need to spend more time
> re-reading the specs to confirm. Will do that next week.
>
> Since you added the CAP flags, these flags should be used to detect low
> power policies that can be allowed for user actions.
>
> Mario,
>
> Please rebase and repost your patches ! I rebased the for-5.19 branch on
> rc3 to have the LPM config name revert. We need to fix this LPM mess :)
>
>>>    Mario has patches to fix that.
>>    
>> Hmm. How to patch this case ?
> Mario's patches modify the beginning of the sata_link_scr_lpm() function
> to prevent setting an LPM policy that the adapter/drive does not support.
> This together with the correct bits set/reset in the scr register will
> only allow LPM transitions that are supported.
>
> It may also be good to revisit ata_scsi_lpm_store() to prevent the user
> from setting an unsupported policy. Currently, that uselessly triggers an
> EH sequence.

To avoid some confusion in this patch set, I want to explain it here.
The patch set involves two LPM related issues, one for the ahci adapter
does not support LPM (no partial & slumber & devslp), the other for
ahci adapter supports part of LPM(eg, only partial, no slumber & devslp).

The former case is what I metioned in this mail thread. Namely, when LPM is
enabled, actions trying to enable this unsupported feature will be failed,
but will disable PORT_IRQ_PHYRDY bit at the beginning of the ahci_set_lpm()
function, which would make PhyRdy Changed cannot be detected. So I add flags
in the ata_eh_set_lpm() function which will not go to the disable operation.

The latter case is what I metioned in "PATCH[2/2]". Namely, if the ahci
adapter only supports partial (no slumber & devslp), then when LPM is enabled
(eg, min_power), *device* initiated power mode transitions will be enabled
with the scontrol register bits setting to indicate no restrictions on LPM
transitions. After that, if SSD/HDD sends a DIPM slumber request, it cannot
be disallowed by ahci adpter for driver not setting scontrol register bits
properly. So I add flags to control it.

Therefore, Mario's patches in the sata_link_scr_lpm() function may fix the
issue in "PATCH[2/2]".

Revisit ata_scsi_lpm_store() to prevent the user from setting an unsupported
policy may be a way to fix the issue in "PATCH[1/2]", but there may be another
case where some operating system manufacturers setting LPM default enable in
driver, like the following code in the ahci_init_one() function, also need to
control.

	if (ap->flags & ATA_FLAG_EM)
		ap->em_message_type = hpriv->em_msg_type;

+        ap->target_lpm_policy = ATA_LPM_MIN_POWER;
	 ahci_update_initial_lpm_policy(ap, hpriv);

According to my current understanding, the currently submitted patches can
solve the above problems, and definitely not the best. I haven't figured out
good way to use CAP flags to patch. Hope you can give me some advice, thanks.

>>>> In ahci spec, PhyRdy Change cannot coexist with LPM.
>>>>
>>>> Adds support to control this case on actual LPM capability.
>>>>
>>>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>>>> ---
>>>>    drivers/ata/ahci.c      | 9 +++++++++
>>>>    drivers/ata/libata-eh.c | 4 ++++
>>>>    include/linux/libata.h  | 4 ++++
>>>>    3 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>> index 397dfd2..03f0cb3 100644
>>>> --- a/drivers/ata/ahci.c
>>>> +++ b/drivers/ata/ahci.c
>>>> @@ -1870,6 +1870,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>    	else
>>>>    		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
>>>>    
>>>> +	if (hpriv->cap & HOST_CAP_PART)
>>>> +		host->flags |= ATA_HOST_PART;
>>>> +
>>>> +	if (hpriv->cap & HOST_CAP_SSC)
>>>> +		host->flags |= ATA_HOST_SSC;
>>>> +
>>>> +	if (hpriv->cap2 & HOST_CAP2_SDS)
>>>> +		host->flags |= ATA_HOST_DEVSLP;
>>>> +
>>>>    	if (pi.flags & ATA_FLAG_EM)
>>>>    		ahci_reset_em(host);
>>>>    
>>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>>> index 3307ed4..05b1043 100644
>>>> --- a/drivers/ata/libata-eh.c
>>>> +++ b/drivers/ata/libata-eh.c
>>>> @@ -3246,6 +3246,10 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>>>>    	unsigned int err_mask;
>>>>    	int rc;
>>>>    
>>>> +	/* if controller does not support lpm, then sets no LPM flags*/
>>>> +	if (!(ap->host->flags & (ATA_HOST_PART | ATA_HOST_SSC | ATA_HOST_DEVSLP)))
>>>> +		link->flags |= ATA_LFLAG_NO_LPM;
>>>> +
>>>>    	/* if the link or host doesn't do LPM, noop */
>>>>    	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
>>>>    	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index 732de90..7a243f4 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h
>>>> @@ -216,6 +216,10 @@ enum {
>>>>    	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
>>>>    	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
>>>>    
>>>> +	ATA_HOST_PART		= (1 << 4), /* Host support partial.*/
>>>> +	ATA_HOST_SSC		= (1 << 5), /* Host support slumber.*/
>>>> +	ATA_HOST_DEVSLP		= (1 << 6), /* Host support devslp.*/
>>>> +
>>>>    	/* bits 24:31 of host->flags are reserved for LLD specific flags */
>>>>    
>>>>    	/* various lengths of time */
>
