Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DFBC25B48
	for <linux-ide@archiver.kernel.org>; Wed, 25 Oct 2023 02:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJYCLP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Oct 2023 22:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCLO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Oct 2023 22:11:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0ABE5;
        Tue, 24 Oct 2023 19:11:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD15C433C7;
        Wed, 25 Oct 2023 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698199872;
        bh=XqSsIpjt0jIyZn7qo3bPFPqEdb+PQBuF8ciog/cTS3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TVWETUnaYoM74TyyGZNyWwa9rzO5bBRy5EHR8Bk9H4fieHqpt+dmZpTNC2wdiEnkU
         teFwryJJotMK4JcDktGOaXMzL5fic8dej3ViDt+rtfkyIIdf3oDG6n7Ro8UFX3kVnV
         sWFfla00iE0xEL9jWMO3evQcx6IJH6iv3mQnJB9WTkEQt4WdkaI/2QAzpfxY6JZvlW
         /XN2P+vrOEd4JhQbMTFhuV+Il7r/2ON+25CaFeozA1MT73BZcPT5+jctYBYQhkDUF+
         zrTSeAgDJ5A467sNR80kkOi5IzY4MSqpq0nCmEBKekkc9hrOxVSN/UYLYMYqch3Hrf
         ELz4ZncJ/ZPVQ==
Message-ID: <ba2115a9-46a5-4bc7-be5d-97ee2c0a0492@kernel.org>
Date:   Wed, 25 Oct 2023 11:11:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: bbbf096ea227607cbb348155eeda7af71af1a35b results in "dirty"
 shutdown
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
Content-Language: en-US
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

I am aware of this and looking into it. The patch mentioned above seems to have
introduced the issue that drives are not being stopped on shutdown with real
PCs. But they are with qemu VM. So this seems to relate to ACPI shutdown as
well. Not sure, looking into it.

The main issue I have is that I cannot reproduce the old behavior mentioned in
this case, which is, the counters not incrementing on shutdown. They do increase
for me, always, even prior to the patch mentioned above.

Digging.

> Anyway, I'm adding this regression to regzbot:
> 
> #regzbot introduced: aa3998dbeb3abc https://bugzilla.kernel.org/show_bug.cgi?id=218038
> #regzbot title: dirty shutdown due to disabling manage_system_start_stop on SCSI devices
> #regzbot link: https://bugs.archlinux.org/task/80064
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218038
> 

-- 
Damien Le Moal
Western Digital Research

