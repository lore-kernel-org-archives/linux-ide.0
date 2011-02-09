From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 21:39:04 +0000
Message-ID: <20110209213904.4aff945d@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
	<4D5306F8.6050106@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44707 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751808Ab1BIVfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 16:35:34 -0500
In-Reply-To: <4D5306F8.6050106@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> years ago when libata was written, and certain distributions decided to
> risk breaking compatibility with hardware that runs Windows just fine in
> favor of not breaking upgrades from systems installed with the old ide
> driver that did default to unlocking.

The old IDE driver defaulted to unlocking based upon years of experience
in the real world. Jeff insisted on being different, and surprise
surprise everyone ended up setting distro defaults that were different.

> The discussion at hand is about a change made a few months ago that is a
> good compromise between always unlocking, and never unlocking.  Both of
> those have problems, so a good compromise can have the benefits of both,
> and the drawbacks of neither.  Furthermore, it is already in the kernel,
> so continuing to argue about whether it should have been done or not
> seems a moot point.

I disagree, and again you are still missing the entire point. For the
RAID stuff you don't care if we unlock, you don't need to care if we
unlock. You need to care about getting the raid tools figuring out what
geometry the raid creation was using.

