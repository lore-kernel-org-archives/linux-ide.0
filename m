Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92450C004C0
	for <linux-ide@archiver.kernel.org>; Sat, 21 Oct 2023 17:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjJUR4K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 21 Oct 2023 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjJUR4J (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2023 13:56:09 -0400
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620DB188
        for <linux-ide@vger.kernel.org>; Sat, 21 Oct 2023 10:56:04 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 849C8145B1C; Sat, 21 Oct 2023 13:56:03 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
Date:   Sat, 21 Oct 2023 13:56:03 -0400
Message-ID: <87sf63hnbg.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> In the hybernate (suspend to disk) case, yes, but not in the suspend
> to RAM

No; in BOTH cases.  In S3, the PSU is shut down and only aux power is
maintained to keep the sdram in auto refresh mode.  The main power rails
that power the disk drives are shut down.  The drive can not tell
whether suspend to disk or suspend to ram was used.

> Depends on the disk implementation. Not all disks put their metadata on media.
> So some disks can start replying to commands like IDENTIFY even with
> the disks

Yes, the standard allows either way and I'm sure that there are both out
there, I just thought that the incomplete IDENTIFY because it needs the
media case was the more common of the two.  At least I think my WD
drives do that.

> not fully spun up yet. This difference shows up with (sometimes) seeing
> "IDENTIFY failed" due to a timeout on resume. I have old drives that are slow to
> spinup and show that. But that is handled with the retries with increased
> timeouts. I think it would be nice to patch that though, with longer timeout for
> IDENTIFY on resume, to avoid these error messages.

Isn't the timeout like 10 or 20 seconds and typical spinup times only
3-4?  Still, yes, a little longer timeout for the IDENTIFY after resume
might be a good idea.

> I am not following. What problem are you trying to fix ?

I would like my archive disks to PuiS and just remain in standby after a
system resume, because I hardly ever access them.  Thus it's putting
unneccesary wear and tear on them to spin up, then spin right back down
every time I system suspend and resume.

I suspend/resume my desktop at least once a day, but I can see this
being an even larger problem on a NAS that wants to use opportunistic
suspend to save power.  Just because you say, want to connect to the
management web interface, or have a scheduled cron job every hour that
forces it to wake up from system suspend does not mean that the disk, or
all disks, need to spin up each time.

Laptops also tend to system suspend/resume more frequently, it it seems
to be becoming at least somewhat common to have a HDD for archive, and an
SSD/NVME to run the system on, and the HDD is not likely going to be
accessed every time the system suspends and resumes, so why bother
spinning it up automatically?

