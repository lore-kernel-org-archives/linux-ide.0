From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Thu, 29 Oct 2009 21:47:58 -0400
Message-ID: <4AEA45CE.2060708@garzik.org>
References: <4AE64FCC.4030102@gmail.com>	<20091029.031344.102288703.davem@davemloft.net>	<51f3faa70910291719kecb5edcp3b8812981b69acb1@mail.gmail.com> <20091030003232.6db3f8b8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33956 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbZJ3Br6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Oct 2009 21:47:58 -0400
In-Reply-To: <20091030003232.6db3f8b8@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 10/29/2009 08:32 PM, Alan Cox wrote:
> IDE will self correct in time anyway - new hardware doesn't work with it,
> newer embedded devices are also moving away from compact flash, so it'll
> die of its own accord.
>
> As such while things like pmac support in libata will be nice I don't
> think there is any need to go around obsoleting it or pressuring people
> to move stacks.


This has been my general policy...  people will continue moving away 
from IDE over time.  Not much need to do anything but let sleeping dogs lie.

libata definitely needs pmac support, that is the really only big 
missing driver piece, IMO.

On compatibility:  while a compat ATA block device would be nice -- 
having a native Linux block driver for ATA disks has been a longstanding 
"want" since Day One -- a compat block device purely for these 
situations would be quite a bit of work for a tiny-and-shrinking 
userbase.  And that totally ignores an idea of attempting compatibility 
with IDE's ATAPI setup, another huge can-o-worms.

	Jeff



