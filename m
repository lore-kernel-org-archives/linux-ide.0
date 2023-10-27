Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C2C25B47
	for <linux-ide@archiver.kernel.org>; Fri, 27 Oct 2023 07:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0Hlf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Oct 2023 03:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0Hlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Oct 2023 03:41:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A747116;
        Fri, 27 Oct 2023 00:41:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A645AC433C8;
        Fri, 27 Oct 2023 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698392492;
        bh=NvacY1hEpnqQButdl2GZZQ6vULuGFAPU0qOtVRd1wRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e/5k/Mhyzvsd0Sz+hPynIiHfCMpBcCwbq4rpPw5o6xUJBpa24Xjb48yTiUTxabp7i
         xFe7psurwgdbDN1OuYTczgK1JvLGzeg8czCoLoWHuUEqcMdq+EgGwz4IfoIEkD3WU5
         VfClx8D9TFTSShSpiL6Nw0r5JFWaE+q6yTwOInz1O+SXvHFODkLaFQBjZyCBwkgH0f
         YMaqfugGIKT4LnxjfpyUbqiOe3u2HE5vf47x7p3/1FEJynq/hAqRduNgSpVD0KeTOC
         Eanb/0NG99tTsEYzGgWTQfPi9B7Brec3BbUbBMMFM+ewsniotp9vTCpTqaC2DX3e2u
         0G18SbH5kXxYA==
Message-ID: <a704bb1e-4be0-46f8-8118-a18b0547375f@kernel.org>
Date:   Fri, 27 Oct 2023 16:41:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: bbbf096ea227607cbb348155eeda7af71af1a35b results in "dirty"
 shutdown
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Totallyreal Name <kotversuchung@gmail.com>,
        loqs <kernel_bugzilla@entropy-collector.net>
References: <cd397c88-bf53-4768-9ab8-9d107df9e613@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cd397c88-bf53-4768-9ab8-9d107df9e613@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/23 09:40, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla that seems to have been
> handled already there [1]. Quoting from it:
> 
>> I have noticed that after each shutdown SMART would log +1 on each raw_value of drives that count power related issues.
>>
>> Here are some of the smart values where i noticed increase among different drives
>>
>> POR_Recovery_Count 
>> Unexpect_Power_Loss_Ct  
>> Power-Off_Retract_Count 
>>
>> That doesn't happen on previous Kernels.. and it stops as soon as i switch back to LTS.
>> I seeked through the Bug Reports but couldn't really find the issue. So i don't know if this has been reported or patched already.
> 
> Another reporter had found the culprit:
> 
>>
>>
>> This has been reported as being introduced in stable 6.5.8 [1].  Reverting commit 	bbbf096ea227607cbb348155eeda7af71af1a35b is reported to solve the issue [2]. bbbf096ea227607cbb348155eeda7af71af1a35b [3] is mainline commit aa3998dbeb3abce63653b7f6d4542e7dcd022590 [4] which was introduced in 6.6-rc4 which matches the original report.
>>
>> [1]: https://bugs.archlinux.org/task/80064
>> [2]: https://bugs.archlinux.org/task/80064#comment223100
>> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bbbf096ea227607cbb348155eeda7af71af1a35b
>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa3998dbeb3abce63653b7f6d4542e7dcd022590
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regzbot introduced: aa3998dbeb3abc https://bugzilla.kernel.org/show_bug.cgi?id=218038
> #regzbot title: dirty shutdown due to disabling manage_system_start_stop on SCSI devices
> #regzbot link: https://bugs.archlinux.org/task/80064

#regzbot fixed-by: 24eca2dce0f8d19db808c972b0281298d0bafe99


> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218038
> 

-- 
Damien Le Moal
Western Digital Research

