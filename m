From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 22:03:09 +0100
Message-ID: <20070928220309.7c9ed816@the-village.bc.nu>
References: <1190521193410-git-send-email-htejun@gmail.com>
	<46F9BF3E.5050708@garzik.org>
	<46FA1B4E.8090103@gmail.com>
	<46FD079F.3010007@garzik.org>
	<46FD0D50.8030602@gmail.com>
	<46FD1C4A.8010101@garzik.org>
	<46FD306C.3050205@gmail.com>
	<46FD5DE1.8000206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52053 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751297AbXI1U5k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 16:57:40 -0400
In-Reply-To: <46FD5DE1.8000206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> Jeff, seeing as Tejun's commitment is never in doubt here,
> I really believe we should go with the existing PMP patchset
> for 2.6.24 (unless the respin happens quickly enough).
> 
> This functionality is way overdue, and we shouldn't be impeding it
> as long as we have been.

I would second this. Its far too important to not get this stuff upstream
and usable NOW. Yes the model will have to change a bit but the entire
libata today has almost no resemblence to the one a year ago.

It can evolve and then the old one can die off just as we did with EH
(except for libsas anyway)

Alan
