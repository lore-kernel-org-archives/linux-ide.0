Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C756C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 00:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiCXAjq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCXAjo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 20:39:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB4286DF
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648082292; x=1679618292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7U9BZYkhDtEBfarSL8RvfE+EJtNfHY/M8GiHA5+wboQ=;
  b=EDyC2TmGhjOOwVNdpXl13HJSwXSuOQe6xWGDLdi6ZVLc3J2OYVEe0F78
   13+OQdzX0qqciN248VYT9m8vIms+yzKC+bIs2QzomBdA/nGF9Yh4Ifgon
   PE3jBDSKy7tN+N+9EfJ95+Mvp/Qavo8VxCrdc32pPC/fqE62YwJqCuVHi
   +rHfRPboY8LiYCghcYUFCb6xrSPe4yCS1SCMv+LrXwSu4EU24EdOa6guh
   2irLClWMmdbVlgwXTyIcZ2jDPIbkZGUbf5yfBBrvm1dKmEHggO3hgqBZV
   N1BN0McXNoNsXPkYLQF/VxsKtKoae4P6ZDb1tHhGgfC1e17QAelJ0IGoW
   g==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="308065984"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 08:38:12 +0800
IronPort-SDR: gHwrmGDV+mDbcx15q+QQcVXxpSqmuwS/xdOG81GJEldsz6ONPysHChZknVRwlkT+3TE1VKUimW
 wgPcIkt5a9kY4FHz1/d/N/cMy6RaBEPHCESAPSrXoc5sPJajD/xVHaUlSObjeIJ6Z/k/LtLLV0
 1pYnjN2dWp1qCsyxdLgkmB6aKVeTg9QmAlVFd9Y5RhfqZ44YQYpPRpKMAX4BH0tSu8rKvsHpLU
 RwGGlatkqOrVXkt4jvKwdo3wZNli8ZXT6B5YCAkq3haO510H9lCoR6AW141yQperrViRRXQP9K
 VvgeBPczG7Uo60/2huuk+/b6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:09:10 -0700
IronPort-SDR: GMlt1vxwEFCBfvhgUKMMZ2DeWbKvewXI4XC3G8BDKYaA/K8nPUPmFPfCxT7PAubUSyHpWMvoh4
 fHC0IYAmiRCU+XfzWfGjpMASZK5GhI51KlhO5ALIRl85yfFQNAmDTfVM/qq78yR7WHVO5cDBV9
 K3Xmm5DabnvFWzZrIZnWyW4k92skXKcFMcutb0K3l6pdZjLIjKBGjw4qAbDhuBP/jz2Fj59W56
 ggp5ot3Z8ln0efxuCssS9hL2CiVJbEVqtdFV0M4tCBGuYqP4LKx6Nd2G3qD7f0d0STHSsXOkwD
 VQc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:38:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP5tC71f3z1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 17:38:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648082291; x=1650674292; bh=7U9BZYkhDtEBfarSL8RvfE+EJtNfHY/M8Gi
        HA5+wboQ=; b=KmcWZ63kijoyx/FP4C29Rou5U1ew3+OLuMnKogG6YFtAamZQDon
        FPYcYmS92PF+e0trJKushdGPdrhUxp5PT9ziaea7DNpynXmNwLjEB7by0dlzlZWf
        Idd7bac+FIOejG4vmfwUFaXu1KQqJU8JlZXY1YMuPvyXFp/KGPEDiY7sc8009jj+
        nvX8f+laXdZJkxpEwB82m79HiCsX/Z2rDxMRxH+664/Ru38CYBquRO0YKc1dTvG7
        y0g3b2Xxo54yCycaON0BM/kRjKtx8kzl0Kt2T4+2JPNjDijj3es8O59OgetHdDWx
        yAGr1FKBNAl8BQTypcx3BQEwcJcOjO01vwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y3kt8JjCEzpx for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 17:38:11 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP5tB3hfgz1Rvlx;
        Wed, 23 Mar 2022 17:38:10 -0700 (PDT)
Message-ID: <b8eeaec5-5921-ae8c-ee13-cb93297804f8@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 09:38:09 +0900
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
 <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
 <BL1PR12MB5157C72DE3005CF0C6C6D9BEE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB5157C72DE3005CF0C6C6D9BEE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:25, Limonciello, Mario wrote:
> [Public]
> 
>> On 3/24/22 08:04, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>> On Mon, Mar 21, 2022 at 11:57 PM Damien Le Moal
>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>>
>>>>> * Rename ahci_board_mobile to board_ahci_low_power to be more
>>>> descriptive
>>>>>   of the feature as that is also used on PC and server AHCI adapters,
>>>>>   from Mario.
>>>>>
>>>>> Mario Limonciello (3):
>>>>>       ata: ahci: Rename board_ahci_mobile
>>>>>       ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
>>>>>       ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration
>> item
>>>>
>>>> So I've pulled this, but it's worth noting that particularly renaming
>>>> that CONFIG option was probably not a good idea.
>>>>
>>>> Why?
>>>>
>>>> Because it means that people silently lose their old values. And it has that
>>>>
>>>>         range 0 4
>>>>         default 0
>>>>
>>>> with 4 being explicitly marked as very dangerous - but at least Fedora
>>>> seems to actually have a default of 3 in their kernels:
>>>>
>>>>   /boot/config-5.16.13-200.fc35.x86_64:
>>>>         CONFIG_SATA_MOBILE_LPM_POLICY=3
>>>>
>>>> so that "default 0" may actually not be the right one.
>>>>
>>>> Now, we're at the point where few enough people likely care about ATA,
>>>> but the corollary to that is also that these kinds of changes can
>>>> cause user pain that then developers have *no* idea about.
>>>> Particularly when the pain ends up being caused by some subtle default
>>>> config option silently changing that nobody even thought about.
>>>>
>>>> Now, that "default 0" is probably the only safe default - and I don't
>>>> dispute that part. But I also suspect that Fedora chose that value '3'
>>>> because it probably makes a noticeable power use difference on at
>>>> least some platforms.
>>>>
>>>> I don't know. But I doubt really *anybody* knows, so renaming them and
>>>> silently likely changing config options for some less-than-critical
>>>> reason is just not a great idea.
>>>>
>>>>                 Linus
>>>
>>> Thanks for pointing out the subtlety of renaming a configuration option hides
>>> problems because people don't see the new config option and pick the default.
>>> I wouldn't call this configuration option rename critical, so if you chose to
>> revert
>>> it I would understand.
>>>
>>> However I think you raise a good point that if distros are picking different
>> "default"
>>> values and keeping them there a long time that the value in the upstream
>> kernel
>>> is probably not right anymore.  A while back that default made sense because
>> all the
>>> power saving stuff was risky at the time.  It's pretty well baked now.
>>>
>>> So maybe a logical thing is to keep this change and send a follow up that also
>> changes
>>> the default to 3?  If you're supportive of that I'll send something to Damien to
>> do that.
>>
>> Mario, let's check what other distros do first before deciding. Fedora for
>> sure has a default of 3 and I have never seen any issue with it (and I
>> have been using Fedora for a long time with many different drives).
>>
>> Not sure what distro you are using, but if it is not Fedora, please check.
>> We should check at least Debian, Ubuntu, SUSE, RHEL and CentOS. I can
>> check some other minor ones too as I know users.
>>
> 
> I use Ubuntu mostly, and have a variety of distro kernels installed:
> 
> config-5.13.0-25-generic:CONFIG_SATA_MOBILE_LPM_POLICY=3
> config-5.14.0-1029-oem:CONFIG_SATA_MOBILE_LPM_POLICY=3
> config-5.4.0-60-generic:CONFIG_SATA_MOBILE_LPM_POLICY=3

OK. Thanks.

> 
> From a box with a random RHEL8 kernel I see:
> 
> config-4.18.0-372.2.1.el8.x86_64:CONFIG_SATA_MOBILE_LPM_POLICY=0
> 
> However I believe that is because RH uses tuned to set policies like this. 
> They have use cases from embedded up through datacenter.
> For example you can see their "desktop" profile overrides it to
> to medium_power:
> 
> https://github.com/redhat-performance/tuned/commit/adffbb0ca1537277d5344661e05a705af2520c89

OK. I will check CentOS too, but it should be the same as RHEL.

> 
> Downloaded a random Debian 5.10 kernel package and extracted it:
> $ grep LPM config-5.10.0-10-amd64
> CONFIG_SATA_MOBILE_LPM_POLICY=3

Yep, just checked that too. Both Debian stable and testing have 3 as the
default.

> 
> Checked arch from their source tree and they also set 3:
> https://github.com/archlinux/svntogit-packages/blob/packages/linux/trunk/config#L2798
> 
> Not sure where to check SUSE.

Checking this one now.



-- 
Damien Le Moal
Western Digital Research
