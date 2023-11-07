Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8BFC4332F
	for <linux-ide@archiver.kernel.org>; Tue,  7 Nov 2023 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjKGNrB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 08:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjKGNqH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 08:46:07 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F310C9
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 05:45:29 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 425E4147DA7; Tue,  7 Nov 2023 08:45:29 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
 <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
Date:   Tue, 07 Nov 2023 08:45:29 -0500
Message-ID: <871qd1n0cm.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> Revalidation is needed to make sure that the device settings did not change, or
> that the device itself did not change. This must be done before we start using
> the drive again on a system resume or on a port runtime resume.
>
> The current code always revalidates the devices attached to a port on system
> resume, unless the port was runtime suspended. If the port was runtime
> suspended, then revalidation will be done on runtime resume.

I don't see any checks for whether the port was previously runtime
suspended or not.  It looks to me like it unconditionally revalidates
all devices on system resume, which is why I'm trying to patch it to
defer that until runtime resume.

> The main issue here which make things messy is the fact that the PM ops are
> defined for the port, not for the device. Separating things would be cleaner,
> but I think that is extremely hard to do considering the cases where we have
> multiple devices per port. For these cases, setting the link speed etc may
> depend on all the devices responding. So leaving some devices sleeping may be
> very dangerous to do.

Ahh, right.... you mean for PATA right?  Does anyone still have any of
those these days? :)

> udisks2 issues passthrough commands, no ? We do not parse these currently, and
> we will *not* start doing that. For other operations like sync etc which end up
> as a FLUSH CACHE command, or any other command that require medium access,
> triggering EH when we prepare these commands in the submission path is not
> nice. Not even sure that can work. That may need some significant changes to work.

Isn't the NORMAL time eh is triggered is in response to normal IO being
submitted?  Power management is kind of the auxiliary use of eh.

I had another patch in my old series that had libata fake several
commands rather than waking up the drive from SLEEP.  That included
IDENTIFY, FLUSH CACHE, STANDBY1_NOW, and CHECK POWER CONDITION.  Those were needed to
keep udisks or smartd from waking up the drive.

> Well, I do not see that happening. "cat
> /sys/class/ata_port/ataX/power/runtime_status" always says "unsupported" on my
> system. So not sure how you can get that... The only "link" between a scsi disk
> device and an ata_port device is created by libata with the RPM_ACTIVE flag
> which runs pm_runtime_get_sync() on the supplier, that is, the ata_port. So I
> do not see how runtime suspend could ever work for a port as-is.

I normally cd -P /sys/block/sda, which gets me into what appears to be
the scsi lun.  Going up a few directories through the scsi target, scsi
host, and finally to the ataX, I find that node's power/control is
set to on, and if I change it to auto, then dmesg shows the port doing
runtime suspend and resume.  I think there was another ata_port
subdirectory in there somewhere, maybe that's the one you're looking at?
I'm not sure what the difference is between ata8 and ata8/ata_port/ata8,
but I think the latter did not support runtime pm, so I'm guessing that
is the one you are looking at.

> The fact that you seem to be seeing a different behavior than me kind of
> indicates that something is still broken with the runtime port management. Not
> sure what exactly. Could you send me your kernel config please ? I would like
> to see if using that I get a different behavior. Also, what are your ata
> adapters (vendor/model) ?

I'll try to get you the config tonight.  My internal drives are on an
Intel AHCI controller built into the southbridge of my chipset.  My
external drives are on another cheap AHCI eSATA controller I got, since
the Intel doesn't support hotplug or PMP iirc.
