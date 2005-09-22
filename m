From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Thu, 22 Sep 2005 13:57:25 -0400
Message-ID: <4332F085.9060909@pobox.com>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>	 <20050922061849.GJ7929@suse.de>	 <1127398679.18840.84.camel@localhost.localdomain>	 <20050922135607.GK4262@suse.de> <1127399409.18840.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41390 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbVIVR5e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2005 13:57:34 -0400
In-Reply-To: <1127399409.18840.95.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Joshua Kwan <joshk@triplehelix.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Alan Cox wrote:
> SCSI suspend should not be blocking SATA suspend. If SCSI isn't with the
> program yet then SCSI should just not support suspend while allowing
> SATA to do so.

Jens' patch updates the SCSI layer -- as is proper and needed.

Someone needs to take Jens patch to linux-scsi as Christoph mentioned, 
maybe there is a change in the wind...

	Jeff


