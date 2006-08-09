From: Mark Lord <liml@rtr.ca>
Subject: Re: Merging libata PATA support into the base kernel
Date: Wed, 09 Aug 2006 16:16:08 -0400
Message-ID: <44DA4288.6020806@rtr.ca>
References: <1155144599.5729.226.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:63428 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751351AbWHIUQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 16:16:09 -0400
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Jeff (rightly) thinks the plan should be discussed publically, so here
> is the plan
> 
> For 2.6.19 to move the libata drivers to drivers/ata
> Add a subset of the new PATA drivers living in -mm to the base kernel
> 
> Many of the new libata drivers are already more stable and functional
> than the drivers/ide ones. 
..
> At this point in time it is premature to discuss or plan the point at
> which the old IDE layer would go away. That discussion can start at the
> point where everyone is happy that the new libata based layer is
> providing better quality and coverage than the old one. Even then there
> would be no need to hurry.

As creator of the ancient IDE subsystem, I agree --> it is time to get
the next generation code upstream.

This will also allow time for things like "udev" to perhaps think about
an option to someday provide /dev/hd* symlinks for PATA devices when
libata is used instead of IDE (?).  That might be a possible migration
path in the far future.

Cheers! 
