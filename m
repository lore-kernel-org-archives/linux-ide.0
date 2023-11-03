Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D971C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  3 Nov 2023 18:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjKCSFY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjKCSFY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Nov 2023 14:05:24 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B4D6E
        for <linux-ide@vger.kernel.org>; Fri,  3 Nov 2023 11:05:18 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id DBACE14769C; Fri,  3 Nov 2023 14:05:17 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
Date:   Fri, 03 Nov 2023 14:05:17 -0400
Message-ID: <87h6m24srm.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Sorry for the delay, I've been out sick all week.

Damien Le Moal <dlemoal@kernel.org> writes:
> Sure, but I think we can skip the spinup only and only if the drive has PUIS
> enabled and reported a complete IDENTIFY: in this case, we can skip the SET
> FEATURES command that spins up the drive to leave the drive spun down. Some more
> code will be needed though so that we track that the drive is spun sdown because
> of PUIS and not because of STANDBY IMMEDIATE, so that ata_dev_power_set_active()
> issues a SET FEATURES to spinup the drive instead of the regular VERIFY command.

I don't see why the revalidation MUST be performed at system resume.
The patch I've been working on leaves the error flags and also sets the
DFLAG_SLEEPING flag on the disk when it's PuiS.  Then later when the
disk is accessed, the SLEEPING flag schedules another round of eh, which
resets the link, and revalidates the disk, and this time the SET
FEATURES command is used to wake the drive.  I'll post the patch in a
few hours when I get home.

The basic case of postponing the wakeup of the drive until the disk is
later accessed seems to work fine.  Unfortunately, that later access
comes quickly either in the form of a CHECK POWER CONDITION from
udisks2.service, or FLUSH CACHE from the filesystem.  These commands
don't cause the drive to spin up when it is in ata STANDBY mode, but do
with runtime suspend.  I'm leaning towards modifying the blk_queue to
allow the driver to register a method to be called on a request when the
block device is runtime suspended to possibly handle the request without
activating the block device first.

> Note: I am still not able to see runtime suspend automatically suspend the ata
> port if I enable a scsi disk autosuspend_delay_ms. That does not happen for me.
> In fact, I cannot even read a ata port autosuspend delay:
>
> cat /sys/class/ata_port/ata2/power/autosuspend_delay_ms
> cat: /sys/class/ata_port/ata2/power/autosuspend_delay_ms: Input/output error

Right, there is no activity timer on the port.

> But I have:
>
> cat /sys/class/ata_port/ata2/power/control
> auto

If that is set to auto then it seems to auto suspend once all children
have gone to runtime suspend.  For my internal ports, they only have a
single child, so when the drive enters runtime suspend, so does the
port.  For the eSATA PMP dock, BOTH drives have to suspend before the
port will.

