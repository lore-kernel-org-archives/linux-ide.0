Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB3CDB47E
	for <linux-ide@archiver.kernel.org>; Fri, 13 Oct 2023 14:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjJMOg2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Oct 2023 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjJMOg1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Oct 2023 10:36:27 -0400
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C695
        for <linux-ide@vger.kernel.org>; Fri, 13 Oct 2023 07:36:26 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id C92BD14482D; Fri, 13 Oct 2023 10:36:25 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
Date:   Fri, 13 Oct 2023 10:36:25 -0400
Message-ID: <871qdyh9na.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> Yes. I rechecked the specs regarding this and there is nothing preventing
> IDENTIFY from completing with the drive spun down. The only corner case is when
> PUIS is enabled, in which case IDENTIFY may return incomplete data. But that is
> handled already and that is not something we can get with a system
> suspend/resume or runtime suspend/resume.

It *IS* something we get on suspend/resume.  During suspend the drive
loses power, and on resume, it regains power.  As far as the drive is
concerned, the computer was shutdown and booted back up, so it powers up
in standby.

> From re-reading the specs and testing with all my drives, the port reset spins
> up the drives and IDENTIFY completes OK before the spinup completes, so there
> is no delay.

Interesting.  I was under the impression that most disks have to read
their sererial number and possibly other information from the media in
order to report that in IDENTIFY, and therefore, they would have to
finish spinning up before they could return complete information.

> I CC-ed you a couple of patches that move the VERIFY command
> issuin to after revalidation (so execution of IDENTIFY, READ LOG etc). That
> works well. I also added a CHECK POWER MODE command to check if sending the
> verify is actually needed. And even while the disks are spinning up, I get
> power mode 0xFF indicating ACTIVE state, so no need to send the VERIFY command
> at all. The end result is that we get to finish the libata EH context doing the
> resume well before the disk finishes spinning up (which can take 10+ seconds).
>
> With this, the first read or write command following the resume will be delayed
> until the drive finishes spinning up. But that is fine given the default 30s
> tiemout and retries. I do not expect any problems with that.

That looks very good.  I think I will try to adapt my old patch to allow
the eh to return -EAGAIN and leave the drive in standby rather than
force it to wake up with the VERIFY in the system resume path.  The eh
can be retried later when the drive is actually accessed and that time
it can force it to spin up.
