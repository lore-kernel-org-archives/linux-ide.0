Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F7CDB474
	for <linux-ide@archiver.kernel.org>; Fri, 13 Oct 2023 00:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJMA5e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 20:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMA5d (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 20:57:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83412BE
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 17:57:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3032C433C8;
        Fri, 13 Oct 2023 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697158651;
        bh=LPHMESn599g78ofAAjmlSwt+NDITt8y5SkuPdMc6rUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dkUhrQwHe9mtAxMz9QlSg8qoAmtc2bwR0WL0Z8gvgK0Yx9xtug988V7dSL4E/Xl5E
         69oWitjwl7AvQ3Q8e5mIy7f0LvlYsVmsANV6Kgvs10pJQ0RdRCd65xDm9Tx+N3TJKa
         tYcn5BNaAZaNaJfMDwudlFsJ/OtrGxk1+7blvKqw0xwzP03Mky7yYYIGTSp9FiXBno
         112JQj4smx0JlKIJCnkSs9WmqGbGCnZUAbj1RikE0Eajm9+IJOYmAo/OHMVyMmEQSV
         g5RsXruY0mYpVMdUMhtKm00oq8Ekj5TjftzRIfZI2tR0MpbdAhPXGndYSxXWrNc9YT
         /qN/XXaDDHNDQ==
Message-ID: <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
Date:   Fri, 13 Oct 2023 09:57:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87edhz3bry.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/13/23 04:01, Phillip Susi wrote:
> Damien Le Moal <dlemoal () kernel ! org> writes:
> 
>> In theory, yes, that was the intent. In practice, the verify was issued from
>> scsi PM resume context while the actual drive port reset + revalidation is done
>> in libata EH context, triggered from ATA port resume context which itself was
>> not synchronized/ordered with the scsi disk resume. So we ended up with the
>> verify command execution sometimes being attempted with the drive not even
>> revalidated yet, or with the port/link not even active sometimes (depending on
>> timing). So problems all over and deadlocks due to scsi revalidate using the
>> device lock, which PM use too.
> 
> Yikes.
> 
>> See above. With the switch to async PM ops in scsi in kernel 5.16, things broke
>> badly due to the lack of synchronization that sync PM provided before that.
> 
> Yes, but without async PM ops, the IDENTIFY command that was not
> preceeded by a VERIFY worked just fine, right?

Yes. I rechecked the specs regarding this and there is nothing preventing
IDENTIFY from completing with the drive spun down. The only corner case is when
PUIS is enabled, in which case IDENTIFY may return incomplete data. But that is
handled already and that is not something we can get with a system
suspend/resume or runtime suspend/resume.

>> ACS defines that only media access commands can get a drive out of standby mode
>> back into active mode. So an IDENTIFY command would not (normally)
>> spinup a
> 
> Right, it won't CAUSE the drive to spin up, but if it is already in the
> process of spinning up ( due to the reset ), then the drive will finish
> spinning up before answering the IDENTIFY command.  Or do you think that
> some drives may handle the IDENTIFY wrong if they are still in the
> process of spinning up?

From re-reading the specs and testing with all my drives, the port reset spins
up the drives and IDENTIFY completes OK before the spinup completes, so there
is no delay. I CC-ed you a couple of patches that move the VERIFY command
issuin to after revalidation (so execution of IDENTIFY, READ LOG etc). That
works well. I also added a CHECK POWER MODE command to check if sending the
verify is actually needed. And even while the disks are spinning up, I get
power mode 0xFF indicating ACTIVE state, so no need to send the VERIFY command
at all. The end result is that we get to finish the libata EH context doing the
resume well before the disk finishes spinning up (which can take 10+ seconds).

With this, the first read or write command following the resume will be delayed
until the drive finishes spinning up. But that is fine given the default 30s
tiemout and retries. I do not expect any problems with that.

-- 
Damien Le Moal
Western Digital Research

