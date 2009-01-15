From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use
 HORKAGE_NOSETXFER
Date: Thu, 15 Jan 2009 09:45:00 +0000
Message-ID: <20090115094500.18d60455@lxorguk.ukuu.org.uk>
References: <20090107141536.231980@gmx.net>
	<20090107142351.79749c05@lxorguk.ukuu.org.uk>
	<496ECE36.6010706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52981 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751472AbZAOJor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 04:44:47 -0500
In-Reply-To: <496ECE36.6010706@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Moritz Rigler <moritz1234567@gmx.de>, linux-ide@vger.kernel.org

> > Yes - I'd like it to just work, but I'd like it to just work without
> > breaking anything else, without adding device specific special cases and
> > ideally in a way that makes other stuff that is similarly odd just work
> > too.
> 
> Then, how do you suggest proceeding on it?  Without a bus tracer, we
> can't easily tell what Windows is doing and on native SATA skipping
> SETXFER isn't likely to cause any serious problem.  It's basically
> noop.

I would suggest we issue the SETXFER always. If it times out then we will
revalidate the identify data so we can use that to see what mode we are
actually in.

Alan
