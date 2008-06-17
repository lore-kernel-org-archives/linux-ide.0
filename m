From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement
 ATAPI_HORKAGE_NOPIO and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 09:43:54 +0100
Message-ID: <20080617094354.338e186b@lxorguk.ukuu.org.uk>
References: <4857313A.1000405@kernel.org>
	<48573174.9050103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35280 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751949AbYFQJBp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 05:01:45 -0400
In-Reply-To: <48573174.9050103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, luke@lukeross.name

On Tue, 17 Jun 2008 12:37:24 +0900
Tejun Heo <tj@kernel.org> wrote:

> LG blueray drive GGW-H10N can't do ATAPI PIO.  Implement
> ATAPI_HORKAGE_NOPIO and apply it to the drive.  If the horkage is
> active, atapi_check_dma() always returns 0 and warns if the controller
> needs ATAPI PIO for certain commands.

This all seems wildly improbable as a drive with such a bug would not
appear to be going to work in Windows. I'd like to know more and see more
than one bug report for that drive before it goes in

You might even be looking at a single drive with a one off wiring flaw or
chip fault at this point.

So in the absence of multiple reports of this drive failing, and
of no other drive being tested on the same controller after the bug was
seen I think this is a *very bad idea* as a patch.

If after 3 months we see a series of such reports then maybe.

Alan
