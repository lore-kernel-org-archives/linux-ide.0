Return-Path: <linux-ide+bounces-1-linux-ide=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D6C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Nov 2023 18:32:52 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4EDB20BAB
	for <linux-ide@archiver.kernel.org>; Fri, 10 Nov 2023 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418543AC08
	for <linux-ide@archiver.kernel.org>; Fri, 10 Nov 2023 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538F3D3B6
	for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2023 17:47:03 +0000 (UTC)
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDC212E
	for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2023 08:41:34 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 0CB8F14854F; Fri, 10 Nov 2023 11:41:34 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <e6655105-0f43-4dcf-975a-26a7951a336d@kernel.org>
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
 <875y2buc13.fsf@vps.thesusis.net> <87pm0ipoiv.fsf@vps.thesusis.net>
 <e6655105-0f43-4dcf-975a-26a7951a336d@kernel.org>
Date: Fri, 10 Nov 2023 11:41:34 -0500
Message-ID: <878r75lfwh.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> Arg... Are you testing Linus latest tree ?
> I will rerun tests on my end.

Yes.  It looks like something broke related to the radeon driver.  After
a magic sysrq reboot, I had some things in my logs that sounded like it
failed to suspend, leaving the system still running, but the video
output also died causing my monitor to power down.  It also seemed to
cause my wayland server to hang so the keyboard caps lock key wouldn't
respond.  I started bisecting last night then after a few steps,
realized I wasn't testing the right kernel because grub defaulted to
loading the highest kernel version number rather than the most recently
built one, so I had to start over.

