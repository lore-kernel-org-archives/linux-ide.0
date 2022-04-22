Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9544AC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 22 Apr 2022 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiDVXGk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiDVXGe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2022 19:06:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A99624ED84
        for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2022 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650667063; x=1682203063;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gHZugkh+E4SH6Owy3+fBDxkusuuLvKnJl1d1vYgdwjE=;
  b=KTmiIzgXM2npx53olcXXxWvf3YSVu0IZO9HELyP4vH08vaBR7sDoDa4G
   wrHBkMBK9AGhyCkLZYc9uRpME+Fr4N/wKqd0lO5ioqVk1pO2C/wItqIue
   7eLyFgd2GnKIDuXfijr6V5CvDasrcJdiAxsse+J6gw/p+L2RGXMCRBICa
   Y4sL5niectvCF2GE/Z5zLSYaKZgE++7T6Ut7WoWCrDnjJvRe/8QRoK+Y0
   hkWxonpSsE4Gl+GxSfQCpuTnSOehhgql+yMuq8XpXMoR/1wZCe5GKq4aZ
   1VO9jORr+gxrK/AAJRB72VzRTxLDybsdpkKTcyUtBXH3NEmuk4snoqGsx
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,282,1643644800"; 
   d="scan'208";a="198606015"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2022 06:37:41 +0800
IronPort-SDR: Hl6ZuofbdUCHUmzrUIwbQv76L3y8VzlIdwo3ww3/RAn5byMFwxFZysQNJi16KPuM3JO3wcGhFp
 Dh3C3ReqLoiJsCWBrf0uyzI47X7OdGu+m3SQcZ+cBR7m/If2M9rmFmO+r6aemLK1SMW+IWglzo
 RlheXmeL9irfCEH//wxqI0nAIJl4F33ly1Hd7vK0o4R30zj8YrLzB3/9NtmI7fvQCXP909s9Le
 db6KDt3qifvy3X3M4bStRk5VIqVe9CvXJ7niL9+dG0I4RJtOqKJ7DQxjfqcn9CU/ps1wvWYCi8
 mc2M7uSln9iXFxPFoPLN+x1g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2022 15:07:57 -0700
IronPort-SDR: pC5BpPycd4xLGX1hQ7tAxTsR0QVaWMYvM3rh7E4HzC7qZaUfwoJ2wTejHG4KnrRQTfByXDwn8g
 RAL3/U/KCGoeG8da91R7d9VoMuXvTOGeLhlg8SUKg7+k6dFUMALeIyLzHlcjMALOabz/5X6n6f
 wYScgblPU17NBO+IBqfexiiP5UbVmr+ISOsqiQ8eUApkiZH6xxKCJ+kit2qdfUqKBoeLexYkuN
 CAsgoaG9mLjLI6sEnlUOQrK8hCqml2xDAoUu+kvWsrwXcuiVHAcMCnpf2+mTLr9E9XMFex350m
 rUI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2022 15:37:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KlTnK4Vw3z1SVnx
        for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2022 15:37:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650667060; x=1653259061; bh=gHZugkh+E4SH6Owy3+fBDxkusuuLvKnJl1d
        1vYgdwjE=; b=AJCVmCAAThZcKijG1dNnqZH9wb/CzEQqbK9x9vyFoAIcXcttCsl
        BBJfuVnDehNxUgWqJOmSDSiLbPd5mL20NN52DB+H1f7dGFY7cKu7QCYtFeSJr0hL
        /AszCW5XkMso6aB18O6T6zZnNMsPCeL+T0sPWgZPLrpGvifsIHp5xurY4Cu9QMQH
        gymxuvuV1q4wHdap+aQ6tRhPbSMPEx/2iGgZZflnxyeCj+bM0eW1Hz/lwd0cCgmG
        QK83+FIYBCFfB7qdGGslEiH6RzT18uWljGnu7+tCm3txzNQDLGmjg7DCDDGnsKOr
        Nzw4jSOaJi5MEUHLBvypSrfIu0/8PgROQ4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OKcvyR58ooGr for <linux-ide@vger.kernel.org>;
        Fri, 22 Apr 2022 15:37:40 -0700 (PDT)
Received: from [10.225.163.23] (unknown [10.225.163.23])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KlTnH4yZZz1Rvlx;
        Fri, 22 Apr 2022 15:37:39 -0700 (PDT)
Message-ID: <ffc33fd4-a676-167d-ec2c-18e8211f2858@opensource.wdc.com>
Date:   Sat, 23 Apr 2022 07:37:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] ahci: Add PhyRdy Change control on actual LPM
 capability
Content-Language: en-US
To:     RunaGuo-oc <RunaGuo-oc@zhaoxin.com>, linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Cobe Chen <CobeChen@zhaoxin.com>, Tim Guo <TimGuo@zhaoxin.com>,
        TonyW Wang <TonyWWang@zhaoxin.com>,
        Leo Liu <LeoLiu@zhaoxin.com>
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-2-git-send-email-RunaGuo-oc@zhaoxin.com>
 <244f0c98-13f4-1ac4-9ebe-facdad4ae8b6@opensource.wdc.com>
 <af0571fe-a8f4-cb0a-323f-4dc0c4e7517d@zhaoxin.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <af0571fe-a8f4-cb0a-323f-4dc0c4e7517d@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/22/22 18:57, RunaGuo-oc wrote:
> On 2022/4/21 18:39, Damien Le Moal wrote:
>> On 4/21/22 18:43, Runa Guo-oc wrote:
>>> On some platform, when OS enables LPM by default (eg, min_power),
>>> then, PhyRdy Change cannot be detected if ahci supports no LPM.
>> Do you mean "...if the ahci adapter does not support LPM." ?
> 
> Yes.
> 
>> If that is what you mean, then min_power should not be set.
> 
> Yes, I agree with you. But, as we know, link_power_management
> is a user policy which can be modified, if some users are not
> familiar with ahci spec, then the above case may happen.

Users should *never* need to be aware of the HW specs and what can or
cannot be done with a particular adapter/drive. User actions trying to
enable an unsupported feature should be failed, always.

In your case though, quickly checking the AHCI specs, the scontrol
register bits you change seem to be for preventing *device* initiated
power mode transitions, not user/host initiated operations. Your commit
message should clearly mention that. But I still need to spend more time
re-reading the specs to confirm. Will do that next week.

Since you added the CAP flags, these flags should be used to detect low
power policies that can be allowed for user actions.

Mario,

Please rebase and repost your patches ! I rebased the for-5.19 branch on
rc3 to have the LPM config name revert. We need to fix this LPM mess :)

> 
>>   Mario has patches to fix that.
> 
>   
> Hmm. How to patch this case ?

Mario's patches modify the beginning of the sata_link_scr_lpm() function
to prevent setting an LPM policy that the adapter/drive does not support.
This together with the correct bits set/reset in the scr register will
only allow LPM transitions that are supported.

It may also be good to revisit ata_scsi_lpm_store() to prevent the user
from setting an unsupported policy. Currently, that uselessly triggers an
EH sequence.

> 
>>> In ahci spec, PhyRdy Change cannot coexist with LPM.
>>>
>>> Adds support to control this case on actual LPM capability.
>>>
>>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>>> ---
>>>   drivers/ata/ahci.c      | 9 +++++++++
>>>   drivers/ata/libata-eh.c | 4 ++++
>>>   include/linux/libata.h  | 4 ++++
>>>   3 files changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index 397dfd2..03f0cb3 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -1870,6 +1870,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>   	else
>>>   		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
>>>   
>>> +	if (hpriv->cap & HOST_CAP_PART)
>>> +		host->flags |= ATA_HOST_PART;
>>> +
>>> +	if (hpriv->cap & HOST_CAP_SSC)
>>> +		host->flags |= ATA_HOST_SSC;
>>> +
>>> +	if (hpriv->cap2 & HOST_CAP2_SDS)
>>> +		host->flags |= ATA_HOST_DEVSLP;
>>> +
>>>   	if (pi.flags & ATA_FLAG_EM)
>>>   		ahci_reset_em(host);
>>>   
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 3307ed4..05b1043 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -3246,6 +3246,10 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>>>   	unsigned int err_mask;
>>>   	int rc;
>>>   
>>> +	/* if controller does not support lpm, then sets no LPM flags*/
>>> +	if (!(ap->host->flags & (ATA_HOST_PART | ATA_HOST_SSC | ATA_HOST_DEVSLP)))
>>> +		link->flags |= ATA_LFLAG_NO_LPM;
>>> +
>>>   	/* if the link or host doesn't do LPM, noop */
>>>   	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
>>>   	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 732de90..7a243f4 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -216,6 +216,10 @@ enum {
>>>   	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
>>>   	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
>>>   
>>> +	ATA_HOST_PART		= (1 << 4), /* Host support partial.*/
>>> +	ATA_HOST_SSC		= (1 << 5), /* Host support slumber.*/
>>> +	ATA_HOST_DEVSLP		= (1 << 6), /* Host support devslp.*/
>>> +
>>>   	/* bits 24:31 of host->flags are reserved for LLD specific flags */
>>>   
>>>   	/* various lengths of time */
>>
> 


-- 
Damien Le Moal
Western Digital Research
