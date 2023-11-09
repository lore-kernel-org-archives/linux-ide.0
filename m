Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD74AC4332F
	for <linux-ide@archiver.kernel.org>; Thu,  9 Nov 2023 22:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjKIWJb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Nov 2023 17:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKIWJb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2023 17:09:31 -0500
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F61FF6
        for <linux-ide@vger.kernel.org>; Thu,  9 Nov 2023 14:09:29 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 87FDC1483B8; Thu,  9 Nov 2023 17:09:28 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <875y2buc13.fsf@vps.thesusis.net>
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
 <875y2buc13.fsf@vps.thesusis.net>
Date:   Thu, 09 Nov 2023 17:09:28 -0500
Message-ID: <87pm0ipoiv.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Phillip Susi <phill@thesusis.net> writes:

> I hadn't pulled in some time.  Updating now.

Great... the latest post 6.6 kernel hangs on entry to suspend for me.
Bisecting it now back to the 6.6-rc5 that was previously working.

