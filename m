Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171BCDB474
	for <linux-ide@archiver.kernel.org>; Mon, 23 Oct 2023 05:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJWFuE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Oct 2023 01:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWFuD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Oct 2023 01:50:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B826FC
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2023 22:50:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE1BC433C8;
        Mon, 23 Oct 2023 05:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698040200;
        bh=kNlzZ+tmY+1p03s7eYXvhSkOqt7XNUBo3ZOAWwhThMo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KMO2zrB99PAqikjTsC//lMfIwT/xQEmmt3rrfqFjOb/vWLPU8pSZszKaVDiVcwJ/n
         19nA+NDo3P5kZUc4dACYKfQ5JaXcsT4ad/WtyVzho8RiWHkyXsspaygZMPV3lDIg77
         vls7XPuosODO0BFTDw7EAtnz5cvXWEnvYru6VVR1msVgIRFbCAz2zAfDO8H+tVQbDF
         YmoB9R4wO5wBPwvj4nGOI4xrzk9gIEdgoUlIiwMc/Y6wIN8lQXNkePYEcue9qB3Ohi
         s9gkWYfQ6deQ/Uu1fZxj5OLa5CVtl3nBc+eBqt9PeH61ERLg97XT+gYiHsF1lRPvNw
         G+AaL0sIWPEbw==
Message-ID: <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
Date:   Mon, 23 Oct 2023 14:49:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87sf63hnbg.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/22/23 02:56, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> In the hybernate (suspend to disk) case, yes, but not in the suspend
>> to RAM
> 
> No; in BOTH cases.  In S3, the PSU is shut down and only aux power is
> maintained to keep the sdram in auto refresh mode.  The main power rails
> that power the disk drives are shut down.  The drive can not tell
> whether suspend to disk or suspend to ram was used.

OK. I am a bit fuzzy on what ACPI modes do :)

>> Depends on the disk implementation. Not all disks put their metadata on media.
>> So some disks can start replying to commands like IDENTIFY even with
>> the disks
> 
> Yes, the standard allows either way and I'm sure that there are both out
> there, I just thought that the incomplete IDENTIFY because it needs the
> media case was the more common of the two.  At least I think my WD
> drives do that.

The incomplete IDENTIFY with PUIS is likely very common with old drives. Newer
ones may not rely on the media for metadata, especially enterprise drives.

>> not fully spun up yet. This difference shows up with (sometimes) seeing
>> "IDENTIFY failed" due to a timeout on resume. I have old drives that are slow to
>> spinup and show that. But that is handled with the retries with increased
>> timeouts. I think it would be nice to patch that though, with longer timeout for
>> IDENTIFY on resume, to avoid these error messages.
> 
> Isn't the timeout like 10 or 20 seconds and typical spinup times only
> 3-4?  Still, yes, a little longer timeout for the IDENTIFY after resume
> might be a good idea.

The timeouts for identify when scanning the device are defined by
ata_eh_identify_timeouts in libata-eh.c. So 5s, 10s and 30s defined in 3
retries. But on boot, without PUIS, the drive is already (mostly) spun up
generally when the scan code is executed. So even the short-ish first timeout of
5s is enough. But for resume, the time between restoring power and executing
IDENTIFY is much shorter, so the first 5s timeout is a little too short.
IDENTIFY will be OK with the second 10s timeout for most drives, but I do have
some that are very slow and endup needing the third 30s timeout.

To avoid that, I think we need to use the longer ata_eh_reset_timeouts or define
a set of resume timeouts (e.g. a ata_eh_resume_timeouts array).

>> I am not following. What problem are you trying to fix ?
> 
> I would like my archive disks to PuiS and just remain in standby after a
> system resume, because I hardly ever access them.  Thus it's putting
> unneccesary wear and tear on them to spin up, then spin right back down
> every time I system suspend and resume.

The problem here is the potentially incomplete IDENTIFY on resume. We need the
full IDENTIFY to ensure that nothing changed with the drive. So for a drive that
reports an incomplete IDENTIFY with PUIS, we need to spin up that drive on
resume, even if it was runtime suspended before the system suspend.

> I suspend/resume my desktop at least once a day, but I can see this
> being an even larger problem on a NAS that wants to use opportunistic
> suspend to save power.  Just because you say, want to connect to the
> management web interface, or have a scheduled cron job every hour that
> forces it to wake up from system suspend does not mean that the disk, or
> all disks, need to spin up each time.

Yes, that would be nice to have such feature, but I do not see how to reliably
implement that.

> Laptops also tend to system suspend/resume more frequently, it it seems
> to be becoming at least somewhat common to have a HDD for archive, and an
> SSD/NVME to run the system on, and the HDD is not likely going to be
> accessed every time the system suspends and resumes, so why bother
> spinning it up automatically?

Sure, but I think we can skip the spinup only and only if the drive has PUIS
enabled and reported a complete IDENTIFY: in this case, we can skip the SET
FEATURES command that spins up the drive to leave the drive spun down. Some more
code will be needed though so that we track that the drive is spun sdown because
of PUIS and not because of STANDBY IMMEDIATE, so that ata_dev_power_set_active()
issues a SET FEATURES to spinup the drive instead of the regular VERIFY command.

If the drive has PUIS and reported an incomplete IDENTIFY, we need to spin it up
to finish revalidation normally. And for drives that do not have PUIS or have
PUIS disabled, the drive will spin up on system resume, always. For these, we
could call ata_dev_power_set_standby() at the end of revalidation to be
consistent with the runtime suspend state (if the drive was runtime suspended
before the system suspend.

Note: I am still not able to see runtime suspend automatically suspend the ata
port if I enable a scsi disk autosuspend_delay_ms. That does not happen for me.
In fact, I cannot even read a ata port autosuspend delay:

cat /sys/class/ata_port/ata2/power/autosuspend_delay_ms
cat: /sys/class/ata_port/ata2/power/autosuspend_delay_ms: Input/output error

But I have:

cat /sys/class/ata_port/ata2/power/control
auto

So this is all weird. There is a bug somewhere. I need to dig into that.

-- 
Damien Le Moal
Western Digital Research

