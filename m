From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 5 Dec 2007 13:52:46 -0500
Message-ID: <20071205185246.GA24035@havoc.gtf.org>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468202627-git-send-email-htejun@gmail.com> <4755ABB3.6030907@garzik.org> <4755FB90.50505@gmail.com> <20071205124713.4d31c5e7@the-village.bc.nu> <4756A1AE.4010205@gmail.com> <20071205140119.532c1eb4@the-village.bc.nu> <4756B415.404@gmail.com> <20071205144649.4bca7a3c@the-village.bc.nu> <4756C00E.3060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:51567 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbXLESwv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 13:52:51 -0500
Content-Disposition: inline
In-Reply-To: <4756C00E.3060100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

On Thu, Dec 06, 2007 at 12:13:18AM +0900, Tejun Heo wrote:
> Alan Cox wrote:
> >> It eventually has to end up in -rc.  If not for 2.6.25-rc1 is too early,
> >> we can put it in #testing and put it into #upstream later.
> > 
> > Nobody cares about libata git trees. If you want some initial test
> > coverage put it in -mm.

99% incorrect.


> #for-testing ends up in #ALL which Andrew always includes in -mm.
> #upstream also ends up in #ALL but is different in that it will get into
> mainline when the next -rc1 opens.  Jeff, right?

100% correct.

	Jeff



