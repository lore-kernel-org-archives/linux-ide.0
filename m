From: Jason Riedy <jason@acm.org>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller question)
Date: Sun, 03 May 2009 18:35:41 -0400
Message-ID: <874ow1ak76.fsf@sparse.dyndns.org>
References: <E1LzLgA-0004j6-9W@closure.thunk.org>
	<49F90CA2.4080602@garzik.org>
	<20090430083309.437f9248@lithium.local.net>
	<49F95719.10701@kernel.org>
	<20090430144702.46415b90@lxorguk.ukuu.org.uk>
	<20090430153508.GA10704@linux.intel.com>
	<20090430154701.GA27737@srcf.ucam.org> <49FA5519.9000107@gmail.com>
	<49FCFC5D.5050303@kernel.org> <49FE038F.2040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:34707 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbZECXRj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 May 2009 19:17:39 -0400
In-Reply-To: <49FE038F.2040704@gmail.com> (Robert Hancock's message of "Sun,
	03 May 2009 14:50:23 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

And Robert Hancock writes:
> Well, it's a potential concern, but it's simple enough I doubt it
> would really result in much of a burden.

My D620 is one of those that corrupted the file system with the
force-AHCI patch.  If I hadn't applied the patch externally, I might
have guessed it was the file system code...  Given all the churn in the
fs code right now, is it wise to add another *known* corruption vector?

Jason
