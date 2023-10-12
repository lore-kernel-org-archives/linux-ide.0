Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ACBCDB46E
	for <linux-ide@archiver.kernel.org>; Thu, 12 Oct 2023 19:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjJLTB4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTB4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 15:01:56 -0400
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9B83
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 12:01:54 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id BC6FC1445D6; Thu, 12 Oct 2023 15:01:53 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <c0b086ab-dcd5-4b7b-b931-4d407dd7ad47()kernel!org>
References: 
Date:   Thu, 12 Oct 2023 15:01:53 -0400
Message-ID: <87edhz3bry.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal () kernel ! org> writes:

> In theory, yes, that was the intent. In practice, the verify was issued from
> scsi PM resume context while the actual drive port reset + revalidation is done
> in libata EH context, triggered from ATA port resume context which itself was
> not synchronized/ordered with the scsi disk resume. So we ended up with the
> verify command execution sometimes being attempted with the drive not even
> revalidated yet, or with the port/link not even active sometimes (depending on
> timing). So problems all over and deadlocks due to scsi revalidate using the
> device lock, which PM use too.

Yikes.

> See above. With the switch to async PM ops in scsi in kernel 5.16, things broke
> badly due to the lack of synchronization that sync PM provided before that.

Yes, but without async PM ops, the IDENTIFY command that was not
preceeded by a VERIFY worked just fine, right?

> ACS defines that only media access commands can get a drive out of standby mode
> back into active mode. So an IDENTIFY command would not (normally)
> spinup a

Right, it won't CAUSE the drive to spin up, but if it is already in the
process of spinning up ( due to the reset ), then the drive will finish
spinning up before answering the IDENTIFY command.  Or do you think that
some drives may handle the IDENTIFY wrong if they are still in the
process of spinning up?
