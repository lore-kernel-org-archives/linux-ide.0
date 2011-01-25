From: Herbert Poetzl <herbert@13thfloor.at>
Subject: WDC WD20EARS and 4k sector size
Date: Tue, 25 Jan 2011 04:04:10 +0100
Message-ID: <20110125030410.GA24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:59715 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab1AYDEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 22:04:11 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I recently bought the WDC WD20EARS-00MVWB0 because it
was really cheap for a drive with 64 MB cache, and I
wanted to try out a 4k sector size disk ...

Now the drive performs quite well, is rather silent
and doesn't use much power or produce much heat, but
at first I didn't find anything in Linux indicating
that this drive would actually use 4k sectors.

To shorten things, I asked around on IRC, had a chat
with some other folks, found a jumper description on
the WD site talking about an 'Advanced Format' jumper
and finally contacted WD in a lengthy email thread.

The results of all this are:

 - the drive doesn't report 4k sectors at all, not
   even as physical sector size.

 - the 'Advanced Format' jumper shifts access to the
   the drive by one sector.

I did some tests to verify that, and I can confirm
the behaviour of the jumper in question with certain
benchmark tests (using dm and bonnie++) with and
without the jumper in place.

My question now is, how can I tell the kernel that
this drive actually has 4k physical sectors and that
it would be a smart thing to send requests in some 
kind of 4k I/O chunks?

Many thanks in advance,
Herbert

PS: if somebody is interested in the tests done to
verify the jumper, please let me know ...
