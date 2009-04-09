From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 08:50:10 -0400
Message-ID: <49DDEF02.7090004@garzik.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36397 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760909AbZDIMuO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 08:50:14 -0400
In-Reply-To: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Something like this then ?
> 
> 
> The legacy old IDE API for this is a bit primitive so we try and map stuff
> sensibly onto it.
> 
> - Add flags2 as we ran out of flags
> - Set PIO over DMA devices to report 32bit
> - Add ability to change the PIO32 settings if the controller permits it
> - Add that functionality into the sff drivers
> - Add that functionality into the VLB legacy driver
> - Turn on the 32bit PIO on the ninja32 and add support there
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I think the flag2 stuff needs a closer look WRT driver setup, but 
overall looks good.

Consider it ACK'd, if I cannot come up with anything better for flags2 :)

	Jeff




