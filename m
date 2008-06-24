From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 14:35:48 +0100
Message-ID: <20080624143548.24dcf511@lxorguk.ukuu.org.uk>
References: <87k5gmz596.fsf@denkblock.local>
	<200806240041.42796.bzolnier@gmail.com>
	<87skv3s3d9.fsf@denkblock.local>
	<200806241306.42054.bzolnier@gmail.com>
	<20080624133218.6bccab75@lxorguk.ukuu.org.uk>
	<58cb370e0806240621g61370f56j660e31790dad89c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37914 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753153AbYFXNzA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 09:55:00 -0400
In-Reply-To: <58cb370e0806240621g61370f56j660e31790dad89c3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

> > I don't see why you think it's "hard". We have timeout handlers for many
> > commands and those reset/abort just fine.
> 
> They are different beasts from user-space initiated abort operation

No they are not. They are the *same* thing in every respect.

You have the drive in an unknown state, you want it back. If your drive
lost a command due to noise or a firmware flaw you have no idea about the
state it is actually in (supposed to be is irrelevant)

Alan
