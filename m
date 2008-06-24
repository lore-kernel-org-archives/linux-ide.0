From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 10:10:40 +0100
Message-ID: <20080624101040.0c9d7f9c@lxorguk.ukuu.org.uk>
References: <87k5gmz596.fsf@denkblock.local>
	<200806192247.25063.bzolnier@gmail.com>
	<87wskhuk98.fsf@denkblock.local>
	<87r6apuk16.fsf@denkblock.local>
	<20080623101600.391e5245@lxorguk.ukuu.org.uk>
	<873an3tixa.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42726 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758881AbYFXJ21 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 05:28:27 -0400
In-Reply-To: <873an3tixa.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

> alternative to the out of band approach for the purposes you described.
> Now, I even think that I could perhaps fix the request aborting properly

I'm not sure the two are mutually conflicting. The queued reset you've
done is very much cleaner so in theory you can abort the command in the
ioctl and then queue the rest of the reset/recovery as you have done

> equivalent for HDIO_DRIVE_RESET in libata which makes me wonder whether
> this ioctl has actually been used in real life for the purposes you
> described.

Its on the todo list along with more speed control - it gets hard to do
right and cleanly.

> My idea to solve this would be roughly this: Change ide_set_handler to
> leave the ->handler and ->expiry members alone if they have been set on
> entry. If a request is being processed by the time a HDIO_DRIVE_RESET

The basic problem is that we have to issue a speed change and the driver
layer speed change code assumed this was issued polled with a wait (in
fact for some controllers/disks it has to be polled). Not a good thing to
discover you are doing in an IRQ handler ...

> Comments?

I think your basic approach is right. It might be that the abort path
wants to abort and then queue the rest. I could of course be completely
wrong too 8)

Alan
