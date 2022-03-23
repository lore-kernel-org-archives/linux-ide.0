Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A10C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiCWXlk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbiCWXli (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:41:38 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35E6BD8
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648078807; x=1679614807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TKVNjUS+N+CCXnSJvdn+dbSRtObno9j5OryhMiYI7JQ=;
  b=pFX17NcXDC92Hahax6VA4GdIkwFtYiG1E+M216G765s8DaKrZYUoep3H
   bJ3nbFOG7JHtPkOXQpc8QsCzcGu08hFMlD9XjFqPgNXXDkHmaJpW1YNc2
   2Hnq/8dB+HhwKJG5eLH1kgeE0An9ZoCVCiETWs5dL0nv/IMGZDLUbHRlS
   +mzntvdT+Fq0Q+mjSi65rBt5GKi7YKTl6MqPRBmbyYJTPIOmFSAeFsLqq
   2dC65vdHsYmP7qE1i8nneWbsyfa/YgTB9gIYtHtfqly4mUJ/XpzD6/I4l
   YCb0ZtUBMWIIHa97Hot77XkLNs7Zpey1uINncpq9WpYRY4vuc8jFhxGH9
   w==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="197032482"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 07:40:06 +0800
IronPort-SDR: uTLwzNzlIMMuiPqv5+P67nifG6GnsZkZIvJqaI3gtuWSNDACsEPRWKK476Zm/0xHGWBWRw+bJ0
 O/3rrmkvZ72yJZnTwUI/jZieImNxPaSDoDZli2XDgp5CA7GAak+hIww1kOqPUqcEv5NW0qJpJU
 kMMzxFdQAjmW37pJo0nqOqwzUNjIFDttqYQerAXFRAGN9iv0GVMCdfT8BSYpeiM1jPC8o3CII7
 6afFlmKHxgs8lmB0yJwyTzhnzYGFCkbHy+xuGqtfBqRBCN3D7pthqoS7VpxfRgm3OVQ4EROOxm
 iayRs6zH7QF6YQVMXvUeUVWy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:11:03 -0700
IronPort-SDR: VqrqNIb9EM1IFKr4vuRwy/OZIhvwt7d81t758xPcZx41LhCrWeXyVfNQmB2vo3KAtIUKInEpI7
 bg0dZgaVK2jrPKo0s8cWQsOamW4zHuKYw0At8SCZ8hO6BONPlTmPsl4ZM/911AjyLhbnptNU/e
 nPEeegz0dQhYxxQo9lpNufIuU2dtv6fjVUwMa5p9KhEbwBqHQj7h6mR3NionPC7UY4EF3fQvsY
 15f1TTqiYBLlR8011t+XZ1SESbnYqM+8DfexifiLdZin2Wmxh5IxTV20J7itxTFT7yEZP0E1oG
 r3c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:40:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP4b969Grz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:40:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648078805; x=1650670806; bh=TKVNjUS+N+CCXnSJvdn+dbSRtObno9j5Ory
        hMiYI7JQ=; b=ZsW81WJfyOg4wcvX/sU3WDuVFAz0X6o2zlk2/oUaFZYW+3Po5ol
        WmqJ/h4kl98BMpI7RSoU95GKe5iWlNn5zNsS+4fyUbLn0a3pjFDfOE4xg3EPsyhM
        0R51tNvz6QGM3tvQYy2YN5C8AwUjEkYvLYYymJs3KzYlhynsruqwBv+TIeK8dJUl
        7DNH7cnuaStT9du+rjxxmKcZIBIUflzM7E6tiUCvRoWJJxGExjtCYC04b04l8gFH
        ZnBJirw6H2HPKvRxohl3LiWoMK/UbCVX9hQq7+q7g5FZLQIJOeQkJoYzuK4DGX6N
        vHEEEoABqb8Us+g4ndoVYUoS8LA9aSzwhPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NooQVdEGrs1M for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 16:40:05 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP4b90JBhz1Rvlx;
        Wed, 23 Mar 2022 16:40:04 -0700 (PDT)
Message-ID: <3913fd60-b225-6b0b-b6e2-eaebdcf8201a@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 08:40:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 07:10, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 11:57 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> * Rename ahci_board_mobile to board_ahci_low_power to be more descriptive
>>   of the feature as that is also used on PC and server AHCI adapters,
>>   from Mario.
>>
>> Mario Limonciello (3):
>>       ata: ahci: Rename board_ahci_mobile
>>       ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
>>       ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item
> 
> So I've pulled this, but it's worth noting that particularly renaming
> that CONFIG option was probably not a good idea.
> 
> Why?
> 
> Because it means that people silently lose their old values. And it has that
> 
>         range 0 4
>         default 0
> 
> with 4 being explicitly marked as very dangerous - but at least Fedora
> seems to actually have a default of 3 in their kernels:
> 
>   /boot/config-5.16.13-200.fc35.x86_64:
>         CONFIG_SATA_MOBILE_LPM_POLICY=3
> 
> so that "default 0" may actually not be the right one.

Yes. Mario has follow up patches to change the default. But as changing it
may break things, we are going to try it early this cycle so that it can
get lots of linux-next testing. Since Fedora has had the default of 3 for
a long time now, changing the kernel default from 0 to 3 should be OK. The
goal here is of course to have a default kernel config that is more
eco-friendly.

> Now, we're at the point where few enough people likely care about ATA,
> but the corollary to that is also that these kinds of changes can
> cause user pain that then developers have *no* idea about.
> Particularly when the pain ends up being caused by some subtle default
> config option silently changing that nobody even thought about.
> 
> Now, that "default 0" is probably the only safe default - and I don't
> dispute that part. But I also suspect that Fedora chose that value '3'
> because it probably makes a noticeable power use difference on at
> least some platforms.

Most laptops benefit from it. And yes, most laptop today have switched to
NVMe, but there are still a fair amount out there using SATA SSDs and 2.5"
HDDs, even new ones (low end models).

> I don't know. But I doubt really *anybody* knows, so renaming them and
> silently likely changing config options for some less-than-critical
> reason is just not a great idea.

Understood. I will monitor this and see if a revert of the rename is
needed. For now, I do prefer the new name as it reflects the fact that
link power management policies are not for mobile chipsets anymore and
also apply to regular server chipsets where power consumption really
matters too.


-- 
Damien Le Moal
Western Digital Research
