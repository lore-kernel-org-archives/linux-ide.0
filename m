Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112D5C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 03:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjKFDAg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Nov 2023 22:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFDAf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2023 22:00:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3108CFB
        for <linux-ide@vger.kernel.org>; Sun,  5 Nov 2023 19:00:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B466C433C7;
        Mon,  6 Nov 2023 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699239631;
        bh=SA+gvykqly30qpZYC3unfj2at4CaomPfHErhANgiWgc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PBzoQx9RO4yg1y96BApyTXzOx3zOSy6xn9hmHuePhDL6wPRxZvhpjv/erHtTlf5Zw
         z6gklRq8AuyxNURmHBrbmiC+EhMP82ylj3sMdyqd83OarazuAaxq4qojdtQGnNgsXP
         daa6I6CzJjYHi+5mBvDF7QUvHF9xA7XeUs/KJLFm91AVI/tCQfVEAP3YENxH4FEFrk
         XlluHmERoY3XF8HivkFaEj27/Cm0o0SGs/vheSsa5jCxNEQIQRgB0EJoxfIcW9rFv0
         trwsFvn3USwagys0bGhQJxOG4KujxkmSJI0367nIpe+kna2el+DDlsvw5VBMPrvAp9
         XJ+C5pc7pn/+w==
Message-ID: <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
Date:   Mon, 6 Nov 2023 12:00:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
Content-Language: en-US
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87h6m24srm.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/4/23 03:05, Phillip Susi wrote:
> Sorry for the delay, I've been out sick all week.
> 
> Damien Le Moal <dlemoal@kernel.org> writes:
>> Sure, but I think we can skip the spinup only and only if the drive has PUIS
>> enabled and reported a complete IDENTIFY: in this case, we can skip the SET
>> FEATURES command that spins up the drive to leave the drive spun down. Some more
>> code will be needed though so that we track that the drive is spun sdown because
>> of PUIS and not because of STANDBY IMMEDIATE, so that ata_dev_power_set_active()
>> issues a SET FEATURES to spinup the drive instead of the regular VERIFY command.
> 
> I don't see why the revalidation MUST be performed at system resume.

Revalidation is needed to make sure that the device settings did not change, or
that the device itself did not change. This must be done before we start using
the drive again on a system resume or on a port runtime resume.

The current code always revalidates the devices attached to a port on system
resume, unless the port was runtime suspended. If the port was runtime
suspended, then revalidation will be done on runtime resume.

The main issue here which make things messy is the fact that the PM ops are
defined for the port, not for the device. Separating things would be cleaner,
but I think that is extremely hard to do considering the cases where we have
multiple devices per port. For these cases, setting the link speed etc may
depend on all the devices responding. So leaving some devices sleeping may be
very dangerous to do.

> The patch I've been working on leaves the error flags and also sets the
> DFLAG_SLEEPING flag on the disk when it's PuiS.  Then later when the
> disk is accessed, the SLEEPING flag schedules another round of eh, which
> resets the link, and revalidates the disk, and this time the SET
> FEATURES command is used to wake the drive.  I'll post the patch in a
> few hours when I get home.

I commented on that. Your patch has a deadlock path.

> The basic case of postponing the wakeup of the drive until the disk is
> later accessed seems to work fine.  Unfortunately, that later access
> comes quickly either in the form of a CHECK POWER CONDITION from
> udisks2.service, or FLUSH CACHE from the filesystem.  These commands
> don't cause the drive to spin up when it is in ata STANDBY mode, but do
> with runtime suspend.  I'm leaning towards modifying the blk_queue to
> allow the driver to register a method to be called on a request when the
> block device is runtime suspended to possibly handle the request without
> activating the block device first.

udisks2 issues passthrough commands, no ? We do not parse these currently, and
we will *not* start doing that. For other operations like sync etc which end up
as a FLUSH CACHE command, or any other command that require medium access,
triggering EH when we prepare these commands in the submission path is not
nice. Not even sure that can work. That may need some significant changes to work.

>> Note: I am still not able to see runtime suspend automatically suspend the ata
>> port if I enable a scsi disk autosuspend_delay_ms. That does not happen for me.
>> In fact, I cannot even read a ata port autosuspend delay:
>>
>> cat /sys/class/ata_port/ata2/power/autosuspend_delay_ms
>> cat: /sys/class/ata_port/ata2/power/autosuspend_delay_ms: Input/output error
> 
> Right, there is no activity timer on the port.
> 
>> But I have:
>>
>> cat /sys/class/ata_port/ata2/power/control
>> auto
> 
> If that is set to auto then it seems to auto suspend once all children
> have gone to runtime suspend.  For my internal ports, they only have a
> single child, so when the drive enters runtime suspend, so does the
> port.  For the eSATA PMP dock, BOTH drives have to suspend before the
> port will.

Well, I do not see that happening. "cat
/sys/class/ata_port/ataX/power/runtime_status" always says "unsupported" on my
system. So not sure how you can get that... The only "link" between a scsi disk
device and an ata_port device is created by libata with the RPM_ACTIVE flag
which runs pm_runtime_get_sync() on the supplier, that is, the ata_port. So I
do not see how runtime suspend could ever work for a port as-is.

The fact that you seem to be seeing a different behavior than me kind of
indicates that something is still broken with the runtime port management. Not
sure what exactly. Could you send me your kernel config please ? I would like
to see if using that I get a different behavior. Also, what are your ata
adapters (vendor/model) ?

-- 
Damien Le Moal
Western Digital Research

