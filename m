Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5767BC4332F
	for <linux-ide@archiver.kernel.org>; Tue,  7 Nov 2023 13:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjKGN2B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 08:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjKGN2A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 08:28:00 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244D92
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 05:27:58 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 1DDA1147D9A; Tue,  7 Nov 2023 08:27:57 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <e469fbc3-9b7f-422d-8ff7-08c426eafbaf@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net> <87wmuyqw5t.fsf@vps.thesusis.net>
 <e469fbc3-9b7f-422d-8ff7-08c426eafbaf@kernel.org>
Date:   Tue, 07 Nov 2023 08:27:57 -0500
Message-ID: <874jhxn15u.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> That is because the PM operations are defined for the *port*, not the *device*
> (struct ata_device). With the missing PM ops for the device, PM core simply
> sets the device as active.

The ata device appears to be entirely internal and not exposed as part
of the sysfs device tree.  It is the generic block device that seems to
be the one that actually implements runtime pm for the disk.

I think the problem is that the ata port is resumed first, then later
the block device.  Thus, setting the block device to suspended in the
port resume is later overruled by the system resume of the block
device.  I'm thinking what is needed is for sd.c to query libata in its
system resume callback and then set the runtime pm status depending on
whether the drive is active or not.

By the way, I have noticed my system logs showing that the ata port that
my dvd+rw is on is "Activating" twice, back to back.  Any idea why it
would be trying to power up the optial drive twice?

