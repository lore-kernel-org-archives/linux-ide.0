Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A22AC4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Nov 2023 22:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjKHWPz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Nov 2023 17:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKHWPz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2023 17:15:55 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2991258A
        for <linux-ide@vger.kernel.org>; Wed,  8 Nov 2023 14:15:52 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 483A9148114; Wed,  8 Nov 2023 17:15:52 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <7141dc0d-eb1d-41d4-a608-c1fd569e4325@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
 <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
 <871qd1n0cm.fsf@vps.thesusis.net> <87a5rpz13n.fsf@vps.thesusis.net>
 <7141dc0d-eb1d-41d4-a608-c1fd569e4325@kernel.org>
Date:   Wed, 08 Nov 2023 17:15:52 -0500
Message-ID: <875y2buc13.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> Your PMP is looking like type (1).

Correct, which is why the performance isn't good when I try to access
both disks at the same time.

>> When I enable runtime pm on the drives and the top level port, then try
>> to access the sleeping drive, I see this:
>
> How can you enable runtime PM on a port ? That does not work...

It works on *something*, I'm not not sure whether it is or is not the
port.  /sys/devices/pciblahblah/ata2/power/control can be enabled, and
then the port will be runtime suspended.  I'm not not sure what that is
compared to /sys/devices/pciblahblah/ata2/ata_port/ata2/power/control,
which can't be set to auto, and is also /sys/class/ata_port/ata2.  I'm
not sure why there are two different things that look like an "ata port".

> They are the first 2 devices connected to the PMP port that exist. These
> correspond to your sdd and sde scsi disks.

Right, but the PMP itself is not suspended.  I think that causes an
attempt to access the PMP while the root port that connects to the PMP
is suspended, so that access obviously fails.

> Are you running the latest code from Linus tree ? There is now a check on the
> power state of a device to avoid useless activate.

I hadn't pulled in some time.  Updating now.

