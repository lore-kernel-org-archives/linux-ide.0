Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3DC4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Nov 2023 22:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjKHWIB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Nov 2023 17:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjKHWIB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2023 17:08:01 -0500
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F795258D
        for <linux-ide@vger.kernel.org>; Wed,  8 Nov 2023 14:07:59 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 6D518148104; Wed,  8 Nov 2023 17:07:58 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <5c0ae578-e736-4dd2-b87e-fa499223f469@kernel.org>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net> <87wmuyqw5t.fsf@vps.thesusis.net>
 <e469fbc3-9b7f-422d-8ff7-08c426eafbaf@kernel.org>
 <874jhxn15u.fsf@vps.thesusis.net>
 <5c0ae578-e736-4dd2-b87e-fa499223f469@kernel.org>
Date:   Wed, 08 Nov 2023 17:07:58 -0500
Message-ID: <878r77uce9.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> Nope. The correct way to do this would be to define PM operations for the ata
> device. However, currently, the scsi_device (scsi_disk) parent is the ata_port,
> so to make sure that the PM status of the parent propagates to the child
> correctly, we would need to have the scsi_device parent set to the ata_device.
> As I said, correcting this is not simple and will involve a significant amount
> of changes.

Don't you mean the scsi disk's parent is the scsi_target, whose parent
is the scsi_host whose parent is the port?  But also somehow the scsi
disk == the scsi lun?

