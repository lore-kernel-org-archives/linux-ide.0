Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CD5C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Nov 2023 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjKHWZf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Nov 2023 17:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHWZe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2023 17:25:34 -0500
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA54199
        for <linux-ide@vger.kernel.org>; Wed,  8 Nov 2023 14:25:32 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 8F8F8148123; Wed,  8 Nov 2023 17:25:31 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <6d2a2015-3e9b-4420-837e-e9fb8816ae78@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
 <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
 <871qd1n0cm.fsf@vps.thesusis.net>
 <6d2a2015-3e9b-4420-837e-e9fb8816ae78@kernel.org>
Date:   Wed, 08 Nov 2023 17:25:31 -0500
Message-ID: <8734xfubl0.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> Yes. Many embedded systems and people using old PCs still use that.
> And that is not the only case. Port multiplier is the other major one since
> multiple drives share the same link. In both cases, the drive "think" it is
> talking to its own port, but the port is used to manage several devices. One
> consequence of this is that the link speed for the port MUST be limited to the
> lowest link speed of all devices. And to discover that, one has to probe all 15
> ports of the PMP to discover the devices attached... Hence the fact that
> bypassing revalidation being a really bad idea.

Really?  I thought that the PMP recieved the FIS on the upstream port,
buffered it, then sent it to the downstream port, and that could be at a
different speed.  So you could have a FBS PMP that is taking 3 Gbps in
on the upstream link, and splitting the FISes out to two different
downstream links at 1.5 Gbps.  Or does that only happen with SAS
switches?

I think the last time I had a PATA drive was before 2006.  It's really
hard to believe that anyone is still using them nearly 20 years later.

> Patching udisk and smartd would be a lot more sensible. An application using
> passthrough to talk to a drive without first checking if the drive is actually
> active is not a sensible thing to do. Especially considering that runtime

They already do that.  The problem is that even checking to see if the
drive is running with CHECK POWER CONDITION causes libata to wake up a
drive from SLEEP ( not STANDBY ) so that it can feed the drive the
command.  Thus why I patched libata to just complete the command without
waking the drive and tell user space that it is in standby.  Likewise,
when the filesystem issued a FLUSH CACHE while the drive is in SLEEP,
libata can just complete the request and ignore it, since there isn't
anything dirty in the cache.
