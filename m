From: Mark Lord <liml@rtr.ca>
Subject: Re: IDE S.M.A.R.T. ioctl errors
Date: Mon, 28 Jul 2008 17:55:42 -0400
Message-ID: <488E405E.4010300@rtr.ca>
References: <20080728060133.GA14007@gollum.tnic> <200807281644.38419.bzolnier@gmail.com> <9ea470500807280916k7824dc28m169f4c4db65023fa@mail.gmail.com> <200807281822.05211.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4656 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbYG1Vzn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 17:55:43 -0400
In-Reply-To: <200807281822.05211.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

If we're going to continue to keep drivers/ide on life-support,
then perhaps one should just add SG_IO::ATA_16 support into it
and leave the "legacy" ioctls alone.

I've done this for linux-2.2.xx (really!), and the patch was rather
tiny indeed -- and that custom kernel now supports all of the fancy
ioctl() needs of hdparm-8.9 and smartctl.

Perhaps a similar patch for drivers/ide ?

Here's my 2.2.xx hack for perusal:
 http://empeg-hijack.sourceforge.net/patches/relative/v489-v490.patch.gz

It won't work on current kernels, of course, but perhaps something similar would.

Cheers
