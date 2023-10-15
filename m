Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D0DCDB47E
	for <linux-ide@archiver.kernel.org>; Sun, 15 Oct 2023 22:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJOWJh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Oct 2023 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOWJh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Oct 2023 18:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BAAD
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2023 15:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D68C433C7;
        Sun, 15 Oct 2023 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697407773;
        bh=fdg1pOjhuHtc3gGyP6r6jOEuJ+CTzojTEZfUGFXQ4Bg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZB/uAb/Bcm7TmZgZdSzZ5vjBAFW15e9gljFa6LX86JGGg6lKOPoMs8SEveq4burLC
         TReHMGPISOvXORvpYugPNclwXtz27PLvPrPXpVTypfEPqUVlyRtzHaXVcJ6EKX0jpZ
         FHLvEvEHt4h5FOMIvOcIPB8ke+6UoIQ0eSmxx8wwyePF1Y71eMS8ykIedvBRJjrx71
         59WncK0sX7tpYAAnWyjbioyvHeNOU4Vw7Lfi5389hD2t6Qq3XXrK6G+yJQlwFwKseU
         CsujCLP+GiMt2SQo37SgOkr4vomqH3bcR6XsUA1rLQrv84E4WhGMc7rXfSwUitKydt
         2ooz0uSv5OA7g==
Message-ID: <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
Date:   Mon, 16 Oct 2023 07:09:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <871qdyh9na.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/13/23 23:36, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> Yes. I rechecked the specs regarding this and there is nothing preventing
>> IDENTIFY from completing with the drive spun down. The only corner case is when
>> PUIS is enabled, in which case IDENTIFY may return incomplete data. But that is
>> handled already and that is not something we can get with a system
>> suspend/resume or runtime suspend/resume.
> 
> It *IS* something we get on suspend/resume.  During suspend the drive
> loses power, and on resume, it regains power.  As far as the drive is
> concerned, the computer was shutdown and booted back up, so it powers up
> in standby.

In the hybernate (suspend to disk) case, yes, but not in the suspend to RAM
case. Anyway, the PUIS incomplete IDENTIFY case is already handled, so there are
no issues.

>> From re-reading the specs and testing with all my drives, the port reset spins
>> up the drives and IDENTIFY completes OK before the spinup completes, so there
>> is no delay.
> 
> Interesting.  I was under the impression that most disks have to read
> their sererial number and possibly other information from the media in
> order to report that in IDENTIFY, and therefore, they would have to
> finish spinning up before they could return complete information.

Depends on the disk implementation. Not all disks put their metadata on media.
So some disks can start replying to commands like IDENTIFY even with the disks
not fully spun up yet. This difference shows up with (sometimes) seeing
"IDENTIFY failed" due to a timeout on resume. I have old drives that are slow to
spinup and show that. But that is handled with the retries with increased
timeouts. I think it would be nice to patch that though, with longer timeout for
IDENTIFY on resume, to avoid these error messages.

>> I CC-ed you a couple of patches that move the VERIFY command
>> issuin to after revalidation (so execution of IDENTIFY, READ LOG etc). That
>> works well. I also added a CHECK POWER MODE command to check if sending the
>> verify is actually needed. And even while the disks are spinning up, I get
>> power mode 0xFF indicating ACTIVE state, so no need to send the VERIFY command
>> at all. The end result is that we get to finish the libata EH context doing the
>> resume well before the disk finishes spinning up (which can take 10+ seconds).
>>
>> With this, the first read or write command following the resume will be delayed
>> until the drive finishes spinning up. But that is fine given the default 30s
>> tiemout and retries. I do not expect any problems with that.
> 
> That looks very good.  I think I will try to adapt my old patch to allow
> the eh to return -EAGAIN and leave the drive in standby rather than
> force it to wake up with the VERIFY in the system resume path.  The eh
> can be retried later when the drive is actually accessed and that time
> it can force it to spin up.

I am not following. What problem are you trying to fix ?

-- 
Damien Le Moal
Western Digital Research

