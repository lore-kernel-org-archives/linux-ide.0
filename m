From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Wed, 31 Oct 2007 12:49:08 +0000
Message-ID: <20071031124908.19de7833@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
	<20071030153417.59b9182c@the-village.bc.nu>
	<47276DCA.1000808@gentoo.org>
	<20071030190153.373c9347@the-village.bc.nu>
	<47278439.4030801@gentoo.org>
	<20071031114958.210bd7cc@the-village.bc.nu>
	<20071031115754.GK5059@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40530 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755635AbXJaMsw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 08:48:52 -0400
In-Reply-To: <20071031115754.GK5059@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> > Would need to double check the SCSI specificatons to be sure but I think
> > you are asking for less data than the drive wishes to provide. You
> > aren't allowed to do that with ATA.
> 
> ide-cd handles this by throwing the excess away, which I think is the
> sane way to do this.

It also fails for some cases because the controller snoops the length
information in the packet command.

Alan
