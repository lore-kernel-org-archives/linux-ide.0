Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16AC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbiCWXra (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiCWXra (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:47:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AAB5F7D
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648079159; x=1679615159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NG1fZYFmCT04HroBk72g5GSYBj0sa9vmrUphtKYc5eI=;
  b=nw8h9Kc0qyU8EyIP1c/dp6CWYK9QCNjETcnKb7uKlnlLJ9t7pQpBjDGN
   52FC1QBe0EHw36DtMWF8ubvIXjIK9GYRw3LeZVV684qdZwpLta3nQdPfV
   xMI/Q+uQxiEhIYvzChXFu9An3tsCchu5KuCdpLFQ8RICECyq8zhVBiAA2
   8dfmNVvXQpW+egojAbU3LzQ1HVAg6EgRhbluBK4qIXKOpgExrSVtCenF9
   n/gR3iM95u5M43uq7pA7ff3LimTxC1qCCjWNsZZPoqNLoSgxrUr19PVKn
   R6p8OwzsGrSpTLkZTvDgq+a7StS1k1jz8cGlpuvsJsg+1Q2AJCAHwASqm
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="308062473"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 07:45:59 +0800
IronPort-SDR: 8IfAVR4vhbngvVylFjVKaF8qfTUTyacDkTwumPFWTVuqwBpOLNgDalP1zp/qMREQkp4q0SoynU
 Gd6d1KC+IqLzYc/nwktaiODA+UlnEedbbknKR1CYhdTkUtAByldF3/JXaj/MavOvq2Kn1Kxrgn
 G0J9+btjYUsiFoF1sE41nb+Fl2jJG8K3gvYAbJrbNPJ0l7xZ0Ad56JgpKjebJrKX86OLj5S4PB
 jisjac+jQy+rWLhvwb7N6cspdJOwcNa5mbUoqczU/pCgwLWP/1hIyg6VeqgpVEaeEY33Gd66pE
 dwSCc71DTggHnKlDV6tXEXfj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:17:52 -0700
IronPort-SDR: j+aVeCC3JU9kXfYgIlkUjSJxms6CHSSe1uO50gAmegEcEI/rA3TORJuffs34bcWLhHV+dGqncL
 86LNMIv4Dce6O5TF1iX0TvDLU5GQT85RUez5U2agf36mNxJZymqIpAw9+osGiraJb8KaJTc0md
 6yLXdgxXZvo8QwyEOpW5UbavJoUED1SkF3y2y8Mqptz1gEEJPG8/VhX+g818YhbxrQ6cZOYD90
 cO6LFknCgIXXcT9TYfbC7P5IBPxiaEAT0Qsj1FdcmHa6hMCFrYgNMrb4HrCrn42G7Z5ZOakfjc
 pXQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:46:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP4jy6hVcz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:45:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648079158; x=1650671159; bh=NG1fZYFmCT04HroBk72g5GSYBj0sa9vmrUp
        htKYc5eI=; b=M/y+vMlT74liohXxW44NESCjBbRiihQg7ePvEcLzSfWVoXm5VLd
        EmkX3MhX7pdF5EJkAwMsAhAgZwW8xwoHUp8w51Zsx+EXu5lPtlBG6UUsGcH3nv32
        ot0W0N8jclaFBSzFy4WESECLNVddGGgCsp0RbHPmcOKWVtB/HA9urwPy5WkNqYxP
        qywkrxFlFe6bv3jbFwDyCosqK4+k8eFXN7xRLjoBdMgiYAfPxMBSzhZMUxU8GX5I
        SEMTTtyQk1gy1DOwkeKv6UoH3y91JtRRJesZhfR1F5SI2ZlEGAuejFSgi+2opjW+
        ze+8CuTEORZwzPSE5izlvqR0tYivx5kzfpw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CQ8D2S4Orry2 for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 16:45:58 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP4jy0Zx4z1Rvlx;
        Wed, 23 Mar 2022 16:45:57 -0700 (PDT)
Message-ID: <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 08:45:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
 <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 08:04, Limonciello, Mario wrote:
> [Public]
> 
>> On Mon, Mar 21, 2022 at 11:57 PM Damien Le Moal
>> <damien.lemoal@opensource.wdc.com> wrote:
>>>
>>> * Rename ahci_board_mobile to board_ahci_low_power to be more
>> descriptive
>>>   of the feature as that is also used on PC and server AHCI adapters,
>>>   from Mario.
>>>
>>> Mario Limonciello (3):
>>>       ata: ahci: Rename board_ahci_mobile
>>>       ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
>>>       ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item
>>
>> So I've pulled this, but it's worth noting that particularly renaming
>> that CONFIG option was probably not a good idea.
>>
>> Why?
>>
>> Because it means that people silently lose their old values. And it has that
>>
>>         range 0 4
>>         default 0
>>
>> with 4 being explicitly marked as very dangerous - but at least Fedora
>> seems to actually have a default of 3 in their kernels:
>>
>>   /boot/config-5.16.13-200.fc35.x86_64:
>>         CONFIG_SATA_MOBILE_LPM_POLICY=3
>>
>> so that "default 0" may actually not be the right one.
>>
>> Now, we're at the point where few enough people likely care about ATA,
>> but the corollary to that is also that these kinds of changes can
>> cause user pain that then developers have *no* idea about.
>> Particularly when the pain ends up being caused by some subtle default
>> config option silently changing that nobody even thought about.
>>
>> Now, that "default 0" is probably the only safe default - and I don't
>> dispute that part. But I also suspect that Fedora chose that value '3'
>> because it probably makes a noticeable power use difference on at
>> least some platforms.
>>
>> I don't know. But I doubt really *anybody* knows, so renaming them and
>> silently likely changing config options for some less-than-critical
>> reason is just not a great idea.
>>
>>                 Linus
> 
> Thanks for pointing out the subtlety of renaming a configuration option hides
> problems because people don't see the new config option and pick the default.
> I wouldn't call this configuration option rename critical, so if you chose to revert
> it I would understand.
> 
> However I think you raise a good point that if distros are picking different "default"
> values and keeping them there a long time that the value in the upstream kernel
> is probably not right anymore.  A while back that default made sense because all the
> power saving stuff was risky at the time.  It's pretty well baked now.
> 
> So maybe a logical thing is to keep this change and send a follow up that also changes
> the default to 3?  If you're supportive of that I'll send something to Damien to do that.

Mario, let's check what other distros do first before deciding. Fedora for
sure has a default of 3 and I have never seen any issue with it (and I
have been using Fedora for a long time with many different drives).

Not sure what distro you are using, but if it is not Fedora, please check.
We should check at least Debian, Ubuntu, SUSE, RHEL and CentOS. I can
check some other minor ones too as I know users.

-- 
Damien Le Moal
Western Digital Research
